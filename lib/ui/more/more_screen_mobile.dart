import 'package:cached_network_image/cached_network_image.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../l10n/my.i18n.dart';
import 'widgets/settings_list.dart';

class MoreScreenMobile extends StatelessWidget {
  const MoreScreenMobile({
    Key? key,
    required this.settingsOnPressed,
    required this.aboutOnPressed,
    required this.user,
  }) : super(key: key);
  final VoidCallback settingsOnPressed;
  final VoidCallback aboutOnPressed;
  final User? user;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final Client? client = context.authNotifier.client;
    final Avatars? avatars = (client == null) ? null : Avatars(client);
    
    return Scaffold(
      appBar: AppBar(title: Text('Account'.i18n)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user != null && avatars != null) ...[
            ListTile(
              onTap: () {},
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: buildProfileImage(client!),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: buildLogOutAlertDialog,
                  );
                },
                icon: const Icon(Icons.logout),
              ),
              title: Text(user!.name),
              subtitle: Text(user!.email),
              // subtitle: const Text('Pauses reading history'.i18n),
            ),
            const Divider(height: 16,),
          ],
          SettingsList(
            settingsOnPressed: settingsOnPressed,
            aboutOnPressed: aboutOnPressed,
          ),
        ],
      ),
    );
  }

  AlertDialog buildLogOutAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Log out'.i18n),
      content: Text("Are you sure? You won't be able "
          'to access any online content without being '
          'logged in.'.i18n),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: Theme.of(context).textButtonTheme.style,
          child: Text('CANCEL'.i18n),
        ),
        TextButton(
          onPressed: () {
            context.authNotifier.deleteSession();
            Navigator.of(context).pop();
          },
          style: Theme.of(context).textButtonTheme.style,
          child: Text('LOGOUT'.i18n),
        ),
      ],
    );
  }

  /// for avatars get initials
  /// <your_endpoint>/avatars/initials?project=<your_project_id>&name=Damodar%20Lohani&width=100&height=100
  /// and for storage images
  /// <YOUR_ENDPOINT>/storage/files/<FILE_ID>/preview?width=350&height=250&project=<YOUR_PROJECT_ID>
  CachedNetworkImage buildProfileImage(Client client) {
    return CachedNetworkImage(
      imageUrl: '${client.endPoint}/avatars/initials?project=60a984c918aa7'
          '&name=${user!.name}&width=100&height=100',
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}