import 'package:get/get.dart';
import '../util/database.helper.dart';

class CourseController extends GetxController {
  var courseList = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> assignmentList = RxList([]);
  var assignmentOverdueCount = 0.obs;
  var overDueAssignment = <Map<String, dynamic>>[].obs;
  var assignmentCloseDueCount = 0.obs;
  final searchResults = <Map<String, dynamic>>[].obs;
  final dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  Future<void> loadCourses() async {
    final courses = await dbHelper.getCourses();
    courseList.assignAll(courses);

    for (var course in courses) {
      final courseId = course['id'] as int;
      final assignments = await dbHelper.getAssignmentsByCourseId(courseId);
      assignmentList.addAll(assignments);
    }
  }

  Future<void> addCourse(Map<String, dynamic> course) async {
    await dbHelper.insertCourse(course);
    loadCourses();
  }

  Future<void> updateCourse(Map<String, dynamic> course) async {
    await dbHelper.updateCourse(course);
    loadCourses();
  }

  Future<void> deleteCourse(int id) async {
    await dbHelper.deleteCourse(id);
    loadCourses();
  }

  Future<void> addAssignment(Map<String, dynamic> assignment) async {
    await dbHelper.insertAssignment(assignment);
  }

  Future<void> updateAssignment(Map<String, dynamic> assignment) async {
    await dbHelper.updateAssignment(assignment);
  }

  Future<void> deleteAssignment(int id) async {
    await dbHelper.deleteAssignment(id);
  }

  Future<void> getAssignmentsByCourseId(int courseId) async {
    final assignments = await dbHelper.getAssignmentsByCourseId(courseId);
    assignmentList.assignAll(assignments);
  }

  Future<void> getAssignments() async {
    final assignments = await dbHelper.getAssignments();
    assignmentList.assignAll(assignments);
    calculateAssignmentCounts();
  }

  Future<void> getOverdueAssignments() async {
    final assignments = await dbHelper.getOverDueAssignments();
    overDueAssignment.assignAll(assignments);
    // assignmentOverdueCount.value = assignments.length;
  }

  void calculateAssignmentCounts() {
    final now = DateTime.now();
    int overdueCount = 0;
    int closeDueCount = 0;

    for (var assignment in assignmentList) {
      if (assignment['due_date'] != null) {
        final dueDate = DateTime.parse(assignment['due_date']);
        final isOverdue = dueDate.isBefore(now);
        final closeDue = dueDate.difference(now).inDays <= 7;

        if (isOverdue) {
          overdueCount++;
        } else if (closeDue) {
          closeDueCount++;
        }
      }
    }

    assignmentOverdueCount.value = overdueCount;
    assignmentCloseDueCount.value = closeDueCount;
  }

  void search(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    var filteredCourses = courseList
        .where((course) =>
            course['title'].toLowerCase().contains(query.toLowerCase()))
        .map((course) => {
              'title': course['title'],
              'type': 'course',
            })
        .toList();

    var filteredAssignments = assignmentList
        .where((assignment) =>
            assignment['title'].toLowerCase().contains(query.toLowerCase()))
        .map((assignment) => {
              'title': assignment['title'],
              'type': 'assignment',
            })
        .toList();

    searchResults.assignAll([...filteredCourses, ...filteredAssignments]);
  }
}
