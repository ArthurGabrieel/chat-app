import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../models/chat_notification.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  List<ChatNotification> get items => [..._items];

  int get itemsCount => _items.length;

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  Future<void> init() async {
    await _configureForeground();
    await _configureBackground();
    await _configureTerminated();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized
        ? true
        : false;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMessage);
    }
  }

  void _messageHandler(RemoteMessage? message) {
    if (message != null || message?.notification != null) {
      final notification = message!.notification;
      add(ChatNotification(
        title: notification?.title ?? 'Title not found',
        body: notification?.body ?? 'Body not found',
      ));
    }
  }
}
