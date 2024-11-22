import 'package:flutter/material.dart';

class HomeNavigatorModel {
  String name;
  IconData icon;
  Widget screen;

  HomeNavigatorModel(
      {required this.name, required this.icon, required this.screen});
}
