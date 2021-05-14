import 'package:flutter/material.dart';

enum BottomNavItems {home, shelves, clubs, discover, more}

abstract class StartingScreenSource {
  Future<BottomNavItems?> loadStartingScreen();

  Future<bool> saveStartingScreen(BottomNavItems screen);
}