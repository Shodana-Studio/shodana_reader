import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shodana_reader/ui/widgets/list_tile_widget.dart';

import '../../core/data/model/book_search_model.dart';
import '../../l10n/my.i18n.dart';
import '../widgets/custom_waterdrop_header.dart';
import '../widgets/search_bar.dart';
import '../widgets/staggered_grid.dart';

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
    final scrollController = useScrollController();
    return Scaffold(
      // appBar: AppBar(title: Text('appName'.i18n)),
      body: SearchBar(
        body: buildHome(scrollController),
        hint: 'Search recents...'.i18n,
        model: searchModel,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.fabOnPressed,
        tooltip: 'Add an eBook'.i18n,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildHome(ScrollController scrollController) {
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
          scrollController: scrollController,
          footer: const ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          // TODO: Get list of books from hive 'books' box
          child: ListView.builder(
            padding: const EdgeInsets.only(top: kToolbarHeight + 8.0, left: 8.0, right: 8.0),
            controller: scrollController,
            itemBuilder: (context, index) {
              return ListTileWidget(index: index, title: 'Text', subtitle: 'Subtitle', context: context,);
            },
            // itemExtent: 120.0,
            itemCount: 100,
          ),

          // TODO: Add support for staggered grid view and normal grid view
          // StaggeredGrid(controller: scrollController,),
          
          // SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: kToolbarHeight + 8.0),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         // const SizedBox(height: kToolbarHeight + 8,),
          //         // ListTile(
          //         //   title: const Text('Beam to Test Book 0 Details'),
          //         //   onTap: bookOnPressed,
          //         // ),
          //         Align(
          //           alignment: Alignment.centerLeft,
          //           child: TextButton(
          //             onPressed: widget.bookOnPressed,
          //             child: const Text('Beam to Test Book 0 Details'),
          //           ),
          //         ),
                  
          //         // Tile(title: 'Average Abilities', subtitle: 'FUNA'),
          //         const SizedBox(height: 1200,),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}