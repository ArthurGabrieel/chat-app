import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/notification/chat_notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    final length = service.itemsCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: length == 0
          ? const Center(
              child: Text('No notifications yet!'),
            )
          : ListView.builder(
              itemCount: length,
              itemBuilder: (ctx, index) => ListTile(
                title: Text(items[index].title),
                subtitle: Text(items[index].body),
                onTap: () {
                  service.remove(index);
                },
              ),
            ),
    );
  }
}
