import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/Components/course.card.dart';
import 'package:m_share/Components/overview.card.dart';
import 'package:m_share/Components/recently.card.dart';
import 'package:m_share/Components/section.header.dart';
import 'package:m_share/controller/course.controller.dart';

class Homes extends StatelessWidget {
  const Homes({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.put<CourseController>(CourseController());
    courseController.getAssignments();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => (Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            OverviewCard(
                                count: courseController
                                    .assignmentOverdueCount.value,
                                title: 'Assignments Overdue',
                                color: Colors.red,
                                iconData: Icons.arrow_forward),

                            OverviewCard(
                                count: courseController
                                    .assignmentCloseDueCount.value,
                                title: 'Assignments Due',
                                color: const Color(0xFFE2E600),
                                iconData: Icons.arrow_forward),

                            // const SectionHeader(
                            // title: 'Recently viewed',
                            // subtitle:
                            //     'You probably didn\'t read them through.'),
                            // RecentlyViewedList(recentlyViewedCourses: courseData)(),
                          ],
                        ))),
                    Obx(() => Column(children: [
                          const SectionHeader(
                              title: 'Courses',
                              subtitle: 'Your courses this term'),
                          ...courseController.courseList.map((course) {
                            final title = course['title'] as String;
                            // final icon = course['icon'] as String;

                            return CourseCard(
                              title: title,
                              icon: Icons.abc,
                            );
                          })
                        ])),
                  ])),
        ),
      ),
    );
  }
}

class RecentlyViewedList extends StatelessWidget {
  final List<Map<String, dynamic>> recentlyViewedCourses;

  const RecentlyViewedList({super.key, required this.recentlyViewedCourses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recentlyViewedCourses.map((course) {
        final title = course['title'] as String;
        final description = course['description'] as String;
        final showDueIndicator = course['showDueIndicator'] as bool;
        final courseTitle = course['courseTitle'] as String;
        return RecentlyViewedCard(
          title: title,
          description: description,
          showDueIndicator: showDueIndicator,
          courseTitle: courseTitle,
        );
      }).toList(),
    );
  }
}
