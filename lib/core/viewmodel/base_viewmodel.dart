import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  final BuildContext context;

  //AuthenticationProvider authProvider;

  BaseViewModel(this.context) {
    // authProvider = Provider.of<AuthenticationProvider>(context);
  }
}
