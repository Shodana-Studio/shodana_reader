import 'dart:io' as io;

import 'package:clipboard/clipboard.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_screen/provider/bottom_navigation_provider.dart';
import 'more_about_screen_mobile.dart';

class AboutScreen extends HookWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read(shouldShowBottomNavigationProvider).state = true;
        return true;
      },
      child: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => MoreAboutScreenMobile(
          aboutFuture: aboutFuture(context),
        ),
        tablet: (BuildContext context) => MoreAboutScreenMobile(
          aboutFuture: aboutFuture(context),
        ),
        desktop: (BuildContext context) => MoreAboutScreenMobile(
          aboutFuture: aboutFuture(context),
        ),
        watch: (BuildContext context) => MoreAboutScreenMobile(
          aboutFuture: aboutFuture(context),
        ),
      ),
    );
  }

  Future<Widget> aboutFuture(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // final String appName = packageInfo.appName;
    // final String packageName = packageInfo.packageName;
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    const String website = 'https://www.shodana.app';
    const String github = 'https://www.github.com/Shodana-Studio/shodana_reader';
    const String discord = 'https://www.shodana.app/discord';

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.aboutPageTitle)
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                key: const ValueKey('version'),
                title: Text(AppLocalizations.of(context)!.versionButtonText),
                subtitle: Text('Alpha $version+$buildNumber'),
                onTap: () => versionOnPressed(context,
                    deviceInfo, version, buildNumber)
            ),
            const Divider(height: 1.0),
            // SettingsSection(
            //   title: '',
            //   tiles: const [],
            // ),
            ListTile(
                key: const ValueKey('website'),
                title: Text(AppLocalizations.of(context)!.websiteButtonText),
                subtitle: const Text(website),
                onTap: () => _launchURL(website)
            ),
            ListTile(
                key: const ValueKey('discord'),
                title: Text(AppLocalizations.of(context)!.discordButtonText),
                subtitle: const Text(discord),
                onTap: () => _launchURL(discord)
            ),
            ListTile(
                key: const ValueKey('github'),
                title: Text(AppLocalizations.of(context)!.githubButtonText),
                subtitle: const Text(github),
                onTap: () => _launchURL(github)
            ),
            ListTile(
                key: const ValueKey('licenses'),
                title: Text(AppLocalizations.of(context)!.licensesButtonText),
                onTap: () => showAboutDialog(
                  context: context,
                  applicationName: AppLocalizations.of(context)!.appName,
                  applicationVersion: version,
                  applicationLegalese: AppLocalizations.of(context)!.applicationLegalese
                )
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : print('Could not launch $url');

  Future<void> versionOnPressed(
      BuildContext context, DeviceInfoPlugin
      deviceInfo, String version, String buildNumber
  ) async {
    String versionText = '';
    if (kIsWeb) {
      versionText = 'Copied to clipboard:'
          '\nApp version: $version'
          '\nPlatform: Web';
    }
    else if (io.Platform.isIOS) {
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
      // final isDark = AdaptiveTheme.of(context).mode.isDark;
      // final isLight = AdaptiveTheme.of(context).mode.isLight;
      // final isSystem = AdaptiveTheme.of(context).mode.isSystem;
      final backgroundColor = Theme.of(context).appBarTheme
          .backgroundColor;
      final titleTextStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
        color: Theme.of(context).textTheme.headline6?.color,
      );
      final snackBar = SnackBar(
        backgroundColor: backgroundColor,
        content: RichText(
          key: const ValueKey('device_info'),
          text: TextSpan(
            text: versionText,
            style: titleTextStyle,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}