import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/components/login_container.dart';
import 'package:projectilelaundryapp/components/login_option_button.dart';
import 'package:projectilelaundryapp/components/signup_container.dart';
import 'package:projectilelaundryapp/components/signup_option_button.dart';
import 'package:projectilelaundryapp/constants.dart';

final loginPageStateProvider = StateProvider<bool>((ref) => true);

class LoginPage extends ConsumerWidget {
  void changeLoginPageState(BuildContext context, bool state) {
    context.read(loginPageStateProvider).state = state;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    bool loginPageState = watch(loginPageStateProvider).state;
    return Scaffold(
      backgroundColor: blurredMainColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                changeLoginPageState(context, true);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: loginPageState
                    ? MediaQuery.of(context).size.height * 0.6
                    : MediaQuery.of(context).size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(loginPageState),
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: loginPageState
                          ? 0
                          : MediaQuery.of(context).size.height / 10,
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 10,
                            vertical: MediaQuery.of(context).size.height / 10,
                          ),
                          child: loginPageState ? Login() : LoginOption(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                changeLoginPageState(context, false);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: loginPageState
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height * 0.6,
                child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(
                      top: loginPageState
                          ? MediaQuery.of(context).size.height / 10
                          : 0,
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 10,
                            vertical: MediaQuery.of(context).size.height / 10,
                          ),
                          child: !loginPageState ? SignUp() : SignUpOption(),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = mainColor;
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5,
        outterCurve ? size.height + 110 : size.height - 110,
        size.width,
        size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
