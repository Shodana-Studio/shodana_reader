// ignore_for_file: sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';

@immutable
class AppData extends Equatable {
  const AppData({
    this.currentUser,
  });

  final User? currentUser;

  AppData copyWith({
    User? currentUser,
  }) {
    return AppData(
      currentUser: currentUser ?? this.currentUser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentUser': currentUser?.toMap(),
    };
  }

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      currentUser: User.fromMap(map['currentUser']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppData.fromJson(String source) => AppData.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [currentUser ?? 'Not logged in'];
}
