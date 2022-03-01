import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextLabelField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;

  const TextLabelField(
      {Key? key,
      required this.controller,
      required this.label,
      this.hintText,
      this.maxLines,
      this.maxLength,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Text(
                label.toUpperCase(),
                style: TextStyle(color: Colors.grey[700]),
              )),
          TextFormField(
            // autofocus: true,
            validator: validator,
            controller: controller,
            maxLines: maxLines ?? 1,
            maxLength: maxLength,
            decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                errorMaxLines: 1),
          ),
        ]));
  }
}
