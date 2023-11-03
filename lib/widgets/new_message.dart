import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessageField extends StatefulWidget {
  const NewMessageField({super.key});

  @override
  State<NewMessageField> createState() => _NewMessageFieldState();
}

class _NewMessageFieldState extends State<NewMessageField> {
  final _textController = TextEditingController();
  bool _isSending = false;

  void _sendMessage() async {
    /// Sends the message to Firebase.
    ///
    /// If the message is empty, it returns without doing anything.
    /// Otherwise, it sets the [_isSending] flag to true, clears the [_textController],
    /// gets the current user from FirebaseAuth, and retrieves the user's data from Firestore.
    /// Then, it adds the message to the 'chat' collection in Firestore with the message text,
    /// creation timestamp, user ID, username, and user image URL.
    /// If an error occurs, it prints the error message to the console.
    /// Finally, it sets the [_isSending] flag to false.
    var message = _textController.text.trim();
    if (message.isEmpty) {
      return;
    } else {
      setState(() {
        _isSending = true;
      });
      _textController.clear();
      // Send message to Firebase
      final user = FirebaseAuth.instance.currentUser!;
      final userDb = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      try {
        FirebaseFirestore.instance.collection('chat').add({
          'text': message,
          'createdAt': Timestamp.now(),
          'userId': user.uid,
          'username': userDb.data()!['username'],
          'userImage': userDb.data()!['image_url'],
        });
      } catch (e) {
        print(e.toString());
      }
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isSending ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
