import 'package:ecomadmin/ui/views/home/constants.dart';
import 'package:ecomadmin/ui/views/home/screens/product/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

import 'core/local_storage/secure_storage.dart';
import 'ui/views/auth/login_page.dart';
import 'ui/views/upload/new_upload.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
 // box.put('name', 2);
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
      //  home: MyHomePage(),
        home: ProductsScreen(),
   //   home: NewProDuctUpload(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    session();
  }

  void session() async {
    String token = await SecureStorage.getToken();
    if (token != null) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment(1, 0.5),
              child: ProductsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
