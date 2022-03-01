import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatDateTime extends StatelessWidget {
  final DateTime? date;
  final TimeOfDay? time;
  final TextStyle? style;

  const FormatDateTime({Key? key, this.date, this.time, this.style})
      : super(key: key);

  String formatDate() {
    String formattedDate = date == null
        ? ""
        : date!.year.toString() +
            "-" +
            date!.month.toString() +
            "-" +
            date!.day.toString();
    return formattedDate;
  }

  String formatTime(BuildContext context) {
    String formattedTime =
        time!.hour.toString() + ":" + time!.minute.toString();

    return formattedTime;
  }

  String formatDateTime(BuildContext context) {
    String formattedDate =
        date == null ? "" : DateFormat("yMMMMEEEEd").format(date!);
    String formattedTime = time == null
        ? ""
        : MaterialLocalizations.of(context).formatTimeOfDay(time!);

    String formattedDateTime =
        formattedTime == "" ? "" : formattedTime + ", " + formattedDate;

    return formattedDate.isEmpty ? "" : formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDateTime(context),
      style: style,
    );
  }
}
