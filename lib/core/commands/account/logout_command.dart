import 'package:flutter/cupertino.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../base_command.dart';

final logoutCommandProvider = Provider<LogoutCommand>((ref) {
  return LogoutCommand(ref);
});

class LogoutCommand extends BaseCommand {
  LogoutCommand(ProviderRef ref) : super(ref);

 
  Future<bool> run({required BuildContext context}) async {
    // Await service call
    final bool logoutSuccess = await context.authNotifier.deleteSession();
 
    // Return the result to whoever called us, in case they care
    return logoutSuccess;
  }
}