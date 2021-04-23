import 'package:flutter/material.dart';
import 'package:michellemirandastore/models/home_manager.dart';
import 'package:michellemirandastore/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  final HomeManager homeManager;
  AddSectionWidget(this.homeManager);
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: ()  {
            homeManager.addSection(Section(type: 'List'));
            },
            child: Text(
              'Adicionar Lista',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: ()  {
              homeManager.addSection(Section(type: 'Staggered'));
            },
            child: Text(
              'Adicionar Grade',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
