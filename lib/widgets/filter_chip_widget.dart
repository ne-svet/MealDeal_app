import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  //название чипсы

  final String chipName;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const FilterChipWidget({
    Key? key,
    required this.chipName,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      //название чипсов
      label: Text(chipName),
      labelStyle: TextStyle(
          fontSize: 16, color: isSelected ? Colors.white : Colors.black),
      checkmarkColor: Colors.white,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      selected: isSelected,
      backgroundColor: Colors.grey[300],
      onSelected: onSelected,
      selectedColor: Color(0xFF62BD5C),
    );
  }
}
