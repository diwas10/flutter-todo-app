import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import "../utils/format_date_time.dart";
import "../utils/compare_date_time.dart";

class TodoDetailDialog extends StatelessWidget {
  final TodoModel? editData;

  TodoDetailDialog({Key? key, required this.editData}) : super(key: key);

  final formatDateTime = FormatDateTime();
  final compareDateTime = ComapreDateTime();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(editData?.title ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: FormatDateTime(
                        date: editData?.date,
                        time: editData?.time,
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey[500])),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.circle,
                            color: editData?.isDone == true
                                ? Colors.green[500]
                                : compareDateTime.compareDateTime(
                                        editData?.date,
                                        DateTime.now(),
                                        editData?.time,
                                        TimeOfDay.now())
                                    ? Colors.red[500]
                                    : Theme.of(context).primaryColor,
                            size: 16,
                          ),
                        ),
                        Text(
                          editData?.isDone == true
                              ? "Completed"
                              : compareDateTime.compareDateTime(
                                      editData?.date,
                                      DateTime.now(),
                                      editData?.time,
                                      TimeOfDay.now())
                                  ? "Missed"
                                  : "Incomplete",
                          style: TextStyle(
                              color: editData?.isDone == true
                                  ? Colors.green[500]
                                  : compareDateTime.compareDateTime(
                                          editData?.date,
                                          DateTime.now(),
                                          editData?.time,
                                          TimeOfDay.now())
                                      ? Colors.red[500]
                                      : Theme.of(context).primaryColor,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        editData?.desc ?? "",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      )),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(13)),
                        child: const Text(
                          "Close",
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  )
                ])));
  }
}
