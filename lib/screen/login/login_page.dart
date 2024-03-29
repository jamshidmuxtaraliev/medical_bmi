import 'dart:async';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/screen/home/home_page.dart';
import 'package:stacked/stacked.dart';
import '../../api/main_viewmodel.dart';
import '../../utility/app_constant.dart';
import '../../widget/circular_reveal.dart';
import '../../widget/rounded_button.dart';
import '../../widget/trapezoid_down_cut_small.dart';
import '../../widget/trapezoid_left_cut.dart';
import '../../widget/trapezoid_up_cut.dart';
import '../../widget/trapezoid_up_cut_small.dart';
import 'login_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late LoginEnterAnimation enterAnimation;
  late AnimationController animationController;

  late Animation<double> _animation;
  late AnimationController revealAnimationController;
  double _fraction = 0.0;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    enterAnimation = LoginEnterAnimation(animationController);

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
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              _buildContent(viewModel, size, textTheme),
              Center(
                child: _fraction > 0
                    ? CustomPaint(
                        painter: RevealProgressButtonPainter(_fraction, MediaQuery.of(context).size),
                      )
                    : Offstage(),
              ),
              Center(
                child: _fraction == 1 ? CircularProgressIndicator() : Offstage(),
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
        );
      },
      onViewModelReady: (viewModel) {
        viewModel.errorData.listen((event) {
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

        viewModel.loginConfirmData.listen((event) async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      },
    );
  }

  void reveal() {
    revealAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(revealAnimationController)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    revealAnimationController.forward();

    Timer(Duration(milliseconds: 3600), () {
      _fraction = 0;
      Navigator.pushNamed(context, '/home');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  Widget _buildContent(MainViewModel viewModel, Size size, TextTheme textTheme) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: <Color>[
              Color(0xFF7BDDB1),
              Color(0xFF377885),
              Color(0xFF265F7A),
            ],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _buildBackgroundCenter(),
            _buildBackgroundTop(),
            _buildBackgroundBottom(),
            _buildBackgroundBottom2(),
            _buildForm(viewModel, size, textTheme)
          ],
        ),
      );

  _buildBackgroundCenter() => Transform(
        transform: Matrix4.translationValues(-enterAnimation.backgroundTranslation.value, 0, 0),
        child: TrapezoidLeftCut(
          child: Container(
            color: Colors.white,
          ),
        ),
      );

  _buildBackgroundTop() => Transform(
        transform: Matrix4.translationValues(0, -enterAnimation.backgroundTranslation.value, 0),
        child: TrapezoidDownCutSmall(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomRight,
                colors: <Color>[
                  Color(0xFF64BCA2),
                  Color(0xFF468E8E),
                  Color(0xFF3C7E88),
                ],
              ),
            ),
          ),
        ),
      );

  _buildBackgroundBottom() => Transform(
        transform: Matrix4.translationValues(0, enterAnimation.backgroundTranslation.value, 0),
        child: TrapezoidUpCut(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: <Color>[
                  Color(0xFF468E8E),
                  Color(0xFF3C7E88),
                ],
              ),
            ),
          ),
        ),
      );

  _buildBackgroundBottom2() => Transform(
        transform: Matrix4.translationValues(0, enterAnimation.backgroundTranslation.value, 0),
        child: TrapezoidUpCutSmall(
          child: Container(
            color: Colors.white,
          ),
        ),
      );

  _buildForm(MainViewModel viewmodel, Size size, TextTheme textTheme) => Positioned(
      top: size.height * 0.2,
      left: size.width * 0.08,
      right: size.width * 0.35,
      bottom: size.width * 0.3,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(-enterAnimation.translation.value, 0, 0),
                child: Text(
                  "Login",
                  style: textTheme.headlineMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              _buildTextFormUsername(textTheme),
              const SizedBox(
                height: 8,
              ),
              _buildTextFormPassword(textTheme),
              SizedBox(
                height: size.height * 0.05,
              ),
              Transform(
                  transform: Matrix4.translationValues(-enterAnimation.buttontranslation.value, 0, 0),
                  child: (!viewmodel.progressData)
                      ? Container(
                          height: 48.0,
                          width: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: InkWell(
                              onTap: () async {
                                viewmodel.login(
                                    userNameController.text.toString(), passwordController.text.toString());
                              },
                              child: Center(
                                child: Text("Login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.white)),
                              )),
                        )
                      : Container(
                          height: 48.0,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                          width: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ))
            ],
          ),
        ),
      ));

  Widget _buildTextFormUsername(TextTheme textTheme) {
    return FadeTransition(
      opacity: enterAnimation.userNameOpacity,
      child: TextFormField(
        style: textTheme.titleSmall?.copyWith(color: Colors.black87),
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: PHONE_AUTH_HINT,
          labelStyle: textTheme.caption?.copyWith(color: Theme.of(context).primaryColor),
          contentPadding: EdgeInsets.zero,
          suffixIcon: const Icon(
            Icons.person_outline,
            color: Colors.grey,
          ),
        ),
        keyboardType: TextInputType.text,
        controller: userNameController,
        validator: (val) => val?.length == 0
            ? PHONE_AUTH_VALIDATION_EMPTY
            : ((val?.length)! < 10)
                ? PHONE_AUTH_VALIDATION_INVALID
                : null,
      ),
    );
  }

  Widget _buildTextFormPassword(TextTheme textTheme) {
    return FadeTransition(
      opacity: enterAnimation.passowrdOpacity,
      child: TextFormField(
        style: textTheme.titleSmall?.copyWith(color: Colors.black87),
        decoration: InputDecoration(
          labelText: PASSWORD_AUTH_HINT,
          labelStyle: textTheme.bodySmall?.copyWith(color: Theme.of(context).primaryColor),
          contentPadding: const EdgeInsets.all(0.0),
          suffixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        ),
        keyboardType: TextInputType.text,
        controller: passwordController,
        obscureText: true,
        validator: (val) => val?.length == 0
            ? PHONE_AUTH_VALIDATION_EMPTY
            : (val?.length)! < 10
                ? PHONE_AUTH_VALIDATION_INVALID
                : null,
      ),
    );
  }
}
