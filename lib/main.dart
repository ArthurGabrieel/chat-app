import 'package:chat/pages/auth_or_app_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/notification/chat_notification_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatNotificationService()),
      ],
      child: MaterialApp(
        theme: _appTheme(),
        home: const AuthOrAppPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

ThemeData _appTheme() {
  return ThemeData(
    iconTheme: const IconThemeData(color: Colors.indigo),
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.indigo,
      accentColor: Colors.amber,
    ),
  );
}
