import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message_model.dart';
import '../widgets/message_bubble.dart';

class StreamMessages extends StatelessWidget {
  const StreamMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: midPurple));
        }
        List<MessageModel> myMessages = [];
        snapshot.data!.docs
            .map(
              (e) => myMessages.add(
                MessageModel(
                  text: e['text'],
                  userId: e['userId'],
                  userName: e['userName'],
                  userImage: e['userImage'],
                ),
              ),
            )
            .toList();
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) => MessageBubble(
            message: myMessages[index].text,
            isMe: myMessages[index].userId == FirebaseAuth.instance.currentUser!.uid,
            key: ValueKey(snapshot.data!.docs[index].id),
            userName: myMessages[index].userName,
            userImage: myMessages[index].userImage,
          ),
          itemCount: myMessages.length,
        );
      },
    );
  }
}
