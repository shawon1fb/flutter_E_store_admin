import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  DropDownList({
    @required this.onChanged,
    this.onTap,
    @required this.itemList,
    this.hint,
    this.dropdownNode,
  });

  final FocusNode dropdownNode; // = FocusNode();
  final String hint;
  final Function(String s) onChanged;
  final Function onTap;
  final List<String> itemList;

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  int i = 0;

  // static const double paddingBottom = 25.0;
  final textStyle = TextStyle(
    color: Color(0xff161616),
    // fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );
  var value = "";
  bool b = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // canvasColor: Colors.white,
        canvasColor: Colors.white,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
            //Color(0xFFEDEDED),
            border: Border.all(
              color: Color(0xffF0F0F0),
              width: 2.0,
              style: BorderStyle.solid,
            )),
        child: DropdownButton<String>(
          onTap: widget.onTap,
          value: // value??'${widget.hint}',
              //widget.itemList.contains(value) ? value : widget.itemList[0],
              widget.itemList.contains(value) ? value : widget.hint,
          icon: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xffDFBA74),
            ),
          ),
          iconSize: 24,
          elevation: 16,
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.hint ?? " ",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
          iconEnabledColor: Colors.white,
          style: TextStyle(
            //color: AppColors.darkBlue,
            fontWeight: FontWeight.normal,
          ),
          underline: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 0.6,
              // width: double.infinity,
              //  color: AppColors.textFieldBg2,
            ),
          ),
          onChanged: (v) {
            widget.onChanged(v);
            //  widget.dropdownNode.unfocus();
            setState(() {
              value = v;
            });
          },
          focusNode: widget.dropdownNode,
          items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: Container(
                  width: value.length * 10.0,
                  decoration: BoxDecoration(
                    //  color: AppColors.textFieldBg2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${value.trim()}",
                      textAlign: TextAlign.left,
                      style: textStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
