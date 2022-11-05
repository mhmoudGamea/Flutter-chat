import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants.dart';

class SendMessageContainer extends StatefulWidget {
  const SendMessageContainer({Key? key}) : super(key: key);

  @override
  State<SendMessageContainer> createState() => _SendMessageContainerState();
}

class _SendMessageContainerState extends State<SendMessageContainer> {
  
  var _enteredMessage = '';
  final _controller = TextEditingController();
  void _sendMessage() async{
    final userid = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(userid!.uid).get();
    FirebaseFirestore.instance.collection('messages').add({
      'text': _enteredMessage.trim().isEmpty ? _url : _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': userid.uid,
      'userName': userData['username'],
      'userImage': userData['imageurl'],
    });
    _controller.clear();
  }

  late String _url;

  void _pickImage() async{
    ImagePicker picker = ImagePicker();
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final XFile ? image =  await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    final storageRef = FirebaseStorage.instance.ref().child('chat_image').child('$userId${DateTime.now()}.jpg');
    try {
      await storageRef.putFile(File(image!.path));
      _url = await storageRef.getDownloadURL();
    }on FirebaseException catch(ex){
      debugPrint(ex.toString());
    }
    _controller.text = _url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 18, right: 3),
              decoration: BoxDecoration(
                color: lightPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                controller: _controller,
                cursorColor: midPurple,
                decoration: InputDecoration(
                  suffixIcon: IconButton(icon: Icon(Iconsax.camera5, color: midPurple,), onPressed: _pickImage,),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Send a message',
                  hintStyle: const TextStyle(fontFamily: font, color: Colors.black45),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: _sendMessage,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: lightPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 23),
                child: Icon(Iconsax.send_25, color: midPurple),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
