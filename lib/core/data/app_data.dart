// ignore_for_file: sort_constructors_first
import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../app_constants.dart';

@immutable
class AppData extends Equatable {
  const AppData({
    this.darkMode = true,
    this.followSystemTheme = true,
    this.defaultStartingPage = AppPage.home,
    this.lastUsedEnabled = true,
    this.lastUsedPage = AppPage.home,
    this.leftHandedNavigationRail = false,
  });

  // Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
  /// Enable dark mode
  final bool darkMode;

  /// Follow the system theme mode
  final bool followSystemTheme;

  /// Set which page to open to
  final AppPage defaultStartingPage;

  /// Should app open to the last used page
  final bool lastUsedEnabled;
  final AppPage lastUsedPage;

  /// Move navigation rail to the left
  final bool leftHandedNavigationRail;

  AppData copyWith({
    User? currentUser,
    bool? darkMode,
    bool? followSystemTheme,
    AppPage? defaultStartingPage,
    bool? lastUsedEnabled,
    AppPage? lastUsedPage,
    bool? leftHandedNavigationRail,
  }) {
    return AppData(
      darkMode: darkMode ?? this.darkMode,
      followSystemTheme: followSystemTheme ?? this.followSystemTheme,
      defaultStartingPage: defaultStartingPage ?? this.defaultStartingPage,
      lastUsedEnabled: lastUsedEnabled ?? this.lastUsedEnabled,
      lastUsedPage: lastUsedPage ?? this.lastUsedPage,
      leftHandedNavigationRail: leftHandedNavigationRail ?? this.leftHandedNavigationRail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'darkMode': darkMode,
      'followSystemTheme': followSystemTheme,
      'defaultStartingPage': EnumToString.convertToString(defaultStartingPage),
      'lastUsedEnabled': lastUsedEnabled,
      'lastUsedPage': EnumToString.convertToString(lastUsedPage),
      'leftHandedNavigationRail': leftHandedNavigationRail,
    };
  }

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      darkMode: map['darkMode'],
      followSystemTheme: map['followSystemTheme'],
      defaultStartingPage: EnumToString.fromString(AppPage.values, map['defaultStartingPage']) ?? AppPage.home,
      lastUsedEnabled: map['lastUsedEnabled'],
      lastUsedPage: EnumToString.fromString(AppPage.values, map['lastUsedInt']) ?? AppPage.home,
      leftHandedNavigationRail: map['leftHandedNavigationRail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppData.fromJson(String source) => AppData.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      darkMode,
      followSystemTheme,
      defaultStartingPage,
      lastUsedEnabled,
      lastUsedPage,
      leftHandedNavigationRail,
    ];
  }
}
