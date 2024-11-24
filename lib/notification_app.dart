import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const platform = MethodChannel('com.example/notifications');
  bool notificationDisables = false;

  Future<void> toggleNotifications(bool value) async {
    try {
      final result = await platform.invokeMethod(
        'toggleNtifications',
        {"disable": value},
      );
      setState(() {
        notificationDisables = result;
      });
    } on PlatformException catch (e) {
      print("Failed to toggle notifications: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Notifications')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Disable notifications while using a specific app:'),
          SwitchListTile(
            title: const Text('Disable Notifications'),
            value: notificationDisables,
            onChanged: toggleNotifications,
            ),
          ],
        ),
      ),
    );
  }
}
