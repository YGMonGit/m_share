import 'homes.dart';
import 'notifications.dart';
import 'search.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _listPage = [];
  late Widget _currentPage;

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
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF36454F),
                ),
              ),
              Text(
                'Kaleab',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF8C959B),
                ),
              ),
            ],
          ),
        ),
        body: _currentPage,
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