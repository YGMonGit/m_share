import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String subtitle;
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
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
}
