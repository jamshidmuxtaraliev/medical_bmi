import 'package:alice/alice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/screen/home/home_page.dart';
import 'package:medical_bmi/screen/login/login_page.dart';
import 'package:medical_bmi/screen/splash/splash_screen.dart';
import 'package:medical_bmi/utility/color_utility.dart';
import 'package:medical_bmi/utility/pref_utils.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // eventBusProvider();

  runApp(MyApp());
  await PrefUtils.initInstance();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final alice = Alice(showNotification: kDebugMode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: MyApp.alice.getNavigatorKey(),
      theme: ThemeData(
        primaryColor: Color(getColorHexFromStr("#11C9C4")),
        indicatorColor: Color(getColorHexFromStr("#ffffff")),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
      },
      home: SplashScreen(),
    );
  }
}
