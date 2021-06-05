import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/tr.dart';
import '../../app_screen/provider/starting_screen_button_choice.dart';
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
      subtitle = TR.of(context)!.startingScreenOptionLastUsedText;
    } else if (screen == 'home') {
      subtitle = TR.of(context)!.startingScreenOptionHomeText;
    } else if (screen == 'shelves') {
      subtitle = TR.of(context)!.startingScreenOptionShelvesText;
    } else if (screen == 'clubs') {
      subtitle = TR.of(context)!.startingScreenOptionClubsText;
      } else if (screen == 'discover') {
      subtitle = TR.of(context)!.startingScreenOptionDiscoverText;
    // } else if (screen == 'more') {
    //   subtitle = TR.of(context)!.startingScreenOptionMoreText;//.setPage(4)
    } else {
      debugPrint('Error: Invalid screen id in StartingScreenWidget');
      subtitle = 'Unknown screen';
    }
    return ListTile(
      title: const Text('Starting screen'),
      subtitle: Text(subtitle),
      onTap: () async {
        return onStartingScreenTapped(context)
            .then((screen) {
          if (screen == null) {
            debugPrint('Info: Starting Screen not chosen');
            return;
          }
          context.read(startingPageProvider.notifier)
              .setScreen(screen);
        })
            .onError((error, stackTrace) {
          debugPrint('Starting screen not set');
        });
      },
    );
  }

  Future<String?> onStartingScreenTapped(
      BuildContext context) {

    final StartingScreenButtonChoice groupProvider = context.read
      (startingScreenButtonChoiceProvider.notifier);

    final Map<int, Map<String, String>> options = {
      0: {'last_used': TR.of(context)!
          .startingScreenOptionLastUsedText},
      1: {'home': TR.of(context)!.startingScreenOptionHomeText},
      2: {'shelves': TR.of(context)!
          .startingScreenOptionShelvesText},
      3: {'clubs': TR.of(context)!.startingScreenOptionClubsText},
      4: {'discover': TR.of(context)!
          .startingScreenOptionDiscoverText},
      // 5: {'more': TR.of(context)!.startingScreenOptionMoreText},
    };

    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Starting screen'),
        children: [
          for (final MapEntry<int, Map<String, String>> option in options.entries)
            SimpleDialogItem(
              leading: Radio(value: option.key, groupValue: groupProvider.getChoice(),
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