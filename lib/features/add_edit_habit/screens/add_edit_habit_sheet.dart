import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/app_database.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/providers/core_providers.dart';

const _kAccentColors = [
  Color(0xFF6750A4),
  Color(0xFF0078D4),
  Color(0xFF107C10),
  Color(0xFFD83B01),
  Color(0xFFE3008C),
  Color(0xFF00B4D8),
  Color(0xFFFFA500),
];

class AddEditHabitSheet extends ConsumerStatefulWidget {
  const AddEditHabitSheet({super.key, this.existingHabit});

  final Habit? existingHabit;

  @override
  ConsumerState<AddEditHabitSheet> createState() => _AddEditHabitSheetState();
}

class _AddEditHabitSheetState extends ConsumerState<AddEditHabitSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _unitCtrl = TextEditingController();

  String? _category;
  String _completionType = 'boolean';
  bool _isOngoing = true;
  DateTime? _targetDate;
  TimeOfDay? _reminderTime;
  bool _gracePeriodEnabled = false;
  Color _accentColor = _kAccentColors.first;

  bool get _isEditing => widget.existingHabit != null;

  List<String> _categories(BuildContext context) => [
        context.l10n.categoryHealth,
        context.l10n.categoryWork,
        context.l10n.categoryPersonal,
        context.l10n.categoryFinance,
        context.l10n.categoryLearning,
        context.l10n.categorySocial,
        context.l10n.categoryOther,
      ];

  @override
  void initState() {
    super.initState();
    final h = widget.existingHabit;
    if (h != null) {
      _nameCtrl.text = h.name;
      _unitCtrl.text = h.unit ?? '';
      _category = h.category;
      _completionType = h.completionType;
      _isOngoing = h.isOngoing;
      _targetDate = h.targetDate;
      _gracePeriodEnabled = h.gracePeriodEnabled;
      if (h.accentColor != null) _accentColor = Color(h.accentColor!);
      if (h.reminderTime != null) {
        final parts = h.reminderTime!.split(':');
        _reminderTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _unitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
                child: Row(
                  children: [
                    Text(
                      _isEditing ? l10n.editHabit : l10n.newHabit,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    if (_isEditing)
                      IconButton(
                        icon: const Icon(Icons.archive_outlined),
                        tooltip: l10n.archiveHabit,
                        onPressed: _archiveHabit,
                      ),
                    TextButton(
                      onPressed: _save,
                      child: Text(l10n.save),
                    ),
                  ],
                ),
              ),
              const Divider(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                  children: [
                    // Name
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: InputDecoration(
                        labelText: '${l10n.habitName} *',
                        hintText: l10n.habitNameHint,
                        border: const OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.habitNameRequired
                          : null,
                    ),
                    const SizedBox(height: 20),

                    // Category
                    _SectionLabel(l10n.category),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _categories(context).map((cat) {
                        final selected = _category == cat;
                        return FilterChip(
                          label: Text(cat),
                          selected: selected,
                          onSelected: (_) => setState(
                            () => _category = selected ? null : cat,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Completion type
                    _SectionLabel(l10n.howTrack),
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: 'boolean',
                          label: Text(l10n.trackDone),
                          icon: const Icon(Icons.check_circle_outline),
                        ),
                        ButtonSegment(
                          value: 'numeric',
                          label: Text(l10n.trackCount),
                          icon: const Icon(Icons.numbers),
                        ),
                        ButtonSegment(
                          value: 'duration',
                          label: Text(l10n.trackDuration),
                          icon: const Icon(Icons.timer_outlined),
                        ),
                      ],
                      selected: {_completionType},
                      onSelectionChanged: (s) =>
                          setState(() => _completionType = s.first),
                    ),
                    if (_completionType == 'numeric') ...[
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _unitCtrl,
                        decoration: InputDecoration(
                          labelText: l10n.unit,
                          hintText: l10n.unitHint,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Mode
                    _SectionLabel(l10n.mode),
                    SwitchListTile.adaptive(
                      title: Text(
                          _isOngoing ? l10n.modeOngoing : l10n.modeGoalBound),
                      subtitle: Text(_isOngoing
                          ? l10n.modeOngoingDesc
                          : l10n.modeGoalBoundDesc),
                      value: _isOngoing,
                      onChanged: (v) => setState(() {
                        _isOngoing = v;
                        if (v) _targetDate = null;
                      }),
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (!_isOngoing) ...[
                      const SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.flag_outlined),
                        title: Text(
                          _targetDate != null
                              ? l10n.targetDateLabel(
                                  DateFormat('d MMM yyyy', locale)
                                      .format(_targetDate!))
                              : l10n.setTargetDate,
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: _pickTargetDate,
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Reminder
                    _SectionLabel(l10n.dailyReminder),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.notifications_outlined),
                      title: Text(
                        _reminderTime != null
                            ? _reminderTime!.format(context)
                            : l10n.noReminder,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_reminderTime != null)
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () =>
                                  setState(() => _reminderTime = null),
                            ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: _pickReminderTime,
                    ),
                    const SizedBox(height: 12),

                    // Grace period
                    SwitchListTile.adaptive(
                      title: Text(l10n.gracePeriod),
                      subtitle: Text(l10n.gracePeriodDesc),
                      value: _gracePeriodEnabled,
                      onChanged: (v) =>
                          setState(() => _gracePeriodEnabled = v),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 20),

                    // Color
                    _SectionLabel(l10n.color),
                    Wrap(
                      spacing: 10,
                      children: _kAccentColors.map((color) {
                        final selected = _accentColor == color;
                        return GestureDetector(
                          onTap: () => setState(() => _accentColor = color),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                              border: selected
                                  ? Border.all(
                                      color: Colors.white,
                                      width: 2.5,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                    )
                                  : null,
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: color.withOpacity(0.5),
                                        blurRadius: 6,
                                      )
                                    ]
                                  : null,
                            ),
                            child: selected
                                ? const Icon(Icons.check,
                                    size: 18, color: Colors.white)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickTargetDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate:
          _targetDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date != null) setState(() => _targetDate = date);
  }

  Future<void> _pickReminderTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? const TimeOfDay(hour: 8, minute: 0),
    );
    if (time != null) setState(() => _reminderTime = time);
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_isOngoing && _targetDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.setTargetDateFirst)),
      );
      return;
    }

    final db = ref.read(databaseProvider);
    final reminderStr = _reminderTime != null
        ? '${_reminderTime!.hour.toString().padLeft(2, '0')}:${_reminderTime!.minute.toString().padLeft(2, '0')}'
        : null;

    final entry = HabitsCompanion(
      name: Value(_nameCtrl.text.trim()),
      category: Value(_category),
      completionType: Value(_completionType),
      unit: Value(_unitCtrl.text.trim().isEmpty
          ? null
          : _unitCtrl.text.trim()),
      isOngoing: Value(_isOngoing),
      targetDate: Value(_targetDate),
      accentColor: Value(_accentColor.value),
      reminderTime: Value(reminderStr),
      gracePeriodEnabled: Value(_gracePeriodEnabled),
    );

    int habitId;
    if (_isEditing) {
      await db.habitsDao
          .updateHabit(entry.copyWith(id: Value(widget.existingHabit!.id)));
      habitId = widget.existingHabit!.id;
    } else {
      habitId = await db.habitsDao.insertHabit(entry);
    }

    try {
      if (reminderStr != null) {
        await NotificationService.instance.scheduleHabitReminder(
          habitId: habitId,
          habitName: _nameCtrl.text.trim(),
          timeHHmm: reminderStr,
        );
      } else {
        await NotificationService.instance.cancelHabitReminder(habitId);
      }
    } catch (_) {
      // Notification scheduling is best-effort; don't block the save flow.
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _archiveHabit() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.archiveHabit),
        content: Text(context.l10n.archiveHabitBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.l10n.navArchive),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      await ref
          .read(databaseProvider)
          .habitsDao
          .archiveHabit(widget.existingHabit!.id);
      try {
        await NotificationService.instance
            .cancelHabitReminder(widget.existingHabit!.id);
      } catch (_) {
        // Notification cancellation is best-effort; don't block the archive flow.
      }
      if (mounted) Navigator.of(context).pop();
    }
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
