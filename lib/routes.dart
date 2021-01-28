import 'package:flutter/material.dart';
import 'package:projectilelaundryapp/views/drycleaning_menu_page.dart';
import 'package:projectilelaundryapp/views/home_page.dart';
import 'package:projectilelaundryapp/views/ironing_menu_page.dart';
import 'package:projectilelaundryapp/views/login_page.dart';
import 'package:projectilelaundryapp/views/splash_page.dart';
import 'package:projectilelaundryapp/views/washing_menu_page.dart';

Map<String, WidgetBuilder> routes(BuildContext context) {
  return <String, WidgetBuilder>{
    '/': (context) => SplashPage(),
    '/home': (context) => HomePage(),
    '/login': (context) => LoginPage(),
    '/ironing_menu': (context) => IroningMenuPage(),
    '/washing_menu': (context) => WashingMenuPage(),
    '/drycleaning_menu': (context) => DrycleaningMenuPage(),
  };
}
