import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../l10n/app_localizations.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final sections = _sections(l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.userGuide),
        scrolledUnderElevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
        itemCount: sections.length,
        itemBuilder: (context, i) => _GuideSection(
          icon: sections[i].icon,
          title: sections[i].title,
          body: sections[i].body,
        ),
      ),
    );
  }

  List<_Section> _sections(AppLocalizations l10n) => [
        _Section(
          icon: Icons.rocket_launch_rounded,
          title: l10n.guideGettingStartedTitle,
          body: l10n.guideGettingStartedBody,
        ),
        _Section(
          icon: Icons.today_rounded,
          title: l10n.guideTodayScreenTitle,
          body: l10n.guideTodayScreenBody,
        ),
        _Section(
          icon: Icons.add_task_rounded,
          title: l10n.guideAddingHabitTitle,
          body: l10n.guideAddingHabitBody,
        ),
        _Section(
          icon: Icons.check_circle_outline_rounded,
          title: l10n.guideCheckInTitle,
          body: l10n.guideCheckInBody,
        ),
        _Section(
          icon: Icons.local_fire_department_rounded,
          title: l10n.guideStreaksTitle,
          body: l10n.guideStreaksBody,
        ),
        _Section(
          icon: Icons.pause_circle_outline_rounded,
          title: l10n.guidePauseTitle,
          body: l10n.guidePauseBody,
        ),
        _Section(
          icon: Icons.lightbulb_outline_rounded,
          title: l10n.guideIntentionTitle,
          body: l10n.guideIntentionBody,
        ),
        _Section(
          icon: Icons.emoji_events_rounded,
          title: l10n.guideDetailBadgesTitle,
          body: l10n.guideDetailBadgesBody,
        ),
        _Section(
          icon: Icons.insights_rounded,
          title: l10n.guideStatsTitle,
          body: l10n.guideStatsBody,
        ),
        _Section(
          icon: Icons.archive_outlined,
          title: l10n.guideArchiveTitle,
          body: l10n.guideArchiveBody,
        ),
        _Section(
          icon: Icons.tune_rounded,
          title: l10n.guideSettingsTitle,
          body: l10n.guideSettingsBody,
        ),
      ];
}

class _Section {
  const _Section({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;
}

class _GuideSection extends StatelessWidget {
  const _GuideSection({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Icon(icon, color: scheme.primary),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: scheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
