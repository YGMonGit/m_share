import 'package:get/get.dart';
import '../util/database.helper.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs;
  var isAdmin = false.obs;
  var user = {}.obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  var users = <Map<String, dynamic>>[].obs;

  Future<void> login(String username, String password) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _user = await _dbHelper.getUser(username, password);
    if (_user != null) {
      user.value = _user;
      isLoggedIn.value = true;
      isAdmin.value = user['role'] == 'admin';
    } else {
      isLoggedIn.value = false;
      isAdmin.value = false;
      user.value = {};
    }
  }

  void logout() {
    isLoggedIn.value = false;
    isAdmin.value = false;
    user.value = {};
  }

  Future<void> getUsers() async {
    users.value = await _dbHelper.getUsers();
  }

  Future<void> addUser(String username, String password, String role , int courseId) async {
    await _dbHelper.insertUser({
      'username': username,
      'password': password,
      'role': role,
      'course_id': courseId,
    });
    getUsers();
  }

  Future<void> removeUser(int id) async {
    await _dbHelper.deleteUser(id);
    await getUsers();
  }

  Future<void> updatePassword(String newPassword) async {
    if (user.value.isNotEmpty) {
      await _dbHelper.updateUserPassword(user.value['id'], newPassword);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }
}
