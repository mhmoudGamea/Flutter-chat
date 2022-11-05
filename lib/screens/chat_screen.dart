import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/my_drop_down_button.dart';
import '../widgets/send_message_container.dart';
import '../widgets/stream_messages.dart';

class ChatScreen extends StatefulWidget {
  static const rn = '/chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: midPurple,
        title: const Text(
          'chat',
          style: TextStyle(
            fontFamily: font,
          ),
        ),
        actions: const [
          MyDropDownButton(),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: StreamMessages(),
          ),
          SendMessageContainer(),
        ],
      ),
    );
  }
}
