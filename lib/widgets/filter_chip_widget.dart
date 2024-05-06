import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  //название чипсы
  final String chipName;

  const FilterChipWidget({super.key, required this.chipName});

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      //название чипсов
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        fontSize: 16,
      ),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      selected: _isSelected,
      backgroundColor: Colors.grey[300],
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color(0xFF62BD5C),
    );
  }
}
