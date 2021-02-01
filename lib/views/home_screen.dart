import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:projectilelaundryapp/components/home_service_page_button.dart';
import 'package:projectilelaundryapp/constants.dart';
import 'package:projectilelaundryapp/providers/home_page_providers.dart';

class HomeScreen extends ConsumerWidget {
  void changexOffset(BuildContext context, double offset) {
    context.read(xOffsetProvider).state = offset;
  }

  void changeyOffset(BuildContext context, double offset) {
    context.read(yOffsetProvider).state = offset;
  }

  void changeScale(BuildContext context, double scale) {
    context.read(scaleProvider).state = scale;
  }

  void changeDrawerState(BuildContext context, bool drawerState) {
    context.read(drawerStateProvider).state = drawerState;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isDrawerOpen = watch(drawerStateProvider).state;
    final xOffset = watch(xOffsetProvider).state;
    final yOffset = watch(yOffsetProvider).state;
    final scaleFactor = watch(scaleProvider).state;
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: blurredMainColor,
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: mainColor,
                            ),
                            onPressed: () {
                              changexOffset(context, 0);
                              changeyOffset(context, 0);
                              changeScale(context, 1);
                              changeDrawerState(context, false);
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: mainColor,
                            ),
                            onPressed: () {
                              changexOffset(context, 230);
                              changeyOffset(context, 150);
                              changeScale(context, 0.6);
                              changeDrawerState(context, true);
                            },
                          ),
                    Text(
                      'Gimme',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart_rounded,
                      color: mainColor,
                    )
                  ],
                ),
              ),
              Container(
                height: 300,
                color: blurredMainColor,
                child: FlareActor(
                  'assets/flares/big_laundry_machine.flr',
                  animation: 'Untitled',
                ),
              ),
              Card(
                elevation: 10.0,
                color: offWhiteColor,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: mainColor,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    onTap: () {},
                    title: RichText(
                      text: TextSpan(
                        text: 'Know more about your ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'Local-preneur',
                            style: TextStyle(color: mainColor),
                          ),
                        ],
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_rounded,
                      color: mainColor,
                    ),
                  ),
                ),
              ),
              HomeServiceButton(
                title: 'Ironing',
                imgPath: 'assets/images/ironing.png',
                onTap: () => Navigator.pushNamed(context, '/ironing_menu'),
              ),
              HomeServiceButton(
                title: 'Washing+Ironing',
                imgPath: 'assets/images/washing.png',
                onTap: () => Navigator.pushNamed(context, '/washing_menu'),
              ),
              HomeServiceButton(
                title: 'Dry Cleaning',
                imgPath: 'assets/images/drycleaning.png',
                onTap: () => Navigator.pushNamed(context, '/drycleaning_menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
