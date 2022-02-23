import 'package:flutter/material.dart';
import 'package:get_location/variables/search_house.dart';
import 'package:provider/provider.dart';

import './screen/home.dart';
import './screen/auth_screen.dart';
import 'screen/owner_panel.dart';
import './variables/auth.dart';
import './variables/owner.dart';
import './screen/show_owner_biodata.dart';
import './variables/house.dart';
import './screen/add_house_information.dart';
import './screen/show_house_information.dart';
import './screen/search_house.dart';
import './screen/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: OwnerData(),
        ),
        ChangeNotifierProvider.value(
          value: HouseData(),
        ),
        ChangeNotifierProvider.value(
          value: UserSearchHouse(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ApaRent',
        home: LandingPage(),
        routes: {
          MyApp.routeName: (ctx) => MyApp(),
          MyHomePage.routeName: (ctx) => MyHomePage(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          OwnerPanel.routeName: (ctx) => OwnerPanel(),
          ShowOwnerBiodata.routeName: (ctx) => ShowOwnerBiodata(),
          AddHouseInformation.routeName: (ctx) => AddHouseInformation(),
          ShowHouseInformation.routeName: (ctx) => ShowHouseInformation(),
          SearchHouse.routeName: (ctx) => SearchHouse(),
        },
      ),
    );
  }
}
