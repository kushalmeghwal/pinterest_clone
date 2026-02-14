

import 'package:flutter/material.dart';

class SharePage extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const SharePage({
    required this.icon,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: color ?? const Color(0xFFE9E9E9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}
