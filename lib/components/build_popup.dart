import 'package:flutter/material.dart';

class BuildPopUp extends StatelessWidget {
  BuildPopUp({this.description, this.title});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 5.0,
      contentTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        '$title',
        style: TextStyle(color: Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$description",
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          hoverColor: Colors.deepPurpleAccent,
          height: 50,
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
