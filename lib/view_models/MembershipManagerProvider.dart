import 'dart:collection';

import 'package:flutter/material.dart';

class MembershipManagerProvider extends ChangeNotifier {
  static final List<String> list = <String>[
    'Free Membership',
    'Premium Membership',
    'Enterprise Membership'
  ];

  final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(
        value: name,
        label: '',
        labelWidget: Container(
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.white.withAlpha(5)),
        ))),
  );
  String dropdownValue = list.first;

  updateDropdownValue(String value) {
    dropdownValue = value;
    notifyListeners();
  }
}

typedef MenuEntry = DropdownMenuEntry<String>;
