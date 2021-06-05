import 'package:flutter/material.dart';
import '../../../l10n/tr.dart';

class MoreSettingsScreenMobile extends StatelessWidget {
  const MoreSettingsScreenMobile({
    Key? key,
    required this.generalOnPressed}) : super(key: key);
  final VoidCallback generalOnPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(TR.of(context)!.settingsPageTitle)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(TR.of(context)!.generalButtonText),
            leading: Icon(
              Icons.tune,
              color: Theme.of(context).primaryColor,
            ),
            onTap: generalOnPressed,
          ),
        ],
      ),
    );
  }
}
