import 'package:flutter/material.dart';
import 'package:rent_tech/utils/route_generator.dart';
import 'package:rent_tech/UI/appthemedata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Tech',

      theme: CustomTheme.lightTheme,

      initialRoute: '/',

      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}