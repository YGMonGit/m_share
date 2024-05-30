import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/Components/section.header.dart';
import 'package:m_share/Components/user.card.dart';
import 'package:m_share/controller/user_controller.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 80,
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF36454F),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SectionHeader(title: 'Users', subtitle: 'All users list'),
                Obx(() {
                  if (userController.users.isEmpty) {
                    return const Text('No users found');
                  } else {
                    return Column(
                      children: userController.users.map((user) {
                        return UserCard(
                          id: user['id'],
                          type: user['role'],
                          username: user['username'],
                          color: user['role'] == 'admin'
                              ? Colors.redAccent
                              : Colors.deepPurpleAccent,
                        );
                      }).toList(),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addUser');
        },
        tooltip: 'Add New User',
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
