import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../variables/house.dart';

class HouseShowWidget extends StatelessWidget {
  String bedroom;
  String mobile;
  String village;
  String district;
  String housetype;
  String gmail;
  String id;

  HouseShowWidget(
    this.bedroom,
    this.mobile,
    this.village,
    this.district,
    this.housetype,
    this.gmail,
    this.id,
  );

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Card(
      //color: Color(0xff38ada9),
      child: ListTile(
        title: Text(
          village,
          style: TextStyle(
            fontSize: 35.0,
          ),
        ),
        subtitle: Text(
          district,
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              try {
                await Provider.of<HouseData>(context, listen: false)
                    .deleteHouse(id);
              } catch (error) {
                scaffold.showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Deleting Failed!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }
}
