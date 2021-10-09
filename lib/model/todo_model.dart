import 'package:flutter/material.dart';

class TodoModel {
  String title;
  bool isDone;
  int id;
  DateTime date;
  TimeOfDay time;

  TodoModel(
      {required this.title,
      required this.isDone,
      required this.id,
      required this.date,
      required this.time});
}
