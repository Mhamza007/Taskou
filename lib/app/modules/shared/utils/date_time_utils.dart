class DateTimeUtils {
  /// returns time in hh:mm format from millis
  static String getTimeFromMillis(int millis) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    String hour = '${dateTime.hour}';
    if (hour.length < 2) hour = '0$hour';
    if (hour == '00') hour = '12';
    String minute = '${dateTime.minute}';
    if (minute.length < 2) minute = '0$minute';
    return '$hour:$minute';
  }
}
