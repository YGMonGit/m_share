import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/controller/course.controller.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (query) {
              courseController.search(query);
            },
          ),
        ),
        Expanded(
          child: Obx(() {
            if (courseController.searchResults.isEmpty) {
              return const Center(
                child: Text('No results found'),
              );
            }
            return ListView.builder(
              itemCount: courseController.searchResults.length,
              itemBuilder: (context, index) {
                var result = courseController.searchResults[index];
                return ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: Text(result['title']),
                  subtitle:
                      result.containsKey('type') ? Text(result['type']) : null,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
