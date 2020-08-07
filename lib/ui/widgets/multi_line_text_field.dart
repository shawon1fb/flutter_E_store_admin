import 'package:flutter/material.dart';

class MultiLineTextField extends StatelessWidget {
  MultiLineTextField({
    this.hint,
    this.inputType,
    this.validator,
    this.onSaved,
    this.key,
    this.focusNode,
    this.onFieldSubmitted,
    this.borderColor,
    this.prefixItem,
    this.suffixItem,
    this.obscureText = false,
    this.backgroundColor,
    this.borderRadius = 10,
    this.controller,
    this.onChange,
    this.suffixIcon,
    this.hight = 100,
  });

  final double hight;

  final Color borderColor;
  final Color backgroundColor;
  final hint;
  final TextInputType inputType;
  final TextEditingController controller;

  final Widget prefixItem;
  final Widget suffixItem;
  final Widget suffixIcon;

  final Function validator;
  final Function onSaved;
  final Function(String) onChange;
  final Function onFieldSubmitted;

  final Key key;
  final FocusNode focusNode;
  final bool obscureText;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          color: backgroundColor != null ? backgroundColor : Colors.white,
          //Color(0xFFEDEDED),
          border: Border.all(
            color: borderColor != null ? borderColor : Color(0xffF0F0F0),
            width: 2.0,
            style: BorderStyle.solid,
          )),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        validator: validator,
        keyboardType: inputType,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChange,
        maxLines: 2,
        decoration: InputDecoration(
            //contentPadding: EdgeInsets.all(0.0),
            border: InputBorder.none,
            labelText: "$hint",
            labelStyle: TextStyle(color: Color(0xff393939)),
            prefixIcon: prefixItem,
            suffix: suffixItem,
            suffixIcon: suffixItem
            /* border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),*/
            ),
      ),
    );
  }
}
