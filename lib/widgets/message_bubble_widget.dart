import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.time, this.reference});
  final String sender;
  final String text;
  final bool isMe;
  final String time;
  final dynamic reference;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(color: Colors.black54, fontSize: 12.0),
          ),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Material(
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                elevation: 5.0,
                color: isMe ? Colors.deepPurpleAccent : Colors.white,
                textStyle: TextStyle(
                    fontSize: 15.0, color: isMe ? Colors.white : Colors.black),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    '$text',
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '$time',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ]),
            ],
          ),
        ],
      ),
    );
  }
}
