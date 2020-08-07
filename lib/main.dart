import 'package:ecomadmin/ui/views/home/constants.dart';
import 'package:ecomadmin/ui/views/home/screens/product/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ui/views/auth/login_page.dart';
import 'ui/views/upload/new_upload.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin',
      theme: ThemeData(
        //  primarySwatch: Colors.blue,
        // We set Poppins as our default font google_fonts: ^1.1.0
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
   //   home: MyHomePage(),
      home: ProductsScreen(),
     // home: NewProDuctUpload(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
