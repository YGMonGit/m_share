import 'package:get/get.dart';
import 'package:m_share/util/database.helper.dart';

class NoteController extends GetxController {
  var notes = <Map<String, dynamic>>[].obs;
  final dbHelper = DatabaseHelper();

  Future<void> getNotes() async {
    notes.assignAll(await dbHelper.getNotes());
    print("************");
    print(notes);
  }

  Future<void> getNotesByCourseId(int courseId) async {
    notes.assignAll(await dbHelper.getNotesByCourseId(courseId));
    print("************");
    print(notes);
  }

  Future<void> addNote(Map<String, dynamic> note) async {
    await dbHelper.insertNote({
      'title': note['title'],
      'course_id': note['course_id'],
      'due_date': note['due_date'],
    });
    getNotes();
  }

  @override
  void onInit() {
    getNotes();
    super.onInit();
  }
}
