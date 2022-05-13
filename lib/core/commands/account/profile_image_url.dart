

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../base_command.dart';

final profileImageCommandProvider = Provider<ProfileImageCommand>((ref) {
  return ProfileImageCommand(ref);
});

class ProfileImageCommand extends BaseCommand {
  ProfileImageCommand(ProviderRef ref) : super(ref);

 
  String run({required String name}) {
    // Await service call
    final String profileImage = appwriteService.getInitialsLink(name);
 
    // Return the result to whoever called us, in case they care
    return profileImage;
  }
}