import 'package:appwrite/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../base_command.dart';

final getAccountCommandProvider = Provider<GetAccountCommand>((ref) {
  return GetAccountCommand(ref);
});

class GetAccountCommand extends BaseCommand {
  GetAccountCommand(ProviderRef ref) : super(ref);

 
  Future<User> run() async {
    // Await service call
    final User user = await appwriteService.account.get();
    return user;
  }
}