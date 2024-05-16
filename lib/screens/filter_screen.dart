import 'package:flutter/material.dart';
import 'package:meal_deal_app/model/filter_operations.dart';
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
  List<String> _selectedRestaurants = [];
  List<String> _selectedLocations = [];

  //List? selectedPriceRange;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
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
                FilterWidget(
                  filterItems: categories,
                  filterName: "Category",
                  selectedItems: _selectedCategories,
                  onSelectionChanged: (isSelected, item) {
                    setState(() {
                      if (isSelected) {
                        _selectedCategories.add(item);
                      } else {
                        _selectedCategories.remove(item);
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FilterWidget(
                  filterItems: restaurants,
                  filterName: "Restaurant",
                  selectedItems: _selectedRestaurants,
                  onSelectionChanged: (isSelected, item) {
                    setState(() {
                      if (isSelected) {
                        _selectedRestaurants.add(item);
                      } else {
                        _selectedRestaurants.remove(item);
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FilterWidget(
                  filterItems: locations,
                  filterName: "Location",
                  selectedItems: _selectedLocations,
                  onSelectionChanged: (isSelected, item) {
                    setState(() {
                      if (isSelected) {
                        _selectedLocations.add(item);
                      } else {
                        _selectedLocations.remove(item);
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                // //виджет с ценой
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: EdgeInsets.all(20),
                //     //виджет для заголовков
                //     child: FilterTitle("Price €"),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(left: 20),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Container(
                //       child: Wrap(spacing: 10, runSpacing: 3, children: [
                //         FilterChipWidget(chipName: "0 - 4"),
                //         FilterChipWidget(chipName: "5 - 9"),
                //         FilterChipWidget(chipName: "10 - 15"),
                //         FilterChipWidget(chipName: "> 15"),
                //       ]),
                //     ),
                //   ),
                // ),
              ],
            ),
          )),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Color(0xFF62BD5C),
                      ),
                      onPressed: () {
                        List<List<String>> arguments = [];

                        if (_selectedCategories.isNotEmpty ||
                            _selectedRestaurants.isNotEmpty ||
                            _selectedLocations.isNotEmpty) {
                          arguments = [
                            _selectedCategories,
                            _selectedRestaurants,
                            _selectedLocations
                          ];
                        }

                        Navigator.pushNamed(context, "/menu",
                            arguments: arguments);
                      },
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
