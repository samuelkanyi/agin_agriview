import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.abort);
                },
                child: Text('Button'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.yes);
                },
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> messageDialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12),
                ),
                onPressed: () {
                  Navigator.of(context).pop(DialogAction.yes);
                },
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.yes;
  }
}
