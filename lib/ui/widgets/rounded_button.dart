import 'package:flutter/material.dart';

class RoundBoarderButton extends StatefulWidget {
  RoundBoarderButton({
    @required this.text,
    this.onPress,
    this.backGroundColor,
    this.borderRadius = 10.0,
    this.textColor,
  });

  final text;
  final Function onPress;
  final Color backGroundColor;
  final Color textColor;
  final double borderRadius;

  @override
  _RoundBoarderButtonState createState() => _RoundBoarderButtonState();
}

class _RoundBoarderButtonState extends State<RoundBoarderButton> {
  var defaultBorderRadius = 10.0;

  final textStyle = TextStyle(
    //   fontFamily: FontName.rubikBold,
    fontWeight: FontWeight.normal,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 15),
        color: widget.backGroundColor != null
            ? widget.backGroundColor
            : Color(0xff027D3F),
        disabledColor: widget.backGroundColor != null
            ? widget.backGroundColor
            : Color(0xff027D3F),
        onPressed: widget.onPress,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              '${widget.text}',
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                  color: widget.textColor != null
                      ? widget.textColor
                      : Colors.white),
            )),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius != null
              ? widget.borderRadius
              : defaultBorderRadius),
          borderSide: BorderSide(
            color: widget.backGroundColor != null
                ? widget.backGroundColor
                : Color(0xff027D3F),
            style: widget.backGroundColor != null
                ? BorderStyle.solid
                : BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
