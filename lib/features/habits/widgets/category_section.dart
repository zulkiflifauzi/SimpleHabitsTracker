import 'package:flutter/material.dart';

import '../../../shared/models/habit_with_status.dart';
import 'habit_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.category,
    required this.habits,
  });

  final String? category;
  final List<HabitWithStatus> habits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (category != null)
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 4),
            child: Text(
              category!.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ...habits.map((h) => HabitCard(habitWithStatus: h)),
      ],
    );
  }
}
