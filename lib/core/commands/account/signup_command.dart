import 'package:dartz/dartz.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';

import '../../../l10n/my.i18n.dart';
import '../../data/failure.dart';
import '../base_command.dart';

// ignore_for_file: comment_references
class SignupCommand extends BaseCommand {
  /// Create Account
  ///
  /// Use this endpoint to allow a new user to register a new account in your
  /// project. After the user registration completes successfully, you can use
  /// the [/account/verfication](/docs/client/account#accountCreateVerification)
  /// route to start verifying the user email address. To allow the new user to
  /// login to their new account, you need to create a new [account
  /// session](/docs/client/account#accountCreateSession).
  Future<Either<Failure, bool>> run({required BuildContext context, required String? username, required String email, required String password}) async {
    // Await service call
    final bool signupSuccess = await context.authNotifier.create(name: username, email: email, password: password);
    
    // Update appModel with current user. Any views bound to this will rebuild
    appModel.currentUser = signupSuccess? appwriteService.user?.id : null;
 
    // Return the result to whoever called us, in case they care
    if (signupSuccess == true) {
      return Right(signupSuccess);
    } else {
      return Left(Failure(appwriteService.error ?? 'Unknown error'.i18n));
    }
  }
}