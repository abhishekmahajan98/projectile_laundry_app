import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/components/drawer_item.dart';
import 'package:projectilelaundryapp/constants.dart';
import 'package:projectilelaundryapp/providers/authentication_providers.dart';
import 'package:projectilelaundryapp/providers/shared_preferences_provider.dart';
import 'package:projectilelaundryapp/providers/user_data_provider.dart';

class DrawerScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _auth = watch(authenticationServiceProvider);
    final prefs = watch(prefsProvider);
    final user = watch(userDataProvider);
    return Container(
      color: blurredMainColor,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.activeUser.email,
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Creation',
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              drawerItem(
                title: 'Home',
                data: Icons.home,
                onTap: () {},
              ),
              drawerItem(
                title: 'My Account',
                data: Icons.shopping_cart_rounded,
                onTap: () {},
              ),
              drawerItem(
                title: 'Cart',
                data: Icons.shopping_cart_rounded,
                onTap: () {},
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: mainColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: mainColor,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () async {
                  await prefs.clearPrefs();
                  _auth.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (Route<dynamic> route) => false,
                  ).then((value) => user.assignUser(null));
                },
                child: Text(
                  'Log out',
                  style:
                      TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
