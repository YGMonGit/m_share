import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/Components/course.card.dart';
import 'package:m_share/controller/course.controller.dart';
import 'package:m_share/controller/note.controller.dart';
import 'package:m_share/types/course.type.dart';

class Course extends StatelessWidget {
  final String courseTitle;

  const Course({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();
    final noteController = Get.put(NoteController());
    if (courseTitle.split("-").length == 2) {
      final courseId = courseTitle.split("-")[1];
      noteController.getNotesByCourseId(int.parse(courseId));
      courseController.getAssignmentsByCourseId(int.parse(courseId));
    }
    courseController.getOverdueAssignments();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 80,
        title: Text(
          courseTitle.split("-")[0],
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
              if (courseTitle.split("-")[0] == "Assignments Overdue")
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true, // Prevent list view from expanding
                    itemCount: courseController.overDueAssignment.length,
                    itemBuilder: (context, index) {
                      final assignment =
                          courseController.overDueAssignment[index];
                      return CourseCard(
                        title: assignment['title'],
                        icon: Icons.assignment,
                        onTap: () {},
                      );
                    },
                  ),
                ),
              if (courseTitle.split("-")[0] != "Assignments Overdue")
                Column(
                  children: [
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: noteController.notes.length,
                        itemBuilder: (context, index) {
                          final note = noteController.notes[index];
                          return CourseCard(
                            title: note['title'],
                            icon: Icons.note,
                            onTap: () {
                              // Handle note tap (optional: navigate to edit screen)
                            },
                          );
                        },
                      ),
                    ),
                    if (courseController.assignmentList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: courseController.assignmentList.length,
                        itemBuilder: (context, index) {
                          final assignment =
                              courseController.assignmentList[index];
                          return CourseCard(
                            title: assignment['title'],
                            icon: Icons.assignment,
                            onTap: () {}, // Handle assignment tap
                          );
                        },
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
