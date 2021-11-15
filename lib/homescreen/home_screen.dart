import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';
import 'package:rent_tech/display_all_products/allproducts.dart';
import 'package:rent_tech/productScreens/accessoriesForRent.dart';
import 'package:rent_tech/productScreens/desktopsForRent.dart';
import 'package:rent_tech/productScreens/laptopsForRent.dart';
import 'package:rent_tech/display_all_products/upload_product.dart';
import 'package:rent_tech/homescreen/scoll_products.dart';
import 'package:rent_tech/display_all_products/rentedscreen.dart';
import 'package:rent_tech/homescreen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentIndex].currentState!.maybePop();

        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Tech to Rent",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: Text(
                'logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.lightBlueAccent,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.border_all_rounded), label: 'All Products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle), label: 'Add Product'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Rented'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
            _buildOffstageNavigator(4),
          ],
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          ProductTypes(),
          AllProducts(),
          uploadProduct(),
          rentedproducts(),
          userSettings(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}

//
// []-[Page3]
// [AllProducts] 