// My custom chat box
import 'package:expense_management/utils/colors.dart';
import 'package:flutter/material.dart';

MyField({controller, hint = '', kType = "text"}) {
  return TextField(
    controller: controller,
    keyboardType: kType == 'number'
        ? TextInputType.number
        : kType == 'email'
            ? TextInputType.emailAddress
            : TextInputType.text,
    obscureText: kType == 'password' ? true : false,
    decoration: InputDecoration(
      hintText: hint,
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 1.0),
          borderRadius: BorderRadius.circular(8)),
    ),
  );
}

InkBtn({context, text = '', onClick, color}) {
  return InkWell(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 58,
      decoration: BoxDecoration(
          color: color ?? primary_color, //Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$text",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
    ),
    onTap: onClick,
  );
}

NewInkBtn({context, text = '', onClick, color = ''}) {
  return InkWell(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      decoration: BoxDecoration(
          color: color != ''
              ? color
              : primary_color, //Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5)), //35
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$text",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
    ),
    onTap: onClick,
  );
}

Widget myLoader({text = 'Loading..', visibility = false}) {
  return Visibility(
    visible: visibility,
    child: Center(
        child: Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            )
          ],
        ),
      ),
    )),
  );
}

//
// showMyToast({msg = '', color = toastSuccess}) {
//   Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: color,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

Future<void> showMyDialog(String text, BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Notice!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text, textAlign: TextAlign.center),
            ],
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green, fontSize: 20.0),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
// Update dialog

Future<void> PopDialog({widget, context, title = ''}) async {
  StateSetter _setState;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            _setState = setState;
            return widget;
          },
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        // actions: <Widget>[
        //   InkWell(
        //     child: Text('OK   '),
        //     onTap: () {
        //       // if (_formKey.currentState.validate()) {
        //       //   // Do something like updating SharedPreferences or User Settings etc.
        //       //   Navigator.of(context).pop();
        //       // }
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      );
    },
  );
}
