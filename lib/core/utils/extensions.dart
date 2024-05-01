import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String format() {
    final now = DateTime.now();

    String formattedDate = DateFormat.yMMMEd().format(this);

    //! is same day
    bool isSameDay() {
      if (day == now.day && month == now.month && year == now.year) {
        return true;
      }
      return false;
    }

    //! is yesterday
    bool isYesterday() {
      final yesterday = now.subtract(const Duration(days: 1));

      // Return true if the date is yesterday
      return year == yesterday.year &&
          month == yesterday.month &&
          day == yesterday.day;
    }

    bool isTomorrow() {
      final tomorrow = now.add(const Duration(days: 1));

      // Return true if the date is tomorrow
      return year == tomorrow.year &&
          month == tomorrow.month &&
          day == tomorrow.day;
    }

    // Handle today, yesterday, and tomorrow cases:
    if (isSameDay()) {
      formattedDate = DateFormat.jm().format(this);
    } else if (isYesterday()) {
      formattedDate = 'Yesterday';
    } else if (isTomorrow()) {
      formattedDate = 'Tomorrow';
    }
    // Handle cases within a week or more
    else {
      // Check if date is within the same week:
      final startOfTheWeek = startOfWeek(now);
      final startOfNextWeek = startOfTheWeek.add(const Duration(days: 7));

      // Check if date is within the same week
      if (isAfter(startOfTheWeek) && isBefore(startOfNextWeek)) {
        // Full name of the week 'EEEE'
        formattedDate = DateFormat('EEEE').format(this);
      } else {
        // Include month name for older dates
        formattedDate = DateFormat.yMMMd().format(this);
      }
    }

    return formattedDate;
  }
}

// Helper method to get the start of the week (Monday)
DateTime startOfWeek(DateTime date) {
  final dayOfWeek = date.weekday + 1; // 4 + 1
  return date.subtract(Duration(days: dayOfWeek));
}
