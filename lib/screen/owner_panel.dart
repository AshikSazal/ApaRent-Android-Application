import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/logout.dart';
import '../variables/auth.dart';
import './add_house_information.dart';

class OwnerPanel extends StatelessWidget {
  static const routeName = '/owner-panel';

  @override
  Widget build(BuildContext context) {
    final gmail = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff38ada9),
        title: const Text('Owner Panel'),
        actions: [
          LogOut(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff38ada9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xff38ada9))),

                // padding:  EdgeInsets.all(30.0),
                primary: Colors.white,
                textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: const Text(
                'House Information',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/show-house-information',
                    arguments: gmail.token);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff38ada9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xff38ada9))),

                // padding:  EdgeInsets.all(30.0),
                primary: Colors.white,
                textStyle: TextStyle(
                  fontSize: 40.0,
                  // fontFamily: 'Satisfy',
                  // backgroundColor: Colors.red,
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: const Text(
                'Insert House Data',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/add-house-information',
                    arguments: gmail.token);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff38ada9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xff38ada9))),

                // padding:  EdgeInsets.all(30.0),
                primary: Colors.white,
                textStyle: TextStyle(
                  fontSize: 40.0,
                  // fontFamily: 'Satisfy',
                  // backgroundColor: Colors.red,
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: const Text(
                "Owner's Biodata",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/show-owner-biodata', arguments: gmail.token);
              },
            ),
          ],
        ),
      ),
    );
  }
}
