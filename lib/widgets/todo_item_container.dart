import 'package:flutter/material.dart';

class TodoItemContainer extends StatelessWidget {
  final Color? bgColor;
  final Widget child;
  final AlignmentGeometry? alignment;
  const TodoItemContainer(
      {Key? key, required this.bgColor, required this.child, this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        alignment: alignment,
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: child);
  }
}
