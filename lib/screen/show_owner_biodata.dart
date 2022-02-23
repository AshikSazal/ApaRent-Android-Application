import 'package:flutter/material.dart';
import 'package:get_location/variables/owner.dart';
import 'package:provider/provider.dart';

import '../variables/owner.dart';
import '../widget/owner_show_widget.dart';

class ShowOwnerBiodata extends StatefulWidget {
  static const routeName = '/show-owner-biodata';

  @override
  State<ShowOwnerBiodata> createState() => _ShowOwnerBiodataState();
}

class _ShowOwnerBiodataState extends State<ShowOwnerBiodata> {
  var _isInit = true;

  @override
  Future<void> _refreshOwner(BuildContext context, String email) async {
    await Provider.of<OwnerData>(context, listen: false).showOwner(email);
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments as String;
    final owner = Provider.of<OwnerData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff38ada9),
        title: const Text('Show biodata'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshOwner(context, email),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: owner.ownergetter.length,
            itemBuilder: (_, i) => Column(
              children: [
                OwnerShowWidget(
                  owner.ownergetter[i].name,
                  owner.ownergetter[i].mobile,
                  owner.ownergetter[i].gmail,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
