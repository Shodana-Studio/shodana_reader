import 'package:flutter/material.dart';
import '../../../l10n/my.i18n.dart';

class MoreSettingsScreenMobile extends StatelessWidget {
  const MoreSettingsScreenMobile({
    Key? key,
    required this.generalOnPressed}) : super(key: key);
  final VoidCallback generalOnPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Settings'.i18n)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('General'.i18n),
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
