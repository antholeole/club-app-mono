List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

String toDisplayDateTime(DateTime time) {
  int hour;
  String ampm;

  if (time.hour > 12) {
    hour = time.hour - 12;
    ampm = 'PM';
  } else {
    hour = time.hour;
    ampm = 'AM';
  }

  return '${months[time.month - 1]} ${time.day}, at ${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $ampm';
}
