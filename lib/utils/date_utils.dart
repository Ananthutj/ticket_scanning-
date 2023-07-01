class DateUtils {
  final int day;
  final String month;
  final int year;

  DateUtils({required this.day, required this.month, required this.year});

  String getFormattedDate() {
    return '$day $month, $year';
  }
}