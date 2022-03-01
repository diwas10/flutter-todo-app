import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/widgets/default_container.dart';
import 'package:todo_app/widgets/text_field.dart';
import '../widgets/custom_scaffold.dart';
import "../utils/format_date_time.dart";
import "../utils/compare_date_time.dart";

class TodoForm extends StatefulWidget {
  final void Function(
          String title, String? desc, DateTime? date, TimeOfDay? time)
      handleSubmitTodo;

  final TodoModel? editData;

  const TodoForm({Key? key, required this.handleSubmitTodo, this.editData})
      : super(key: key);

  @override
  TodoFormState createState() => TodoFormState();
}

class TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final formatDateTime = FormatDateTime();
  final compareDateTime = ComapreDateTime();
  String? dateErrorText;

  @override
  void initState() {
    if (widget.editData != null) {
      final editData = widget.editData;
      setState(() {
        selectedDate = editData?.date;
        selectedTime = editData?.time;
        titleController.text = editData?.title ?? "";
        descController.text = editData?.desc ?? "";
      });
    }
    super.initState();
  }

  _showTimePicker() async {
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime == null ? TimeOfDay.now() : selectedTime!);

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  _showDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate == null ? DateTime.now() : selectedDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      _showTimePicker();
    }
  }

  getDateText() {
    final TextStyle style = TextStyle(fontSize: 18, color: Colors.grey[700]);
    if (selectedDate == null || selectedTime == null) {
      return Text(
        '--:--, YYYY/MM/DD',
        style: style,
      );
    } else {
      return FormatDateTime(
          date: selectedDate, time: selectedTime, style: style);
    }
  }

  Widget _form() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextLabelField(
                controller: titleController,
                label: "title",
                maxLength: 64,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide the title";
                  }
                  return null;
                },
              ),
              TextLabelField(
                controller: descController,
                label: "Description",
                maxLength: 512,
                maxLines: 4,
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Text(
                              "DATE AND TIME",
                              style: TextStyle(color: Colors.grey[700]),
                            )),
                        SizedBox(
                            width: double.infinity,
                            child: InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _showDatePicker();
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                            color: Colors.grey)),
                                    color: Colors.white,
                                    shadowColor: Colors.transparent,
                                    // shape: ,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: getDateText(),
                                    ))))
                      ])),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(13)),
                    child: Text(
                      widget.editData == null ? "Add Task" : "Edit Task",
                      style: const TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      final isValid = _formKey.currentState?.validate();
                      if (!isValid!) return;
                      widget.handleSubmitTodo(titleController.text,
                          descController.text, selectedDate, selectedTime);
                    }),
              )
            ])));
  }

  Widget body() {
    return DefaultContainer(
      child: _form(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: body(),
      title: widget.editData == null ? "Create New Task" : "Edit Task",
      disableLeading: true,
    );
  }
}
