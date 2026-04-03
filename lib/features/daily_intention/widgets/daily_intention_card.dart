import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context_extensions.dart';
import '../providers/daily_intention_provider.dart';
import 'intention_sheet.dart';

class DailyIntentionCard extends ConsumerWidget {
  const DailyIntentionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intention = ref.watch(dailyIntentionProvider);
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openSheet(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                intention != null
                    ? Icons.lightbulb_rounded
                    : Icons.lightbulb_outline_rounded,
                color: scheme.onPrimaryContainer,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: intention != null
                    ? Text(
                        intention,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: scheme.onPrimaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        l10n.intentionPlaceholder,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: scheme.onPrimaryContainer
                                  .withValues(alpha: 0.6),
                              fontStyle: FontStyle.italic,
                            ),
                      ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.edit_rounded,
                size: 16,
                color: scheme.onPrimaryContainer.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const IntentionSheet(),
    );
  }
}
