import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/views/drawer_screen.dart';
import 'package:projectilelaundryapp/views/home_screen.dart';

import '../constants.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blurredMainColor,
        body: Stack(
          children: [
            DrawerScreen(),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
