import 'package:ecomadmin/ui/views/drawer/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: leftDrawer(context),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('Dashboard'),
      actions: <Widget>[
        /* IconButton(
          icon:Icon(Icons.notifications_active),
          onPressed: () {},
        ),*/
      ],
    );
  }
}
