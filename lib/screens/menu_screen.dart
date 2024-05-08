import 'package:flutter/material.dart';
import 'package:meal_deal_app/provider/menu_item_provider.dart';
import 'package:meal_deal_app/widgets/green_stripe.dart';
import 'package:meal_deal_app/widgets/my_Drawer.dart';
import 'package:meal_deal_app/widgets/my_appBar.dart';
import 'package:provider/provider.dart';

import '../entities/menu_item.dart';
import '../widgets/menu_item_widget.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});



  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  // //контроллер прокрутки. Чтоб при нажатии на ADD, эран был на том же месте
  // ScrollController _controller = ScrollController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //GreenStripe остается на месте без прокрутки
          GreenStripe(
            screenName: "Menu",
            screenIcon: Icons.filter_list_alt,
            onPressedScreenIcon: () {
              Navigator.pushNamed(context, '/filter');
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<List<MenuItem>>(
                  future:
                      Provider.of<MenuItemProvider>(context).getAllMenuItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data!.isNotEmpty) {
                      return Column(
                        children: snapshot.data!.map((menuItem) {
                          Column col = Column(
                            children: [
                              MenuItemWidget(
                                  menuItem: menuItem,
                                  menuItemProvider: Provider.of<MenuItemProvider>(context),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          );
                          return col;
                        }).toList(),
                      );
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Menu is empty'),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        heightFactor: 18,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ],
      )),
    );
  }
}
