import 'package:ecomadmin/core/local_storage/secure_storage.dart';
import 'package:ecomadmin/ui/views/auth/login_page.dart';
import 'package:ecomadmin/ui/views/upload/new_upload.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget leftDrawer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * .7,
    child: Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Admin App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF035AA6),
            ),
          ),
          ListTile(
            title: Text('Add Product'),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment(1, 0.5),
                      child: NewProDuctUpload()));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              SecureStorage.deleteAllSecureData();
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment(1, 0.5),
                      child: LoginPage()));
            },
          ),
        ],
      ),
    ),
  );
}
