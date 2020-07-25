import 'package:ecomadmin/ui/animation/fade_animation.dart';
import 'package:ecomadmin/ui/views/home/screens/product/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  AnimationController _scale2Controller;
  Animation<double> _scale2Animation;

  @override
  void initState() {
    super.initState();
    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {

              getLogin();

              /*Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: ProductsScreen()));*/
            }
          });
  }

  allUnFocus() {
    emailNode.unfocus();
    passwordNode.unfocus();
  }

  void getLogin() {
    if (email == 'admin' && password == 'admin') {
      print('login');

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment(1, 0.5),
              child: ProductsScreen()));
    } else {
      print('failed.');
      click = false;
      _scale2Controller.reset();
    }
  }

  String email;
  String password;
  bool click = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    focusNode: emailNode,
                                    onChanged: (v) {
                                      email = v;
                                    },
                                    onSubmitted: (v) {
                                      emailNode.unfocus();
                                      passwordNode.requestFocus();
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    focusNode: passwordNode,
                                    onChanged: (v) {
                                      password = v;
                                    },
                                    onSubmitted: (v) {
                                      passwordNode.unfocus();
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          InkWell(
                            onTap: () {
                              allUnFocus();
                              //getLogin();
                              click = true;
                              _scale2Controller.forward();
                            },
                            child: AnimatedBuilder(
                                animation: _scale2Animation,
                                builder: (context, snapshot) {
                                  return Transform.scale(
                                    scale: _scale2Animation.value,
                                    child: Container(
                                      height: 50,
                                      decoration: click
                                          ? BoxDecoration(
                                              color: click
                                                  ? Color(0xFF035AA6)
                                                  : null,
                                              shape: BoxShape.circle,
                                            )
                                          : BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(colors: [
                                                Color.fromRGBO(
                                                    143, 148, 251, 1),
                                                Color.fromRGBO(
                                                    143, 148, 251, .6),
                                              ])),
                                      child: click
                                          ? null
                                          : Center(
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ),
                                  );
                                }),
                          )),
                      SizedBox(
                        height: 70,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            //"Forgot Password?",
                            'Admin only',
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
