import 'package:flutter/material.dart';

class RecentlyViewedCard extends StatelessWidget {
  final String title;
  final String description;
  final bool showDueIndicator;
  final String courseTitle;

  const RecentlyViewedCard({
    super.key,
    required this.title,
    required this.description,
    required this.showDueIndicator,
    required this.courseTitle,
  });

  @override
  Widget build(BuildContext context) {
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
}
