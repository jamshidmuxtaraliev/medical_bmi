import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../utility/app_constant.dart';

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({Key? key}) : super(key: key);

  @override
  _MyDrawerHeaderState createState() => _MyDrawerHeaderState();
}

class _MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR_PRIMARY,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, image: DecorationImage(image: AssetImage(Assets.imagesDoctor))),
      ),
    );
  }
}
