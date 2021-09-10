import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../model/app_model.dart';
import '../model/user_model.dart';
import '../service/appwrite_service.dart';
// The commands will use this to access the Provided models and services.

final baseCommandProvider = Provider<BaseCommand>((ref) {
  return BaseCommand(ref);
});

// Provide quick lookup methods for all the top-level models and services. Keeps the Command code slightly cleaner.
class BaseCommand {
  BaseCommand(this.ref) {
    userModelNotifier = ref.watch(userModelProvider.notifier);
    appModelNotifier = ref.watch(appModelNotifierProvider.notifier);
    appwriteService = ref.watch(appwriteServiceProvider);
  }
  final ProviderRef ref;

  // Models
  late final UserModelNotifier userModelNotifier;
  late final AppModelNotifier appModelNotifier;
  // Services
  late final AppwriteService appwriteService;

}