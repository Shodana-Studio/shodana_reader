import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/data/model/book_search_model.dart';
import '../../core/res/constants.dart';
import '../widgets/custom_waterdrop_header.dart';
import '../widgets/search_bar.dart';

class HomeScreenMobile extends StatefulHookWidget {
  const HomeScreenMobile({
    Key? key,
    required this.fabOnPressed,
    required this.bookOnPressed,
  }) : super(key: key);
  final VoidCallback fabOnPressed;
  final VoidCallback bookOnPressed;

  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  // List<String> items = ['1', '2', '3', '4', '5', '6', '7', '8'];
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final BookSearchModel searchModel = useProvider(bookSearchProvider);
    return Scaffold(
      // appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: SearchBar(
        body: buildHome(context),
        hint: 'Search recents...',
        model: searchModel,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.fabOnPressed,
        tooltip: 'Add an eBook',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildHome(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        child: SmartRefresher(
          // TODO: Disable pull to refresh on desktop and web, use refresh icon instead
          // enablePullDown: !kIsWeb,
          // enablePullUp: false,
          header: const	CustomWaterDropHeader(
            offset: kToolbarHeight + 8.0,
          ),
          controller: _refreshController,
          footer: const ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: 
          // ListView.builder(
          //   itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          //   itemExtent: 100.0,
          //   itemCount: items.length,
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight + 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: kToolbarHeight + 8,),
                  // ListTile(
                  //   title: const Text('Beam to Test Book 0 Details'),
                  //   onTap: bookOnPressed,
                  // ),
                  TextButton(
                    onPressed: widget.bookOnPressed,
                    child: const Text('Beam to Test Book 0 Details'),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final box = Hive.box(AppConstant.settingsBoxKey);
                        await box.put(AppConstant.welcomeShown, false);
                      },
                      child: const Text('Go to welcome screen'),
                    ),
                  ),
                  const SizedBox(height: 1200,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
