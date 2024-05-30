import 'package:get/get.dart';
import '../util/database.helper.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs;
  var isAdmin = false.obs;
  var user = {}.obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();

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
  }
}
