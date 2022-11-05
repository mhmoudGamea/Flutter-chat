import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;
  final String userImage;
  final Key? key;

  const MessageBubble({
    required this.key,
    required this.message,
    required this.isMe,
    required this.userName,
    required this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(message.contains('https://firebasestorage') && message.contains('.jpg')) {
      return Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!isMe)
            const SizedBox(width: 5),
          if(!isMe)
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: midPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage(userImage), fit: BoxFit.cover),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
            constraints: const BoxConstraints(maxWidth: 250, maxHeight: 200),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: isMe ? midPurple : Colors.grey),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(15),
                topRight: isMe ? const Radius.circular(0) : const Radius.circular(15),
                bottomRight: const Radius.circular(15),
                topLeft: isMe ? const Radius.circular(15) : const Radius.circular(0),
              ),
              image: DecorationImage(image: NetworkImage(message), fit: BoxFit.cover),
            ),
          ),
        ],
      );
    }else {
      // 'll render an ordinary container for text message
      return Row(
        // i just use row to make the container respect it's width constrains, not more than this
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!isMe)
            const SizedBox(width: 5),
          if(!isMe)
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: midPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: NetworkImage(userImage), fit: BoxFit.cover),
              ),
            ),
          Container(
            padding: EdgeInsets.only(top: 0, right: isMe ? 8 : 15, left: isMe ? 15 : 8, bottom: 3),
            margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
            decoration: BoxDecoration(
              color: isMe ? midPurple : midPurple.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(15),
                topRight: isMe ? const Radius.circular(0) : const Radius.circular(15),
                bottomRight: const Radius.circular(15),
                topLeft: isMe ? const Radius.circular(15) : const Radius.circular(0),
              ),
            ),
            constraints: const BoxConstraints(maxWidth: 250),//WrIKY4ch0JT7ZpwL84W7IOynF4h2
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  message,
                  style: const TextStyle(fontFamily: font, fontSize: 17, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
