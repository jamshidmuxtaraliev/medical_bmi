import 'package:dialogs/dialogs/choice_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:medical_bmi/screen/splash/splash_screen.dart';

import '../utility/app_constant.dart';
import '../utility/pref_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: TEXT_COLOR2,
            ),
          ),
        ),
        title: Text(
          "Sozlamar oynasi",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: TEXT_COLOR2),
        ),
      ),
      body: Container(
        color: Colors.white60,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                              const SizedBox(height: 16,),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    "Ulashmoq",
                    style: TextStyle(fontSize: 20, color: TEXT_COLOR),
                  ),
                ),
                InkWell(
                  onTap: (){
                    share();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: TEXT_COLOR, borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      children: const [
                        Icon(Icons.share),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            "Ilovani ulashish",
                            style: TextStyle(fontSize: 20, color: WHITE),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    "Chiqish",
                    style: TextStyle(fontSize: 20, color: TEXT_COLOR),
                  ),
                ),
                InkWell(
                  onTap: (){
                    ChoiceDialog(
                      dialogBackgroundColor: COLOR_PRIMARY2,
                      title: "Chiqish",
                      titleColor: Colors.white,
                      messageColor: Colors.white,
                      message: "Tizimdan chiqishga ishonchizngiz komilmi ?",
                      buttonOkText: "Chiqish",
                      buttonOkColor: COLOR_PRIMARY,
                      buttonCancelText: "Yo'q",
                      buttonOkOnPressed: () {
                        PrefUtils.clearAll();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                          return SplashScreen();
                        }), (route) => false);
                      },
                    ).show(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: TEXT_COLOR, borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      children: const [
                        Icon(Icons.logout),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            "Tizimdan chiqish",
                            style: TextStyle(fontSize: 20, color: WHITE),
                          ),
                        ),
                        Icon(Icons.navigate_next_rounded, size: 28,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Use our application',
        linkUrl: 'https://tatuff.uz',
        chooserTitle: 'Example Chooser Title');
  }
}
