import 'package:flutter/material.dart';

class ComapreDateTime {
  bool compareDate(DateTime initialDate, DateTime finalDate) {
    return finalDate.isAfter(initialDate);
  }

  bool compareTime(TimeOfDay initialTime, TimeOfDay finalTime) {
    double time = initialTime.hour + initialTime.minute / 60.0;
    double fTime = finalTime.hour + finalTime.minute / 60.0;
    return time <= fTime;
  }

  bool compareDateTime(DateTime initialDate, DateTime finalDate,
      TimeOfDay initialTime, TimeOfDay finalTime) {
    final date = compareDate(initialDate, finalDate);
    final time = compareTime(initialTime, finalTime);

    if (date) {
      return date;
    } else {
      return time && date;
    }
  }
}
