import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/section.dart';

class SectionHeader extends StatelessWidget {
  @override

  const SectionHeader(this.section);
  final Section section;
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '${section.name ?? "Banana"}',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}
