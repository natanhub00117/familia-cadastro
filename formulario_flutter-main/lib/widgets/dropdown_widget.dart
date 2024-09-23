import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String label;
  final List<String> items;

  const DropdownWidget({super.key, required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(value),
              ),
            ),
          );
        }).toList(),
        onChanged: (newValue) {},
        dropdownColor: Colors.white,
      ),
    );
  }
}
