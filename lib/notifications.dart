import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        setState(() {
          _messages.add(message);
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Notifications(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: _messages.isEmpty
          ? const Center(
              child: Icon(
                Icons.notifications_outlined,
                size: 200.0,
                color: Colors.grey,
              ),
            )
          : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.notification?.title ?? 'No Title'),
                  subtitle: Text(message.notification?.body ?? 'No Body'),
                  trailing: Text(
                    message.sentTime?.toLocal().toString() ?? 'No Time',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
    );
  }
}
