import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_bmi/utility/pref_utils.dart';

import '../../generated/assets.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
      (PrefUtils.getToken().isNotEmpty)?HomePage():LoginPage()));
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(child: Image.asset(Assets.imagesSes, width: double.infinity, ),),
      ),
    );
  }
}
