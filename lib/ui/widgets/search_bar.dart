import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../core/data/model/book.dart';
import '../../core/data/model/book_search_model.dart';
import '../../core/data/repository/fake_data.dart';
import '../../core/data/service/appwrite_service.dart';
import '../../core/res/constants.dart';
import '../../l10n/my.i18n.dart';
import '../more/more_about/more_about_screen.dart';
import '../more/more_settings/more_settings_screen.dart' show MoreSettingsScreen;

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
    required this.body,
    required this.model,
    this.hint='Search...',
    required this.rootContext,
  }) : super(key: key);

  final Widget body;
  final String? hint;
  final BookSearchModel model;
  final BuildContext rootContext;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchBar> {
  final controller = FloatingSearchBarController();

  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? controller.hide() : controller.show();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: buildFloatingSearchBar(context, controller),
    );
  }

  List<PopupMenuEntry> buildProfileMenuItems(BuildContext context) => [
    PopupMenuItem(
      padding: EdgeInsets.zero,
      child: FutureBuilder(
        future: context.authNotifier.account.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircleAvatar(
                    radius: 20.0,
                    child: Icon(Icons.no_accounts_outlined),
                  ),
                ],
              ),
              title: Text('Log in or Sign up'.i18n),
              onTap: () {
                // TODO: Navigate to login screen
              },
            );
          }

          else if (snapshot.hasData) {
            final User user = User.fromMap((snapshot.data! as Response<dynamic>).data);
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (snapshot.hasError)
                    const CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.no_accounts_outlined),
                    ),
                  if (snapshot.hasData)
                    CircleAvatar(
                      radius: 20.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90.0),
                        child: buildProfileImage(user.name),
                      ),
                    ),
                ],
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              onTap: () {
                // TODO: Navigate to account screen
                // TODO: Move logout into account screen
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: buildLogOutAlertDialog,
                );
              },
            );
          }

          else {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (snapshot.hasError)
                    const CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.no_accounts_outlined),
                    ),
                  if (snapshot.hasData)
                    CircleAvatar(
                      radius: 20.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90.0),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
              title: const Text(''),
              subtitle: const Text(''),
              // onTap: () {
                // TODO: Navigate to account screen
              // },
            );
          }
        }
      ),
    ),
    // Divider
    const PopupMenuDivider(),
    // Incognito Mode
    PopupMenuItem(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        minLeadingWidth: 0.0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(CommunityMaterialIcons.incognito),
          ],
        ),
        title: Text('Turn on Incognito mode'.i18n),
        onTap: () {
          Navigator.of(context).pop();
        },
        // subtitle: const Text('Pauses reading history'.i18n),
      ),
    ),
    // Settings
    PopupMenuItem(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        minLeadingWidth: 0.0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.settings_outlined),
          ],
        ),
        title: Text('Settings'.i18n),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(widget.rootContext).push(MaterialPageRoute(
              builder: (context) {
                return const MoreSettingsScreen();
              })
          );
        },
      ),
    ),
    // About
    PopupMenuItem(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        minLeadingWidth: 0.0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.info_outline),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('About'.i18n, style: Theme.of(context).textTheme
                .bodyText1,),
            Text('v0.0.2', style: Theme.of(context).textTheme
                .subtitle2,),
          ],
        ),
        // subtitle: const Text('v0.0.2'),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(widget.rootContext).push(MaterialPageRoute(
              builder: (context) {
                return const AboutScreen();
              })
          );
        },
      ),
    ),
    // Help
    PopupMenuItem(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        minLeadingWidth: 0.0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.help_outline),
          ],
        ),
        title: Text('Help'.i18n),
        onTap: () => Navigator.of(context).pop(),
      ),
    ),
    // Go to welcome screen
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: ElevatedButton(
    //     onPressed: () async {
    //       final box = Hive.box(AppConstant.settingsBoxKey);
    //       await box.put(AppConstant.welcomeShown, false);
    //     },
    //     child: Text('Go to welcome screen'.i18n),
    //   ),
    // ),
    PopupMenuItem(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        minLeadingWidth: 0.0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(CommunityMaterialIcons.ab_testing),
          ],
        ),
        title: Text('Go to welcome screen'.i18n),
        onTap: () async {
          Navigator.of(context).pop();
          final box = Hive.box(AppConstant.settingsBoxKey);
          await box.put(AppConstant.welcomeShown, false);
        },
        // subtitle: const Text('Pauses reading history'.i18n),
      ),
    ),
  ];

  
  Widget buildFloatingSearchBar(BuildContext context, FloatingSearchBarController controller) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final actions = [
      // Profile button
      FloatingSearchBarAction(
        child: PopupMenuButton(
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          offset: const Offset(0.0, kToolbarHeight),
          icon: CircleAvatar(
            radius: 16.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90.0),
              child: FutureBuilder(
                future: context.authNotifier.account.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const CircleAvatar(
                      radius: 20.0,
                      child: Icon(Icons.no_accounts_outlined),
                    );
                  }

                  else if (snapshot.hasData) {
                    final User user = User.fromMap((snapshot.data! as Response<dynamic>).data);
                    return buildProfileImage(user.name);
                  }
                  
                  else {
                    return Container(color: Theme.of(context).backgroundColor, child: const Icon(Icons.account_circle),);
                  }
                }
              ),
            ),
          ),
          itemBuilder: buildProfileMenuItems,
        ),
      ),
      // Clear button
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final leadingActions = [
      // Search icon
      FloatingSearchBarAction(
        builder: (context, animation) {
          final bar = FloatingSearchAppBar.of(context)!;

          return ValueListenableBuilder<String>(
            valueListenable: bar.queryNotifer,
            builder: (context, query, _) {
              final isEmpty = query.isEmpty;

              return SearchToClear(
                isEmpty: isEmpty,
                color: Theme.of(context).iconTheme.color,
                duration: const Duration(milliseconds: 900) * 0.5,
                onTap: () {
                  if (!isEmpty) {
                    bar.clear();
                  } else {
                    bar.isOpen =
                        !bar.isOpen || (!bar.hasFocus && bar.isAlwaysOpened);
                  }
                },
              );
            },
          );
        },
      ),
      // Back button
      FloatingSearchBarAction.back(
        color: Theme.of(context).iconTheme.color,
      ),
    ];

    return FloatingSearchBar(
      hint: widget.hint,
      // isScrollControlled: true,
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      automaticallyImplyBackButton: false,
      // scrollPadding: const EdgeInsets.only(/*top: 0, */bottom: 80),
      // padding: const EdgeInsets.symmetric(horizontal: 0),
      // backdropColor: Colors.transparent,
      margins: EdgeInsets.only(top: MediaQuery.of(context)
          .viewPadding.top.toDouble() + 8.0, bottom: 8.0, left: 16.0, right: 16),
      borderRadius: BorderRadius.circular(8.0),
      controller: controller,
      // clearQueryOnClose: true,
      iconColor: Colors.grey,
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOutCubic,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      // width: isPortrait ? 600 : 500,
      leadingActions: leadingActions,
      actions: actions,
      progress: widget.model.isLoading,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: widget.model.onQueryChanged,
      scrollPadding: EdgeInsets.zero,
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(spacing: 16.0),
      // transition: ExpandingFloatingSearchBarTransition(),
      builder: (context, _) => buildExpandableBody(context, widget.model),
      body: FloatingSearchBarScrollNotifier(child: widget.body),
    );
  }

  Widget buildExpandableBody(BuildContext context, BookSearchModel model) {
    return Material(
      color: Theme.of(context).bottomAppBarTheme.color,
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: ImplicitlyAnimatedList<Book>(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        items: model.suggestions.take(6).toList(),
        areItemsTheSame: (a, b) => a == b,
        itemBuilder: (context, animation, book, i) {
          return SizeFadeTransition(
            animation: animation,
            child: SearchItem(book: book),
          );
        },
        updateItemBuilder: (context, animation, book) {
          return FadeTransition(
            opacity: animation,
            child: SearchItem(book: book),
          );
        },
      ),
    );
  }

  Widget buildLogOutAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Log out'.i18n),
      content: Text("Are you sure? You won't be able to access any online content without being logged in.".i18n),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: Theme.of(context).textButtonTheme.style,
          child: Text('CANCEL'.i18n),
        ),
        TextButton(
          onPressed: () {
            context.authNotifier.deleteSession();
            Navigator.of(context).pop();
          },
          style: Theme.of(context).textButtonTheme.style,
          child: Text('LOGOUT'.i18n),
        ),
      ],
    );
  }

  Widget buildProfileImage(String name) {
    return CachedNetworkImage(
      imageUrl: AppwriteService.instance.getInitialsLink(name),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

class SearchItem extends HookWidget {
  const SearchItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final model = useProvider(bookSearchProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (!history.contains(book)) {
              history.add(book);
            }
            FloatingSearchBar.of(context)?.close();
            Future.delayed(
              const Duration(milliseconds: 500),
              // model.clear,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: model.suggestions == history
                        ? const Icon(Icons.history, key: Key('history'))
                        : const Icon(Icons.book, key: Key('book')),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title ?? 'No title'.i18n,
                        style: textTheme.subtitle1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        book.author ?? 'No author'.i18n,
                        style: textTheme.bodyText2?.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (model.suggestions.isNotEmpty && book != model.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }
}