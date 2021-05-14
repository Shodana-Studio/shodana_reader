import 'dart:io' as io;

import 'package:clipboard/clipboard.dart';
import 'package:beamer/beamer.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    else if (option == 'general') {
      return general(context);
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
          title: Text(AppLocalizations.of(context)?.settingsPageTitle
              ?? 'No Title')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          SettingsIconButton(
              key: const Key('general'),
              text: 'General',
              icon: Icons.tune,
              onPressed: () => context.beamToNamed('/more/settings/general')
          ),
        ],
      ),
    );
  }

  Widget about(BuildContext context) {
    return FutureBuilder(
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print('Error');
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(child: snapshot.data,);
          }

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            // ignore: sized_box_for_whitespace
            return Container(
                height: MediaQuery.of(context).size.height /
                    1.25,
                width: MediaQuery.of(context).size.width /
                    1.25,
                child: const CircularProgressIndicator());
          }

          return Container();
        },
        future: aboutFuture(context)
    );
  }

  Future<Widget> aboutFuture(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String appName = packageInfo.appName;
    final String packageName = packageInfo.packageName;
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.aboutPageTitle ?? 'No '
              'Title')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          SettingsItemButton(
              key: const Key('version'),
              text: 'Version',
              secondaryText: 'Alpha $version+$buildNumber',
              onPressed: () async {
                String versionText;
                if (io.Platform.isIOS) {
                  final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                  versionText = 'Copied to clipboard:'
                      '\nApp version: $version (build $buildNumber)'
                      '\nCurrent Operating System name: ${iosInfo.systemName}'
                      '\niOS version: ${iosInfo.systemVersion}'
                      '\nUtsname version: ${iosInfo.utsname.version}'
                      '\nUtsname release: ${iosInfo.utsname.release}'
                      '\nUtsname machine: ${iosInfo.utsname.machine}'
                      '\nUtsname System name: ${iosInfo.utsname.sysname}'
                      '\nDevice name: ${iosInfo.name}'
                      '\nDevice model: ${iosInfo.model}'
                      '\nDevice localized model: ${iosInfo.localizedModel}';
                } else if (io.Platform.isAndroid) {
                  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                  versionText = 'Copied to clipboard:'
                      '\nApp version: $version (build $buildNumber)'
                      '\nAndroid version: ${androidInfo.version.release} '
                      '(SDK ${androidInfo.version.sdkInt})'
                      '\nAndroid version incremental: ${androidInfo.version.incremental}'
                      '\nDevice brand: ${androidInfo.brand}'
                      '\nDevice manufacturer: ${androidInfo.manufacturer}'
                      '\nDevice name: ${androidInfo.device}'
                      '\nDevice model: ${androidInfo.model}'
                      '\nDevice product name: ${androidInfo.product}';
                } else {
                  versionText = 'Copied to clipboard:\nApp version: $version';
                }
                // ignore_for_file: unawaited_futures
                FlutterClipboard.copy(versionText).then((_) {
                  final snackBar = SnackBar(
                    content: RichText(
                      key: const Key('device_info'),
                      text: TextSpan(
                        text: versionText,
                      ),
                      // maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                      },
                    ),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
          ),
        ],
      ),
    );
  }

  Widget general(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.generalPageTitle
            ?? 'No Title'),
      ),
    );
  }
}