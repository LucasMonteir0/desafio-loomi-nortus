import "package:intl/intl.dart";

extension DateExtension on DateTime {
  String toDateAndTime() {
    final date = DateFormat("dd/MM/yyyy às HH:mm").format(this);
    return date;
  }
}
