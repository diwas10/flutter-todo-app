import 'package:flutter/material.dart';

typedef ValueChanged<T> = void Function(T value);

class DropdownModel {
  final String label;
  final dynamic value;

  DropdownModel({
    required this.label,
    required this.value,
  });
}

class CustomDropdown<T> extends StatelessWidget {
  final String dropdownValue;
  final ValueChanged onChanged;
  final List<DropdownModel> items;

  const CustomDropdown(
      {Key? key,
      required this.dropdownValue,
      required this.items,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(
        Icons.filter_alt_outlined,
        color: Theme.of(context).primaryColor,
      ),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: onChanged,
      style: TextStyle(color: Theme.of(context).primaryColor),
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value.value,
          child: Text(value.label),
        );
      }).toList(),
    );
  }
}
