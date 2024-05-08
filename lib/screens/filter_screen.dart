import 'package:flutter/material.dart';
import 'package:meal_deal_app/model/filter_operations.dart';
import 'package:meal_deal_app/widgets/my_bottom_appBar.dart';

import '../widgets/filter_chip_widget.dart';
import '../widgets/filter_title.dart';
import '../widgets/filter_widget.dart';
import '../widgets/green_stripe.dart';
import '../widgets/my_Drawer.dart';
import '../widgets/my_appBar.dart';

class FilterScreen extends StatefulWidget {
  late FilterOperations filterOperations;

  FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Set<String> categories = {};
  Set<String> restaurants = {};
  Set<String> locations = {};

  List<String> _selectedCategories = [];
  List<String> _selectedRestaurants  = [];
  List<String> _selectedLocations  = [];
  List? selectedPriceRange;

  @override
  void initState() {
    super.initState();
    // Инициализация объекта FilterOperations
    widget.filterOperations = FilterOperations();

    // Получаем уникальные категории
    widget.filterOperations.getCategories().then((value) {
      setState(() {
        categories = value.toSet();
      });
    });

    // Получаем уникальные рестораны
    widget.filterOperations.getRestaurants().then((value) {
      setState(() {
        restaurants = value.toSet();
      });
    });

    // Получаем уникальные location
    widget.filterOperations.getLocations().then((value) {
      setState(() {
        locations = value.toSet();
      });
    });

    //заполняе лист с фильтрами
    _selectedCategories = <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      bottomNavigationBar: const MyBottomAppBar(),
      body: Column(
        children: [
          GreenStripe(
            screenName: "Filters",
            screenIcon: null,
            onPressedScreenIcon: null,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                FilterWidget(filterName: "Category", filterItems: categories),
                SizedBox(
                  height: 10,
                ),
                FilterWidget(filterName: "Restaurant", filterItems: restaurants),
                SizedBox(
                  height: 10,
                ),
                FilterWidget(filterName: "Location", filterItems: locations),
                SizedBox(
                  height: 10,
                ),

                //виджет с ценой
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    //виджет для заголовков
                    child: FilterTitle("Price €"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Wrap(spacing: 10, runSpacing: 3, children: [
                        FilterChipWidget(chipName: "0 - 4"),
                        FilterChipWidget(chipName: "5 - 9"),
                        FilterChipWidget(chipName: "10 - 15"),
                        FilterChipWidget(chipName: "> 15"),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
