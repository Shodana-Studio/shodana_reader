import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/my.i18n.dart';
import '../../app_screen/provider/default_starting_page_provider.dart';
import '../../app_screen/provider/starting_screen_provider.dart';
import 'simple_dialog_item.dart';

class StartingScreenWidget extends HookWidget {
  const StartingScreenWidget({Key? key}) : super(key: key);
  // int? _value = 0; // TODO: Store in a provider

  @override
  Widget build(BuildContext context) {
    // TODO: set _value to value from SharedPrefs
    // _value = context.read()
    final String screen = useProvider(startingPageProvider);
    final String subtitle;
    if (screen == 'last_used') {
      subtitle = 'Last used'.i18n;
    } else if (screen == 'home') {
      subtitle = 'Home'.i18n;
    } else if (screen == 'shelves') {
      subtitle = 'Shelves'.i18n;
    } else if (screen == 'clubs') {
      subtitle = 'Clubs'.i18n;
      } else if (screen == 'discover') {
      subtitle = 'Discover'.i18n;
    // } else if (screen == 'more') {
    //   subtitle = 'More'.i18n;//.setPage(4)
    } else {
      debugPrint('Error: Invalid screen id in StartingScreenWidget'.i18n);
      subtitle = 'Unknown screen'.i18n;
    }
    return ListTile(
      title: Text('Starting screen'.i18n),
      subtitle: Text(subtitle),
      onTap: () async {
        return onStartingScreenTapped(context)
            .then((screen) {
          if (screen == null) {
            debugPrint('Info: Starting Screen not chosen'.i18n);
            return;
          }
          context.read(startingPageProvider.notifier)
              .setScreen(screen);
        })
            .onError((error, stackTrace) {
          debugPrint('Starting screen not set'.i18n);
        });
      },
    );
  }

  Future<String?> onStartingScreenTapped(
      BuildContext context) {

    final DefaultStartingPage groupProvider = context.read
      (defaultStartingPageProvider.notifier);

    final Map<int, Map<String, String>> options = {
      0: {'last_used': 'Last used'.i18n},
      1: {'home': 'Home'.i18n},
      2: {'shelves': 'Shelves'.i18n},
      3: {'clubs': 'Clubs'.i18n},
      4: {'discover': 'Discover'.i18n},
      // 5: {'more': 'More'.i18n},
    };

    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Starting screen'.i18n),
        children: [
          for (final MapEntry<int, Map<String, String>> option in options.entries)
            SimpleDialogItem(
              leading: Radio(value: option.key, groupValue: groupProvider.getDefaultPage(),
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    groupProvider.setPage(newValue);
                  }
                  Navigator.pop(context, option.value.entries.first.key);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              text: option.value.entries.first.value,
              onPressed: () {
                groupProvider.setPage(option.key);
                Navigator.pop(context, option.value.entries.first.key);
              },
            ),
        ],
      ),
    );
    
  }
}