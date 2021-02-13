import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String messageText;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      var timeStamp = DateTime.now();
                      print(timeStamp.month);
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': timeStamp
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepPurpleAccent,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;

        List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final currentUser = loggedInUser.email;
          var date = DateTime.fromMillisecondsSinceEpoch(
              message.data()['time'].millisecondsSinceEpoch);

          var formattedTime = DateFormat.jm().format(date);
          String timeLabel = '$formattedTime';
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
            time: timeLabel,
          );
          messageWidgets.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.time});
  final String sender;
  final String text;
  final bool isMe;
  final String time;
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
