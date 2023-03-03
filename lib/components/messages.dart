import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../core/services/auth/auth_service.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        final messages = snapshot.data ?? [];
        final currentUser = AuthService().currentUser;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading messages'),
          );
        } else if (!snapshot.hasData || messages.isEmpty) {
          return const Center(
            child: Text('No messages yet'),
          );
        }

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (ctx, index) {
            return MessageBubble(
              key: ValueKey(messages[index].id),
              message: messages[index],
              belongsToCurrentUser: messages[index].userId == currentUser!.id,
            );
          },
        );
      },
    );
  }
}
