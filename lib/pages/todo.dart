import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/todo_model.dart';
import '../widgets/dropdown.dart';
import "../utils/format_date_time.dart";
import "../utils/compare_date_time.dart";

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  TodoState createState() => TodoState();
}

class TodoState extends State<Todos> {
  final List<TodoModel> _todos = [];
  List<TodoModel> _filteredTodos = [];
  final primaryColor = Colors.purple[900];
  final textFieldController = TextEditingController();
  String dialogHeading = "Add Todo";
  final List<DropdownModel> _filterItems = [
    DropdownModel(label: "All", value: "all"),
    DropdownModel(label: "Completed", value: "completed"),
    DropdownModel(label: "Incomplete", value: "incomplete"),
  ];
  String dropdownValue = "incomplete";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final formatDateTime = FormatDateTime();
  final compareDateTime = ComapreDateTime();

  @override
  void initState() {
    filterTodos(dropdownValue);
    super.initState();
  }

  Widget _todoItem(TodoModel todo) {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                          formatDateTime.formatDateTime(todo.date, todo.time),
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[500]))),
                ],
              )
            ],
          ),
          Row(children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.purple),
              onPressed: () {
                dialogHeading = "Edit Todo";
                textFieldController.text = todo.title;
                setState(() {
                  selectedDate = todo.date;
                  selectedTime = todo.time;
                });
                _showTodoDialog(todo.id);
              },
              padding: const EdgeInsets.all(0),
              tooltip: "Edit",
            ),
            IconButton(
              icon: Icon(
                  todo.isDone
                      ? Icons.cancel_outlined
                      : Icons.check_box_outlined,
                  color: Colors.green),
              onPressed: () {
                setState(() {
                  final _todoIndex =
                      _todos.indexWhere((element) => element.id == todo.id);

                  _todos[_todoIndex].date = DateTime.now();
                  _todos[_todoIndex].isDone =
                      _todos[_todoIndex].isDone ? false : true;
                });
                filterTodos(dropdownValue);
              },
              padding: const EdgeInsets.all(0),
              tooltip: todo.isDone ? "Completed" : "Incomplete",
            )
          ])
        ]),
        decoration: BoxDecoration(
          color: todo.isDone
              ? Colors.green[50]
              : compareDateTime.compareDateTime(
                      todo.date, DateTime.now(), todo.time, TimeOfDay.now())
                  ? Colors.red[100]
                  : Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.purple.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 7))
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ));
  }

  Widget _todoList() {
    if (_filteredTodos.isEmpty) {
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              dropdownValue == "completed"
                  ? "No Completed Task"
                  : "Hurray No Todos.",
              style: TextStyle(fontSize: 18, color: primaryColor),
              textAlign: TextAlign.center,
            )),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              dropdownValue == "completed"
                  ? "Common get up and complete your task. Time is valuables"
                  : "Start Adding Todos to remember your tasks",
              style: TextStyle(fontSize: 16, color: primaryColor),
              textAlign: TextAlign.center,
            )),
      ]));
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: _filteredTodos.length,
        itemBuilder: (context, item) {
          return _todoItem(_filteredTodos[item]);
        },
        key: UniqueKey(),
      );
    }
  }

  Widget _filterTodo() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CustomDropdown(
            items: _filterItems,
            dropdownValue: dropdownValue,
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue.toString();
              });
              filterTodos(newValue.toString());
            },
          ))
    ]);
  }

  Widget _buildHome() {
    return Column(children: [
      _filterTodo(),
      Expanded(
        child: _todoList(),
      )
    ]);
  }

  void filterTodos(String value) {
    setState(() {
      switch (value) {
        case "completed":
          _filteredTodos =
              _todos.where((element) => element.isDone == true).toList();
          break;
        case "incomplete":
          _filteredTodos =
              _todos.where((element) => element.isDone == false).toList();
          return;
        default:
          _filteredTodos = _todos;
      }
    });
  }

  Widget _floatingIcon() {
    return FloatingActionButton.extended(
        onPressed: () {
          _showTodoDialog(0);
          dialogHeading = "Add Todo";
        },
        icon: const Icon(Icons.add),
        backgroundColor: primaryColor,
        label: const Text("Add"));
  }

  _showTimePicker() async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime);

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  _showDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2022));

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      _showTimePicker();
    }
  }

  _showTodoDialog(int id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    dialogHeading,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                TextField(
                  autofocus: true,
                  controller: textFieldController,
                  decoration: InputDecoration(
                      hintText: "Type...",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusColor: primaryColor),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                              "Date${": " + formatDateTime.formatDateTime(selectedDate, selectedTime)}"),
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  color: Colors.purpleAccent, fontSize: 18)),
                          onPressed: () {
                            _showDatePicker();
                          },
                        ))),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    width: 2, color: Colors.purple)),
                            onPressed: () {
                              textFieldController.clear();
                              Navigator.pop(context);
                              setState(() {
                                selectedDate = DateTime.now();
                                selectedTime = TimeOfDay.now();
                              });
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                if (textFieldController.text != "") {
                                  if (id != 0) {
                                    setState(() {
                                      final _todo = _todos.indexWhere(
                                          (element) => element.id == id);
                                      _todos[_todo].title =
                                          textFieldController.text;
                                      _todos[_todo].date = selectedDate;
                                      _todos[_todo].time = selectedTime;
                                    });
                                  } else {
                                    setState(() {
                                      _todos.add(TodoModel(
                                          date: selectedDate,
                                          time: selectedTime,
                                          isDone: false,
                                          title: textFieldController.text,
                                          id: _todos.length + 1));
                                    });
                                  }
                                  filterTodos(dropdownValue);
                                  textFieldController.clear();
                                  setState(() {
                                    selectedDate = DateTime.now();
                                    selectedTime = TimeOfDay.now();
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ))
                        ]))
                // ])
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        backgroundColor: Colors.purple[900],
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.today))
        ],
      ),
      body: _buildHome(),
      floatingActionButton: _floatingIcon(),
    );
  }
}
