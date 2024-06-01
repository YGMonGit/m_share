import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/Components/input.box.dart';
import 'package:m_share/controller/user_controller.dart';
import 'package:m_share/controller/course.controller.dart';

class AddUserPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RxString _selectedType = 'Student'.obs;
  final RxInt _selectedCourseId = 1.obs;
  final courseController = Get.put(CourseController());

  AddUserPage({super.key});

  void _addUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final userController = Get.find<UserController>();
      await userController.addUser(
        _usernameController.text,
        _passwordController.text,
        _selectedType.value,
        _selectedCourseId.value,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 80,
        title: const Text(
          'Add User',
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
                Obx(
                  () => DropdownButtonFormField<String>(
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
                    items: ['Student', 'Teacher', 'Admin'].map((String value) {
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
                        return 'Please select user type';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 25.0),
                InputBox(
                  controller: _usernameController,
                  labelText: 'Username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                InputBox(
                  controller: _passwordController,
                  labelText: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                Obx(() => DropdownButtonFormField<int>(
                      value: _selectedCourseId.value,
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
                      items: courseController.courseList.map((course) {
                        return DropdownMenuItem<int>(
                          value: course['id'],
                          child: Text(course['title']),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        _selectedCourseId.value = newValue!;
                      },
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'Please select a course';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: () => _addUser(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: const Size(0, 50),
                  ),
                  child: const Text(
                    'Create User',
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