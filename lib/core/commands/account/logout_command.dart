import 'package:flutter/cupertino.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';

import '../base_command.dart';

class LogoutCommand extends BaseCommand {
 
  Future<bool> run(BuildContext c) async {
    // Await service call
    final bool logoutSuccess = await c.authNotifier.deleteSession();
 
    // Return the result to whoever called us, in case they care
    return logoutSuccess;
  }
}