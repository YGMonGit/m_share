import 'package:flutter/material.dart';
import 'package:m_share/Components/course.card.dart';

class Course extends StatelessWidget {
  final String courseTitle;
  const Course({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 80,
        title: Text(
          courseTitle,
          style: const TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF36454F),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CourseCard(
                  title: "Note 1",
                  icon: Icons.abc,
                  onTap: () {},
                ),
                CourseCard(
                  title: "Assignment 1",
                  icon: Icons.abc,
                  onTap: () {},
                ),
                CourseCard(
                  title: "Note 1",
                  icon: Icons.abc,
                  onTap: () {},
                ),
              ],
            ),
        ),
      ),
    );
  }
}
