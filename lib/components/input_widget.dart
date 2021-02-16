import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/constants.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isEmojiVisible;
  final bool isKeyboardVisible;
  final Function onBlurred;
  final ValueChanged<String> onSentMessage;
  final focusNode = FocusNode();

  InputWidget({
    @required this.controller,
    @required this.isEmojiVisible,
    @required this.isKeyboardVisible,
    @required this.onSentMessage,
    @required this.onBlurred,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: kMessageContainerDecoration,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                isEmojiVisible
                    ? Icons.keyboard_rounded
                    : Icons.emoji_emotions_outlined,
                color: Colors.grey,
              ),
              onPressed: onClickedEmoji,
            ),
            Expanded(
              child: TextField(
                decoration: kMessageTextFieldDecoration,
                focusNode: focusNode,
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  return;
                }
                onSentMessage(controller.text);
                controller.clear();
              },
              color: Colors.deepPurpleAccent,
              iconSize: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    onBlurred();
  }
}

// MaterialButton(
//   onPressed: () {},
//   elevation: 2.0,
//   color: Colors.deepPurpleAccent[200],
//   child: Icon(
//     Icons.add,
//     size: 15.0,
//   ),
//   padding: EdgeInsets.all(10.0),
//   shape: CircleBorder(),
//   minWidth: 10,
// ),
