import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      onVerticalDragEnd: (_) => FocusScope.of(context).unfocus(),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No messages yet.'),
        ],
      ),
    );
  }
}
