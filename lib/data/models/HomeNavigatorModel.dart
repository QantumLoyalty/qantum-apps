import 'package:flutter/material.dart';

class HomeNavigatorModel {
  String name;
  IconData icon;
  Widget screen;
  String type;
  static const typeDialog = "DIALOG";
  static const typeScreen = "SCREEN";

  HomeNavigatorModel(
      {required this.name,
      required this.icon,
      required this.screen,
      required this.type});
}
