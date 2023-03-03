import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _messages = [
    ChatMessage(
        id: '1',
        text: 'bom dia',
        createdAt: DateTime.now(),
        userId: '123',
        userName: 'arthur',
        userImageUrl: 'assets/images/avatar.png'),
    ChatMessage(
        id: '2',
        text: 'boa tarde',
        createdAt: DateTime.now(),
        userId: '456',
        userName: 'davi',
        userImageUrl: 'assets/images/avatar.png'),
    ChatMessage(
        id: '3',
        text: 'boa noite',
        createdAt: DateTime.now(),
        userId: '789',
        userName: 'lucas',
        userImageUrl: 'assets/images/avatar.png'),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final Stream<List<ChatMessage>> _messagesStream =
      Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _messagesStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _messages.add(newMessage);
    _controller?.add(_messages.reversed.toList());
    return newMessage;
  }
}
