import 'package:flutter/material.dart';
import 'package:m_share/Components/section.header.dart';
import 'package:m_share/Components/user.card.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
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
      body: const SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SectionHeader(title: 'Users', subtitle: 'All users list'),
                    ]
                  ),
                  UserCard(
                    type: 'Teacher',
                    name: 'Jason',
                    //username for teacher is Their Name
                    username: 'Jason',
                    color: Colors.deepPurpleAccent,
                  ),
                  UserCard(
                    type: 'Student',
                    name: 'Yesehak',
                    //username for student is their ID Number
                    username: 'JA5080',
                    color: Colors.deepPurpleAccent,
                  ),
                  UserCard(
                    type: 'Admin',
                    name: 'Eyasu',
                    //only one admin and username is admin
                    username: 'admin',
                    color: Colors.redAccent,
                  ),
                ]
              )
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
