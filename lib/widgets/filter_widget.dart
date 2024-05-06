import 'package:flutter/material.dart';

import 'filter_chip_widget.dart';
import 'filter_title.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget(
      {super.key, required this.categories, required this.filterName});

  final Set<String> categories;
  final String filterName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(20),
            //виджет для заголовков
            child: FilterTitle(filterName),
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
                children: categories.map((category) {
                  return FilterChipWidget(chipName: category);
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
