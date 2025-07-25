import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: 'Home', icon: Icons.home_outlined),
  Destination(label: 'Search', icon: Icons.search_outlined),

  Destination(label: 'Profile', icon: Icons.person_outline_outlined),
];
