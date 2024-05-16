import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/menu_item.dart';
import '../provider/menu_item_provider.dart';
import '../widgets/green_stripe.dart';
import '../widgets/menu_item_widget.dart';
import '../widgets/my_Drawer.dart';
import '../widgets/my_appBar.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // Получение аргументов из маршрута
    final List<dynamic>? filters =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
    List<String> selectedCategories = [];
    List<String> selectedRestaurants = [];
    List<String> selectedLocations = [];

    if (filters != null && filters.isNotEmpty) {
      // Разбор аргументов на списки категорий, ресторанов и локаций
      selectedCategories = filters[0]?.cast<String>() ?? [];
      selectedRestaurants = filters[1]?.cast<String>() ?? [];
      selectedLocations = filters[2]?.cast<String>() ?? [];
    }

    final menuItemProvider = Provider.of<MenuItemProvider>(context);

    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GreenStripe(
              screenName: "Menu",
              screenIcon: Icons.filter_list_alt,
              onPressedScreenIcon: () {
                Navigator.pushNamed(context, '/filter');
              },
            ),
            Expanded(
              child: FutureBuilder<List<MenuItem>>(
                //если списки категорий не пустые, то делаем по выборке
                future: (filters != null && filters.isNotEmpty)
                    ? menuItemProvider.getAllDataBySelectedFilters(
                        selectedCategories,
                        selectedRestaurants,
                        selectedLocations)
                    //если пустые, то показываем все
                    : menuItemProvider.getAllMenuItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Menu is empty'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final menuItem = snapshot.data![index];
                        return Column(
                          children: [
                            MenuItemWidget(
                              menuItem: menuItem,
                              menuItemProvider: menuItemProvider,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
