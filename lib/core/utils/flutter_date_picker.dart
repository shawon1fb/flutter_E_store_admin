import 'package:flutter/material.dart';

class FlutterDatePicker {
  static Future<String> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    return selectedDate.toString();
    /*if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });*/
  }

  static Future<String> timePicker(BuildContext context) async {
    Future<TimeOfDay> selectedTime24Hour = showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 12, minute: 00),
        builder: (BuildContext c, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    TimeOfDay t = await selectedTime24Hour;

    //return t.toString();
    /*.then((value) {
      return value.hour.toString() + ":" + value.minute.toString();
    });*/

    //  var now = DateTime.now();

    String m = t.minute.toString();
    if (t.minute.toString().length == 1) {
      m = "0" + t.minute.toString();
    }
    String h = t.hour.toString();
    if (t.hour.toString().length == 1) {
      h = "0" + t.hour.toString();
    }

    return h + ":" + m;
  }
}
