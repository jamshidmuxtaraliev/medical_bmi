import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dialogs/dialogs/choice_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:medical_bmi/api/main_viewmodel.dart';
import 'package:medical_bmi/screen/covid%20app/uzbekistan.dart';
import 'package:medical_bmi/screen/map/map_screen.dart';
import 'package:medical_bmi/screen/news/news_screen.dart';
import 'package:medical_bmi/screen/profile/profile_screen.dart';
import 'package:medical_bmi/screen/reports/report_screen.dart';
import 'package:medical_bmi/screen/settings_screen.dart';
import 'package:medical_bmi/utility/pref_utils.dart';
import 'package:stacked/stacked.dart';
import '../../utility/app_constant.dart';
import '../splash/splash_screen.dart';
import 'home_animation.dart';
import 'my_drawer_header.dart';
import '../../utility/color_utility.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeEnterAnimation enterAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(duration: const Duration(milliseconds: 3000), vsync: this);

    enterAnimation = HomeEnterAnimation(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () {
        return MainViewModel();
      },
      builder: (BuildContext context, MainViewModel viewModel, Widget? child) {
        return Scaffold(
          body: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _buildBackgroundImage(size),
                    _buildBackgroundGradient(size),
                    _buildCard(size, textTheme),
                  ],
                );
              }),
        );
      },
      onViewModelReady: (viewmodel) {
        viewmodel.getUser();

        viewmodel.errorData.listen((event) {
          viewmodel.errorData.listen((event) {
            CherryToast.error(
              title: const Text('Error'),
              enableIconAnimation: false,
              displayTitle: false,
              description: Text(event),
              animationType: AnimationType.fromTop,
              animationDuration: const Duration(milliseconds: 1000),
              autoDismiss: true,
            ).show(context);
          });
        });

        viewmodel.getUserData.listen((event) {
          PrefUtils.setUser(event);
        });
      },
    );
  }


  _buildBackgroundImage(Size size) => Positioned(
        top: 0,
        bottom: size.height * 0.6,
        left: 0,
        right: 0,
        child: FadeTransition(
          opacity: enterAnimation.fadeTranslation,
          child: Container(
              decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/doctor.jpg'),
              fit: BoxFit.cover,
            ),
          )),
        ),
      );

  _buildBackgroundGradient(Size size) => Positioned(
        top: size.height * 0.4,
        bottom: 0,
        left: 0,
        right: 0,
        child: FadeTransition(
          opacity: enterAnimation.fadeTranslation,
          child: Container(
              decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: <Color>[
                Color(0xFF5DB09E),
                Color(0xFF40858B),
                Color(0xFF042C63),
              ],
            ),
          )),
        ),
      );

  _buildCard(Size size, TextTheme textTheme) => Positioned(
        top: size.height * 0.3,
        bottom: size.height * 0.1,
        left: size.width * 0.05,
        right: size.width * 0.05,
        child: Transform(
          transform: Matrix4.translationValues(0, enterAnimation.Ytranslation.value, 0),
          child: Card(
            elevation: 8,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              startScreenF(context, const MapScreen());
                              // showSuccess(context, "Menu");
                            },
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                            )),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "Hello ${PrefUtils.getUser()?.username}",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Welcome",
                              style: textTheme.titleMedium
                                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                        InkWell(
                            onTap: () {
                              startScreenF(context, SettingsScreen());
                              // showSuccess(context, "Menu");
                            },
                            child: const Icon(
                              Icons.settings,
                              color: Colors.green,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: (size.width) / ((size.height * 0.5)),
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: menuItems.map((Menu menu) {
                          return menuStack(context, menu);
                        }).toList(),
                      ),
                    )
                  ],
                )),
          ),
        ),
      );

  Widget menuStack(BuildContext context, Menu menu) => InkWell(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(menu.image),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  menu.title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (menu.clickType == 1)
                      ? NewsScreen()
                      : (menu.clickType == 2)
                          ? Pakistan()
                          : (menu.clickType == 3)
                              ? ReportScreen()
                              : ProfileScreen()));
        },
      );
}

class Menu {
  String title;
  String image;
  int clickType;

  Menu({required this.title, required this.image, required this.clickType});
}

final menuItems = <Menu>[
  Menu(title: "Yangiliklar va elonlar", image: 'assets/images/appointment.png', clickType: 1),
  Menu(title: "Epidemiologik malumot", image: 'assets/images/reminder.png', clickType: 2),
  Menu(title: "Hisobot topshirish", image: 'assets/images/reports.png', clickType: 3),
  Menu(title: "Shaxsiy malumotlar", image: 'assets/images/element.png', clickType: 4),
];
