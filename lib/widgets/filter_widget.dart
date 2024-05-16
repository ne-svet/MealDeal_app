import 'package:flutter/material.dart';

import 'filter_chip_widget.dart';
import 'filter_title.dart';

class FilterWidget extends StatefulWidget {
  final Set<String> filterItems;
  final String filterName;

  // Параметр для хранения выбранных элементов
  final List<String> selectedItems;

  // Callback для изменения состояния выбора
  final void Function(bool, String) onSelectionChanged;

  FilterWidget({
    Key? key,
    required this.filterItems,
    required this.filterName,
    required this.selectedItems, // Добавлен параметр selectedItems
    required this.onSelectionChanged, // Добавлен параметр onSelectionChanged
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(20),
            //виджет для заголовков
            child: FilterTitle(widget.filterName),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Wrap(
                spacing: 10,
                runSpacing: 3,
                children: widget.filterItems.map((category) {
                  return FilterChipWidget(
                    chipName: category,
                    isSelected: widget.selectedItems.contains(category),
                    onSelected: (isSelected) {
                      setState(() {
                        // Вызов колбэка для обновления выбранных элементов
                        widget.onSelectionChanged(isSelected, category);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
