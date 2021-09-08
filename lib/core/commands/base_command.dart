import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../model/app_model.dart';
import '../model/user_model.dart';
import '../service/appwrite_service.dart';

late BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  // Models
  UserModel userModel = _mainContext.read(userModelProvider);
  AppModel appModel = _mainContext.read(appModelProvider).state;
  // Services
  AppwriteService appwriteService = _mainContext.read(appwriteServiceProvider);
}