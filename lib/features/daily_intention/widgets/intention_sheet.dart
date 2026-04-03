import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context_extensions.dart';
import '../providers/daily_intention_provider.dart';

class IntentionSheet extends ConsumerStatefulWidget {
  const IntentionSheet({super.key});

  @override
  ConsumerState<IntentionSheet> createState() => _IntentionSheetState();
}

class _IntentionSheetState extends ConsumerState<IntentionSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(dailyIntentionProvider);
    _controller = TextEditingController(text: existing ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final existing = ref.watch(dailyIntentionProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Row(
            children: [
              Icon(Icons.lightbulb_rounded,
                  color: scheme.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                l10n.intentionTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Text field
          TextField(
            controller: _controller,
            autofocus: true,
            maxLines: 4,
            minLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: l10n.intentionHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Actions
          Row(
            children: [
              if (existing != null)
                TextButton.icon(
                  onPressed: () async {
                    await ref
                        .read(dailyIntentionProvider.notifier)
                        .clearIntention();
                    if (context.mounted) Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.intentionClear),
                  style: TextButton.styleFrom(
                    foregroundColor: scheme.error,
                  ),
                ),
              const Spacer(),
              FilledButton(
                onPressed: () async {
                  final text = _controller.text.trim();
                  if (text.isEmpty) return;
                  await ref
                      .read(dailyIntentionProvider.notifier)
                      .setIntention(text);
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(l10n.intentionSave),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
