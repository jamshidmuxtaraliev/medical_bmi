import 'package:flutter/material.dart';
import 'package:medical_bmi/screen/home/home_page.dart';
import 'package:medical_bmi/screen/login/login_page.dart';
import 'package:medical_bmi/utility/color_utility.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(getColorHexFromStr("#11C9C4")),
        indicatorColor: Color(getColorHexFromStr("#ffffff")),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
      },
      home: LoginPage(),
    );
  }
}
