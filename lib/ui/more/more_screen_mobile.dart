import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final Client? client = context.authNotifier?.client;
    final Avatars? avatars = (client == null) ? null : Avatars(client);
    
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.accountPageTitle)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user != null && avatars != null) ...[
            FutureBuilder(
              future: avatars.getInitials(
              ), //works for both public file and private file, for private files you need to be logged in
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData && snapshot.data != null
                    ? ListTile(
                  onTap: () {},
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(90.0),
                    child: Image.memory(
                      (snapshot.data! as Response).data,
                      fit: BoxFit.contain,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Log out'),
                            content: const Text("Are you sure? You won't be able "
                                'to access any online content without being '
                                'logged in.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: Theme.of(context).textButtonTheme.style,
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.authNotifier?.deleteSession();
                                  Navigator.of(context).pop();
                                },
                                style: Theme.of(context).textButtonTheme.style,
                                child: const Text('LOGOUT'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.logout),
                  ),
                  title: Text(user!.name),
                  subtitle: Text(user!.email),
                  // subtitle: const Text('Pauses reading history'),
                ) : const CircularProgressIndicator();
              },
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
}