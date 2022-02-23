import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static const routeName = '/landing-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image.asset('images/logo.png'),
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
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: Text('Home Search'),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
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
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: Text('Owners SignIn'),
              onPressed: () {
                Navigator.of(context).pushNamed('/auth-screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
