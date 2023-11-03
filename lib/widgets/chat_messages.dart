import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  /// A widget that displays chat messages in a ListView.
  ///
  /// This widget listens to a stream of chat messages from Firestore and displays them in a ListView.
  /// The messages are ordered by their creation time in descending order.
  /// If there are no messages, a "No messages yet!" message is displayed.
  /// If there is an error while retrieving the messages, an error message is displayed.
  /// Each message is displayed in a [MessageBubble] widget.
  const ChatMessages({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet!'));
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            final chatMessage = chatDocs[index].data();
            final nextChatMessage =
                index + 1 < chatDocs.length ? chatDocs[index + 1].data() : null;
            final isMe =
                chatMessage['userId'] == FirebaseAuth.instance.currentUser!.uid;
            final nextUserIsSame = nextChatMessage != null &&
                nextChatMessage['userId'] == chatMessage['userId'];

            if (!nextUserIsSame) {
              return MessageBubble.first(
                  message: chatMessage['text'],
                  username: chatMessage['username'],
                  userImage: chatMessage['userImage'],
                  isMe: isMe);
            } else {
              return MessageBubble.next(
                  message: chatMessage['text'], isMe: isMe);
            }
          },
        );
      },
    );
  }
}
