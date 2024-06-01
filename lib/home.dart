import 'homes.dart';
import 'notifications.dart';
import 'search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_share/controller/user_controller.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({super.key, required this.username});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _listPage = [];
  late Widget _currentPage;
  final UserController _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _listPage
      ..add(const Homes())
      ..add(const Search())
      ..add(const Notifications());

    _currentPage = _listPage[_currentIndex];
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPage[selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFD),
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF36454F),
              ),
            ),
            Text(
              widget.username, // Use widget.username here
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Color(0xFF8C959B),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/changePassword');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: _currentPage,
      floatingActionButton: _userController.user.value['role'] == 'Teacher'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addMaterial');
              },
              tooltip: 'Add New Material',
              foregroundColor: Colors.black,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          )
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}