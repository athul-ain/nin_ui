import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:nin_ui/widgets/sheet_dialog_card.dart';

extension StringExtension on String? {
  String? toFirstLetterCapital() {
    if (this == null) {
      return null;
    } else if (this!.isEmpty) {
      return this;
    }
    return '${this![0].toUpperCase()}${this!.substring(1)}';
  }

  String toFirstTwoLetterCapital() {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }
    final names = this!.split(' ');
    if (names.length == 1) {
      return names[0][0].toUpperCase();
    }
    return '${names[0][0].toUpperCase()}${names[1][0].toUpperCase()}';
  }

  String getFirstLetterInCapital() {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }
    return this![0];
  }

  // get DateTime from string
  DateTime? getDateTime() {
    if (this == null) {
      return null;
    } else if (this!.isEmpty) {
      return null;
    }
    return DateTime.tryParse("$this");
  }

  // date format
  String getFormattedDate() {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }
    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return '';
    }
    return DateTimeFormat.format(date, format: 'M d, Y');
  }

  // time format
  String getFormattedTime() {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }
    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return '';
    }
    return DateTimeFormat.format(date, format: 'h:i A');
  }

  // date time format
  String getFormattedDateTime() {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }
    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return '';
    }
    return "${DateTimeFormat.format(date, format: 'M d, Y')} at ${DateTimeFormat.format(date, format: 'h:i A')}";
  }

  // get formatted schedule date
  String getScheduledFormattedDate() {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }

    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return '';
    }
    final today = DateTime.now().toLocal();
    final tomorrow = today.add(const Duration(days: 1)).toLocal();
    final yesterday = today.subtract(const Duration(days: 1)).toLocal();

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return "Today";
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return "Tomorrow";
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return "Yesterday";
    } else if (date.year == today.year) {
      return DateTimeFormat.format(date, format: 'D, d M');
    }

    return DateTimeFormat.format(date, format: 'D, d M, Y');
  }

  // get formatted schedule date time
  String getScheduledFormattedDateTime() {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }

    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return '';
    }
    final today = DateTime.now().toLocal();
    final tomorrow = today.add(const Duration(days: 1)).toLocal();
    final yesterday = today.subtract(const Duration(days: 1)).toLocal();

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day &&
        date.hour == today.hour &&
        date.minute == today.minute) {
      return "Now";
    } else if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return "Today at ${DateTimeFormat.format(date, format: 'h:i A')}";
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return "Tomorrow at ${DateTimeFormat.format(date, format: 'h:i A')}";
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return "Yesterday at ${DateTimeFormat.format(date, format: 'h:i A')}";
    } else if (date.year == today.year) {
      return "${DateTimeFormat.format(date, format: 'D, d M')} at ${DateTimeFormat.format(date, format: 'h:i A')}";
    }

    return "${DateTimeFormat.format(date, format: 'D, d M, Y')} at ${DateTimeFormat.format(date, format: 'h:i A')}";
  }

  Color? getScheduleTimeColor(ColorScheme colorScheme) {
    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return null;
    }
    return date.isToday()
        ? date.isPastTime()
            ? colorScheme.onErrorContainer
            : colorScheme.primary
        : date.isPastDay()
            ? colorScheme.error
            : null;
  }

  // get bool if today
  bool isToday() {
    if (this == null) {
      return false;
    } else if (this!.isEmpty) {
      return false;
    }

    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return false;
    }
    final today = DateTime.now().toLocal();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  // get bool if past date
  bool isPastDate() {
    if (this == null) {
      return false;
    } else if (this!.isEmpty) {
      return false;
    }

    final date = DateTime.tryParse("$this")?.toLocal();
    if (date == null) {
      return false;
    }
    final today = DateTime.now().toLocal();
    return date.isBefore(today);
  }

  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// Returns true if the string is not null or empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  // Returns the <T> enum value from the string.
  T? getEnum<T>(List<T> values) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return null;
    }
    return values.firstWhereOrNull((e) => e.toString().split('.').last == this);
  }

  // clip text to the given length
  String clipText(int length) {
    if (this == null) {
      return '';
    } else if (this!.isEmpty) {
      return '';
    }
    return this!.length > length ? '${this!.substring(0, length)}...' : this!;
  }
}

extension DateTimeExtension on DateTime {
  DateTime today() {
    return DateTime(year, month, day);
  }

  String getFormattedDate() {
    return toIso8601String().getFormattedDate();
  }

  String getFormattedDateTime() {
    return toIso8601String().getFormattedDateTime();
  }

  String getFormattedTime() {
    return toIso8601String().getFormattedTime();
  }

  String getScheduledFormattedDate() {
    return toIso8601String().getScheduledFormattedDate();
  }

  bool isToday() {
    final today = DateTime.now();
    return year == today.year && month == today.month && day == today.day;
  }

  bool isPastTime() {
    final today = DateTime.now();
    return isBefore(today);
  }

  bool isPastDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return isBefore(today);
  }
}

extension ColorExtension on Color {
  Color get foregroundColorBW {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

enum ContentLoadingStatus { initial, loading, refreshing, completed, error }

extension ContentLoadingStatusExtension on ContentLoadingStatus {
  bool get isLoading => (this == ContentLoadingStatus.loading ||
      this == ContentLoadingStatus.initial);
  bool get isRefreshing => this == ContentLoadingStatus.refreshing;
  bool get isCompleted => this == ContentLoadingStatus.completed;
  bool get isError => this == ContentLoadingStatus.error;
  bool get needLoading => (this == ContentLoadingStatus.initial ||
      this == ContentLoadingStatus.error);
}

extension ListExtension<T> on List<T> {
  List<T> get copy => List<T>.from(this);

  T? firstWhereOrNull(bool Function(T element) test, {T Function()? orElse}) {
    for (T element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }
}

extension WidgetExtension on Widget {
  Future<T?> showSheetDialog<T>(BuildContext context, {String? title}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierLabel: title,
      builder: (BuildContext context) => SheetDialogCard(
        child: this,
      ),
    );
  }

  Future<T?> showBottomSheet<T>(BuildContext context, {String? title}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierLabel: title,
      builder: (BuildContext context) => this,
    );
  }
}
