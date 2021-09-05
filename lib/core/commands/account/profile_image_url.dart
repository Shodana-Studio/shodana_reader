import '../base_command.dart';

class ProfileImageCommand extends BaseCommand {
 
  String run(String name) {
    // Await service call
    final String profileImage = appwriteService.getInitialsLink(name);
 
    // Return the result to whoever called us, in case they care
    return profileImage;
  }
}