import 'package:dartz/dartz.dart';

import '../../../l10n/my.i18n.dart';
import '../../data/failure.dart';
import '../../service/authnotifier_extension.dart';
import '../base_command.dart';
import '../refresh_books_command.dart';

class OAuthLoginCommand extends BaseCommand {
 
  /// Create Account Session with OAuth2
  /// 
  /// Allow the user to login to their account using the OAuth2 provider of their choice.
  /// Each OAuth2 provider should be enabled from the Appwrite console first.
  /// Use the success and failure arguments to provide a redirect URL's back to your app when login is completed.
  Future<Either<Failure, bool>> run({required OAuth provider}) async {
    // Await service call
    final bool loginSuccess = await appwriteService.createOAuth2SessionFromEnum(provider: provider);
 
    // Run a 2nd command if service call was successful
    if (loginSuccess) {
      await RefreshBooksCommand().run();
    }
 
    // Return the result to whoever called us, in case they care
    if (loginSuccess == true) {
      return Right(loginSuccess);
    } else {
      return Left(Failure(appwriteService.error ?? 'Unknown error'.i18n));
    }
  }
}