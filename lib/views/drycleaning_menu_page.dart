import 'package:flutter/material.dart';

class DrycleaningMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dry Cleaninig Menu'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Text('Dry Cleaning Menu Page'),
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              color: Colors.red,
              onPressed: () {},
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
