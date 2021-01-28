import 'package:flutter/material.dart';
import 'package:projectilelaundryapp/constants.dart';

class HomeServiceButton extends StatelessWidget {
  final Function onTap;
  final String imgPath;
  final String title;

  const HomeServiceButton({
    Key key,
    @required this.onTap,
    @required this.imgPath,
    @required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 10.0,
        color: offWhiteColor,
        child: Container(
          height: screenHeight / 5.5,
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bluecurve.png'),
              fit: BoxFit.fill,
            ),
          ),*/
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      child: Image.asset(
                        'assets/images/bluecurve.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: screenHeight / 5.5,
                    width: screenWidth / 3,
                    child: Image.asset(
                      imgPath,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            //fontSize: (screenWidth * screenHeight) / 16000,
                            fontSize: screenWidth / 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
