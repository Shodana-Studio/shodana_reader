import 'package:dartz/dartz.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../l10n/my.i18n.dart';
import '../../data/failure.dart';
import '../base_command.dart';
import '../refresh_books_command.dart';

final loginCommandProvider = Provider<LoginCommand>((ref) {
  return LoginCommand(ref);
});

class LoginCommand extends BaseCommand {
  LoginCommand(ProviderRef ref) : super(ref);

 
  Future<Either<Failure, bool>> run({required BuildContext context, required String email, required String password}) async {
    final log = Logger();

    // Await service call
    final bool loginSuccess = await context.authNotifier.createSession(email: email, password: password);
 
    // Run a 2nd command if service call was successful
    if (loginSuccess) {
      final resp = ref.read(refreshCommandProvider).run();
      // ignore: unawaited_futures
      resp.then((value) => value.fold(
        (l) => log.e(l.message),
        (r) => log.i('Books refreshed'),
      ));
    }
 
    // Return the result to whoever called us, in case they care
    if (loginSuccess == true) {
      return Right(loginSuccess);
    } else {
      return Left(Failure(appwriteService.error ?? 'Unknown error'.i18n));
    }
  }
}
