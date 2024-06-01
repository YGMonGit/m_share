import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/Components/input.box.dart';
import 'package:m_share/controller/course.controller.dart';
import 'package:m_share/controller/user_controller.dart';
import 'package:m_share/controller/note.controller.dart';

class AddMaterialPage extends StatefulWidget {
  const AddMaterialPage({super.key});

  @override
  State<AddMaterialPage> createState() => _AddMaterialPageState();
}

class _AddMaterialPageState extends State<AddMaterialPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final Rx<DateTime?> _selectedDate = DateTime.now().obs;
  final RxString _selectedType = 'Note'.obs;
  String? _selectedFileName;
  String? _selectedFilePath;

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

  // void check() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("${userController.user.value['id']}"),
  //     ),
  //   );
  // }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> materialData = {
        'title': _titleController.text,
        'course_id': userController.user.value['course_id'],
        'file_path': _selectedFilePath,
      };

      if (_selectedType.value == 'Assignment') {
        materialData['due_date'] = _selectedDate.value?.toIso8601String();
        courseController.addAssignment(materialData);
      } else {
        noteController.addNote(materialData);
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         check();
        //       },
        //       icon: const Icon(Icons.settings)),
        // ],
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
                        // if (userController.isAdmin.value)
                        'Assignment'
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
                ElevatedButton(
                  onPressed: _selectFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    minimumSize: const Size(0, 50),
                  ),
                  child: const Text('Select File'),
                ),
                if (_selectedFileName != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Selected File: $_selectedFileName'),
                  ),
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
                Obx(() {
                  if (_selectedType.value != 'Note') {
                    return const SizedBox(height: 25.0);
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
