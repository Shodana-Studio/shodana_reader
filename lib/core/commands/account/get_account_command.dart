import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../base_command.dart';

final getAccountCommandProvider = Provider<GetAccountCommand>((ref) {
  return GetAccountCommand(ref);
});

class GetAccountCommand extends BaseCommand {
  GetAccountCommand(ProviderRef ref) : super(ref);

 
  Future<Response> run() async {
    // Await service call
    final Response res = await appwriteService.account.get();
    return res;
  }
}