import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' as io;
import 'package:clipboard/clipboard.dart';
import 'package:shodana_reader/features/more/widgets/settings_icon_button.dart';
import 'package:shodana_reader/features/more/widgets/settings_item_button.dart';


class MoreDetailsScreen extends StatelessWidget {
  const MoreDetailsScreen({Key? key, required this.option}) : super(key: key);
  final String option;

  @override
  Widget build(BuildContext context) {
    if (option == 'settings') {
      return settings(context);
    }
    else if (option == 'about') {
      return about(context);
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error: Unknown Page'),
        ),
      );
    }
  }

  Widget settings(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          SettingsIconButton(
              key: const Key('appearance'),
              text: 'Appearance',
              icon: Icons.settings_outlined,
              onPressed: () {}
          ),
        ],
      ),
    );
  }

  Widget about(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          SettingsItemButton(
              key: const Key('version'),
              text: 'Version',
              secondaryText: 'Alpha 0.0.1',
              onPressed: () async {
                final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                const String version = '0.0.1';
                String versionText;
                if (io.Platform.isIOS) {
                  final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                  versionText = 'App version: $version\n${iosInfo.utsname}';
                } else if (io.Platform.isAndroid) {
                  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                  versionText = 'App version: $version\nAndroid '
                      'version: ${androidInfo.version.release} (SDK '
                      '${androidInfo.version.sdkInt})'
                      '\nAndroid build ID: ${androidInfo.version.incremental}'
                      '\nDevice brand: ${androidInfo.brand}'
                      '\nDevice manufacturer: ${androidInfo.manufacturer}'
                      '\nDevice name: ${androidInfo.device}'
                      '\nDevice model: ${androidInfo.model}'
                      '\nDevice product name: ${androidInfo.product}';
                } else {
                  versionText = 'App version: $version';
                }
                await FlutterClipboard.copy(versionText).then((value) {
                });
                final snackBar = SnackBar(
                  content: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Copied to clipboard:'),
                          RichText(
                            key: const Key('device_info'),
                            text: TextSpan(
                              text: versionText,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                      ]),
                    ],
                  ),
                  action: SnackBarAction(
                    label: 'Close',
                    onPressed: () {
                    },
                  ),
                  duration: const Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
          ),
        ],
      ),
    );
  }
}