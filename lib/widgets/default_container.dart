import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  final Widget child;

  const DefaultContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.purple.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 7))
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: child,
        ));
  }
}
