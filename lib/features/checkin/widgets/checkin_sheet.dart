import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/providers/core_providers.dart';
import '../../../shared/models/habit_with_status.dart';

class CheckinSheet extends ConsumerStatefulWidget {
  const CheckinSheet({super.key, required this.habitWithStatus});

  final HabitWithStatus habitWithStatus;

  @override
  ConsumerState<CheckinSheet> createState() => _CheckinSheetState();
}

class _CheckinSheetState extends ConsumerState<CheckinSheet> {
  final _valueCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _boolCompleted = false;

  Habit get habit => widget.habitWithStatus.habit;

  @override
  void initState() {
    super.initState();
    final existing = widget.habitWithStatus.todayCheckIn;
    if (existing != null) {
      _boolCompleted = existing.completed;
      if (existing.value != null) {
        final v = existing.value!;
        _valueCtrl.text =
            v == v.truncate() ? v.toInt().toString() : v.toString();
      }
      _noteCtrl.text = existing.note ?? '';
    }
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final type = habit.completionType;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(habit.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                l10n.logForToday,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const SizedBox(height: 20),

              if (type == 'boolean')
                _BooleanInput(
                  value: _boolCompleted,
                  onChanged: (v) => setState(() => _boolCompleted = v),
                ),
              if (type == 'numeric')
                _NumericInput(controller: _valueCtrl, unit: habit.unit),
              if (type == 'duration')
                _DurationInput(controller: _valueCtrl),

              const SizedBox(height: 16),

              TextField(
                controller: _noteCtrl,
                decoration: InputDecoration(
                  labelText: l10n.noteOptional,
                  hintText: l10n.noteHint,
                  border: const OutlineInputBorder(),
                  suffixIcon: _noteCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(_noteCtrl.clear),
                        )
                      : null,
                ),
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: Text(l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    final type = habit.completionType;
    bool completed;
    double? value;

    if (type == 'boolean') {
      completed = _boolCompleted;
    } else {
      final raw = double.tryParse(_valueCtrl.text.trim());
      if (raw == null || raw <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.invalidValue)),
        );
        return;
      }
      value = raw;
      completed = true;
    }

    final today = DateTime.now();
    final dateOnly = DateTime(today.year, today.month, today.day);

    await ref.read(databaseProvider).checkInsDao.upsertCheckIn(
          CheckInsCompanion(
            habitId: Value(habit.id),
            date: Value(dateOnly),
            completed: Value(completed),
            value: Value(value),
            note: Value(_noteCtrl.text.trim().isEmpty
                ? null
                : _noteCtrl.text.trim()),
          ),
        );

    if (mounted) Navigator.of(context).pop();
  }
}

class _BooleanInput extends StatelessWidget {
  const _BooleanInput({required this.value, required this.onChanged});
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: value
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              value
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked,
              color: value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              value
                  ? context.l10n.completedLabel
                  : context.l10n.markAsDone,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _NumericInput extends StatelessWidget {
  const _NumericInput({required this.controller, this.unit});
  final TextEditingController controller;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: InputDecoration(
        labelText: context.l10n.amount,
        suffixText: unit,
        border: const OutlineInputBorder(),
      ),
      autofocus: true,
    );
  }
}

class _DurationInput extends StatelessWidget {
  const _DurationInput({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: context.l10n.durationLabel,
        suffixText: context.l10n.minutes,
        border: const OutlineInputBorder(),
      ),
      autofocus: true,
    );
  }
}
