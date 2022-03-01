import 'package:flutter/material.dart';
import '../widgets/todo_item_container.dart';

class DismissableWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissableWidget(
      {Key? key,
      required this.item,
      required this.child,
      required this.onDismissed})
      : super(key: key);

  _enddismissableBg() {
    return TodoItemContainer(
      bgColor: Colors.red[500],
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 32,
      ),
      alignment: Alignment.centerRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        // borderRadius: BorderRadius.circular(20),
        child: Dismissible(
      key: ObjectKey(item),
      child: child,
      background: _enddismissableBg(),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
    ));
  }
}
