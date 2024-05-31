import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/Components/input.box.dart';
import 'package:m_share/controller/course.controller.dart';
import 'package:m_share/controller/user_controller.dart';
import 'package:m_share/controller/note.controller.dart';

class AddMaterialPage extends StatelessWidget {
  AddMaterialPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final Rx<DateTime?> _selectedDate = DateTime.now().obs;
  final RxString _selectedType = 'Note'.obs;
  final RxString _selectedCourse = '1'.obs;

  final userController = Get.find<UserController>();
  final noteController = Get.put(NoteController());
  final courseController = Get.find<CourseController>();

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate.value) {
      print(picked);
      _selectedDate.value = picked;
    }
  }

  void _submit() {
    print(_selectedDate.value);
    if (_formKey.currentState!.validate()) {
      if (_selectedDate.value == null) {
        noteController.addNote({
          'title': _titleController.text,
          'due_date': _selectedDate.value,
          'course_id': _selectedCourse.value,
        });
      } else {
        courseController.addAssignment({
          'title': _titleController.text,
          'due_date': _selectedDate.value!.toIso8601String(),
          'course_id': _selectedCourse.value,
        });
      }
      Get.snackbar('Success', 'Material added successfully');
    } else {
      Get.snackbar('Error',
          'Please fill all fields, select a due date, and upload a file');
    }
  }

  @override
  Widget build(BuildContext context) {
    courseController.loadCourses();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 80,
        title: const Text(
          'Add Material',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF36454F),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() => DropdownButtonFormField<String>(
                      value: _selectedType.value,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: Colors.grey[600]!,
                            width: 1.5,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      dropdownColor: Colors.grey[200],
                      items: [
                        'Note',
                        if (userController.isAdmin.value) 'Assignment'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _selectedType.value = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a type';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 25.0),
                DropdownButtonFormField<String>(
                  value: _selectedCourse.value,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: Colors.grey[600]!,
                        width: 1.5,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  dropdownColor: Colors.grey[200],
                  // ignore: invalid_use_of_protected_member
                  items: courseController.courseList.value.map((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value['id'].toString(),
                      child: Text(value['title']),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedCourse.value = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a course';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                InputBox(
                  controller: _titleController,
                  labelText: 'Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter material title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                const SizedBox(height: 25.0),
                Obx(() {
                  if (_selectedType.value != 'Note') {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate.value == null
                                ? 'No due date chosen!'
                                : 'Due Date: ${_selectedDate.value!.toLocal().toString().split(' ')[0]}',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDueDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            minimumSize: const Size(0, 50),
                          ),
                          child: const Text('Select Due Date'),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: const Size(0, 50),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
