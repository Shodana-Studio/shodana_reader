import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.morePageTitle)),
      body: Column(
        children: [
          if (user != null) ...[
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