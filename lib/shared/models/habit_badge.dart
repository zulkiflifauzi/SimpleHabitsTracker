enum BadgeType {
  firstStep,
  weekWarrior,
  fortnight,
  monthlyMaster,
  centuryStreak,
  yearOfHabit,
  dedicated,
  centuryClub,
}

class HabitBadge {
  const HabitBadge({
    required this.type,
    required this.emoji,
    required this.earned,
  });

  final BadgeType type;
  final String emoji;
  final bool earned;
}
