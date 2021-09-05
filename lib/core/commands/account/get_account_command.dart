import 'package:appwrite/appwrite.dart';
import '../base_command.dart';

class GetAccountCommand extends BaseCommand {
 
  Future<Response> run() async {
    // Await service call
    final Response res = await appwriteService.account.get();
    return res;
  }
}