import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/section.dart';

class SectionHeader extends StatelessWidget {
  @override

  const SectionHeader(this.section);
  final Section section;
  Widget build(BuildContext context) {
    return Text(
      '${section.name}'
    );
  }
}
