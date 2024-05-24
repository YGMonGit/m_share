import 'package:flutter/material.dart';

class Homes extends StatelessWidget {
  const Homes({super.key});

  @override
  Widget build(BuildContext context) {
    final courseData = [
      {'title': 'Data structure and algorithms', 'icon': Icons.laptop},
      {'title': 'Economics', 'icon': Icons.bookmark_outline},
      {
        'title': 'Communicative English Skills II',
        'icon': Icons.bookmark_outline
      },
      {'title': 'Global Trends', 'icon': Icons.bookmark_outline},
      {'title': 'Computer Programming I', 'icon': Icons.laptop},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildOverviewCard(
                    2, 'Assignments Overdue', Colors.red, Icons.arrow_forward),
                _buildOverviewCard(5, 'Assignments Due',
                    const Color(0xFFE2E600), Icons.arrow_forward),
                _buildSectionHeader('Recently viewed',
                    'You probably didn\'t read them through.'),
                _buildRecentlyViewedList(),
                _buildSectionHeader('Courses', 'Your courses this term'),
                ...courseData.map((course) => _buildCourseCard(
                    course['title']! as String, course['icon']! as IconData)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard(
      int count, String title, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFFBECEE),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF7CACF),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 80,
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(icon),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF36454F),
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Color(0xFF8C959B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyViewedList() {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRecentlyViewedCard(
                'Assignment title',
                'Assignment Description',
                true,
                'Course Title',
              ),
              _buildRecentlyViewedCard(
                'Note title',
                'Note Description',
                false,
                'Course Title',
              ),
              _buildRecentlyViewedCard(
                'Assignment title',
                'Assignment Description',
                true,
                'Course Title',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyViewedCard(
    String title,
    String description,
    bool showDueIndicator,
    String courseTitle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: !showDueIndicator
                ? const Color.fromARGB(255, 140, 140, 192)
                : const Color.fromARGB(255, 231, 233, 98),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 184, 190),
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[800],
                ),
              ),
              if (showDueIndicator)
                Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9C2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Due',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF818300),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 5.0),
              if (!showDueIndicator) const SizedBox(height: 65.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    courseTitle,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(String title, IconData icon) {
    return FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              height: 80,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFCCCCCC),
                    width: 2.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 30.0,
                        color: const Color(0xFF3CC6CA),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
