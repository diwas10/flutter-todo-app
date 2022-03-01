import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/default_container.dart';
import '../model/todo_model.dart';
import '../widgets/dropdown.dart';
import '../widgets/dismissable_widget.dart';
import '../widgets/todo_item_container.dart';
import '../widgets/custom_scaffold.dart';
import "../utils/format_date_time.dart";
import "../utils/compare_date_time.dart";
import "./todo_form.dart";
import "./todo_detail_dialog.dart";
import 'package:intl/intl.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  TodoState createState() => TodoState();
}

class TodoState extends State<Todos> {
  final List<TodoModel> _todos = [];
  List<TodoModel> _filteredTodos = [];
  final textFieldController = TextEditingController();
  String dialogHeading = "Add Todo";
  final List<DropdownModel> _filterItems = [
    DropdownModel(label: "All", value: "all"),
    DropdownModel(label: "Completed", value: "completed"),
    DropdownModel(label: "Incomplete", value: "incomplete"),
  ];
  String dropdownValue = "incomplete";
  final formatDateTime = FormatDateTime();
  final compareDateTime = ComapreDateTime();
  TodoModel? editData;

  @override
  void initState() {
    filterTodos(dropdownValue);
    super.initState();
  }

  _setTodoCompleted(TodoModel todo) {
    setState(() {
      final _todoIndex = _todos.indexWhere((element) => element.id == todo.id);
      _todos[_todoIndex].isDone = _todos[_todoIndex].isDone ? false : true;
    });
    filterTodos(dropdownValue);
  }

  _showDetailTodo() {
    return showDialog(
        context: context,
        builder: (context) {
          return TodoDetailDialog(
            editData: editData,
          );
        });
  }

  Widget _todoItem(TodoModel todo) {
    return InkWell(
        onTap: () {
          editData = todo;
          _showDetailTodo();
        },
        // onHorizontalDragStart: (dragStartDetails) {
        //   _setTodoCompleted(todo);
        // },
        child: TodoItemContainer(
          bgColor: todo.isDone
              ? Colors.green[50]
              : compareDateTime.compareDateTime(
                      todo.date, DateTime.now(), todo.time, TimeOfDay.now())
                  ? Colors.red[100]
                  : Colors.white,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: FormatDateTime(
                            date: todo.date,
                            time: todo.time,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[500]))),
                  ],
                ))
              ],
            )),
            Row(children: [
              IconButton(
                icon: Icon(Icons.edit,
                    color: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  setState(() {
                    editData = todo;
                  });

                  _navigateTodoForm();
                },
                padding: const EdgeInsets.all(0),
                tooltip: "Edit",
              ),
              IconButton(
                icon: Icon(
                    todo.isDone
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: Colors.green),
                onPressed: () {
                  _setTodoCompleted(todo);
                },
                padding: const EdgeInsets.all(0),
                tooltip: todo.isDone ? "Completed" : "Incomplete",
              )
            ])
          ]),
        ));
  }

  Widget _todoList() {
    if (_filteredTodos.isEmpty) {
      return DefaultContainer(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/images/task_completed.png",
                              height: 120,
                              color: Theme.of(context).primaryColor),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              _todos.isEmpty
                                  ? "Hurray No Task"
                                  : dropdownValue == "completed"
                                      ? "No Completed Task"
                                      : "Hurray No Task",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              _todos.isEmpty
                                  ? "Start Adding Task to remember your work."
                                  : dropdownValue == "completed"
                                      ? "Common get up and complete your task. Time is valuables"
                                      : "Start Adding Task to remember your work.",
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            )),
                      ]))));
    } else {
      return DefaultContainer(
          child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[700],
            height: 0,
          );
        },
        shrinkWrap: true,
        itemCount: _filteredTodos.length,
        itemBuilder: (context, item) {
          return DismissableWidget(
            item: item,
            child: _todoItem(_filteredTodos[item]),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                final todoItem = _todos[item];
                setState(() {
                  _todos.remove(todoItem);
                });
                filterTodos(dropdownValue);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Todo ${todoItem.title} is deleted.'),
                  dismissDirection: DismissDirection.startToEnd,
                  backgroundColor: Theme.of(context).primaryColor,
                ));
              }
            },
          );
        },
        key: UniqueKey(),
      ));
    }
  }

  Widget _filterTodo() {
    return Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Task List",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              CustomDropdown(
                items: _filterItems,
                dropdownValue: dropdownValue,
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue.toString();
                  });
                  filterTodos(newValue.toString());
                },
              )
            ]));
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

  void _handleSubmitTodo(
      String title, String? desc, DateTime? date, TimeOfDay? time) {
    if (editData != null) {
      setState(() {
        final _todo =
            _todos.indexWhere((element) => element.id == editData?.id);
        _todos[_todo].title = title;
        _todos[_todo].date = date;
        _todos[_todo].time = time;
        _todos[_todo].desc = desc;
      });
    } else {
      setState(() {
        _todos.add(TodoModel(
            date: date,
            time: time,
            isDone: false,
            desc: desc,
            title: title,
            id: _todos.length + 1));
      });
      filterTodos(dropdownValue);
    }
    Navigator.pop(context);
  }

  _navigateTodoForm() {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TodoForm(
                  handleSubmitTodo: _handleSubmitTodo,
                  editData: editData,
                )));
  }

  Widget _floatingIcon() {
    return FloatingActionButton(
      onPressed: () {
        editData = null;
        _navigateTodoForm();
        dialogHeading = "Add Todo";
      },
      child: const Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      drawer: const Drawer(
        elevation: 30,
      ),
      title: "Hello Diwash",
      actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active, size: 30)),
      ],
      body: _buildHome(),
      floatingIcon: _floatingIcon(),
    );
  }
}
