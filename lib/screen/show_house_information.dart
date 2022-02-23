import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../variables/house.dart';
import '../widget/house_show_widget.dart';
import '../widget/logout.dart';

class ShowHouseInformation extends StatelessWidget {
  var _isInit = true;
  static const routeName = '/show-house-information';

  Future<void> _refreshHouse(BuildContext context, String email) async {
    await Provider.of<HouseData>(context, listen: false).showHouse(email);
  }

  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseData>(context);
    final email = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff38ada9),
        title: const Text('House Information'),
        actions: [
          LogOut(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshHouse(context, email),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: house.housegetter.length,
            itemBuilder: (_, i) => Column(
              children: [
                HouseShowWidget(
                  house.housegetter[i].bedroomNo,
                  house.housegetter[i].mobile,
                  house.housegetter[i].village,
                  house.housegetter[i].district,
                  house.housegetter[i].houseType,
                  email,
                  house.housegetter[i].id,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
