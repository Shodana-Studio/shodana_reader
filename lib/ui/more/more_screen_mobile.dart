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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.morePageTitle)),
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
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(360.0),
                  child: Image.memory(
                    (snapshot.data! as Response).data,
                    fit: BoxFit.contain,
                    width: 80.0,
                  ),
                ) : const CircularProgressIndicator();
              },
            ),
            Text(user!.name),
            Text(user!.email),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  context.authNotifier?.deleteSession();
                },
                child: const Text('Logout'))
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