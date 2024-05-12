import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Icon(
      Icons.notifications_outlined,
      size: 200.0,
      color: Colors.grey,
    )));
  }
}