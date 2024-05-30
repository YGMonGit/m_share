import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/controller/user_controller.dart';

class UserCard extends StatelessWidget {
  final String type;
  final int id;
  final String username;
  final Color color;

  const UserCard({
    super.key,
    required this.type,
    required this.id,
    required this.username,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 189, 189, 189),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF7CACF),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    'Username: $username',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 80,
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await userController.removeUser(id);
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('User deleted successfully')),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.redAccent,
                    tooltip: 'Delete user',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
