import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  // final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onVerticalDragEnd: (_) => FocusScope.of(context).unfocus(),
      child: StreamBuilder(
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
                final nextChatMessage = index + 1 < chatDocs.length
                    ? chatDocs[index + 1].data()
                    : null;
                final isMe = chatMessage['userId'] ==
                    FirebaseAuth.instance.currentUser!.uid;
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
              }
              //   return Container(
              //     padding: const EdgeInsets.all(8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         CircleAvatar(
              //           backgroundImage: NetworkImage(
              //             chatDocs[index]['userImage'],
              //           ),
              //         ),
              //         const SizedBox(width: 10),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               chatDocs[index]['username'],
              //               style: const TextStyle(
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             Text(
              //               chatDocs[index]['text'],
              //               style: const TextStyle(
              //                 color: Colors.grey,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   );
              // },
              );
        },
      ),
    );
  }
}
