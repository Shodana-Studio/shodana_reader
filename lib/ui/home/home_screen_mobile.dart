import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../core/data/model/book.dart';
import '../../core/data/model/book_search_model.dart';
import '../../core/data/service/storage_util.dart';
import '../../l10n/my.i18n.dart';
import '../widgets/custom_waterdrop_header.dart';
import '../widgets/grid_tile_widget.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/search_bar.dart';

class HomeScreenMobile extends StatefulHookWidget {
  const HomeScreenMobile({
    Key? key,
    required this.addBookAction,
    required this.bookOnPressed,
  }) : super(key: key);
  final VoidCallback addBookAction;
  final VoidCallback bookOnPressed;

  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  final RefreshController _refreshController = RefreshController();
  late List<Book> books;
  late Box booksBox;

  Future<void> _onRefresh() async {
    books = StorageUtil.getAllBooks();
    print(books);
    // temp delay
    await Future.delayed(const Duration(milliseconds: 1000));
    // TODO: Get latest books from server database and update hive box
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
  void initState() {
    super.initState();
    
    books = StorageUtil.getAllBooks();
    booksBox =  StorageUtil.getBooksBox();
    print(books);
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: widget.fabOnPressed,
      //   tooltip: 'Add an eBook'.i18n,
      //   child: const Icon(Icons.add),
      // ),
    ) ;
  }

  Widget buildHome(ScrollController scrollController) {
    return SafeArea(
      child: Scrollbar(
        child: ValueListenableBuilder(
          valueListenable: booksBox.listenable(),
          builder: (context, Box box, _) {
            books = box.values.map((e) => e as Book).toList();
            return SmartRefresher(
              // TODO: Disable pull to refresh on desktop and web, use refresh icon instead
              // enablePullDown: !kIsWeb,
              // enablePullUp: true,
              header: const	CustomWaterDropHeader(
                offset: kToolbarHeight + 8.0,
              ),
              controller: _refreshController,
              scrollController: scrollController,
              // footer: const ClassicFooter(),
              // footer: CustomFooter(
              //   builder: (BuildContext context, LoadStatus? mode) {
              //     Widget body;
              //     if (mode == LoadStatus.idle) {
              //       body = const Text('Pull up to load more');
              //     }
              //     else if (mode == LoadStatus.loading) {
              //       body = const CircularProgressIndicator();
              //     }
              //     else if (mode == LoadStatus.failed) {
              //       body = const Text('Load Failed! Try again!');
              //     }
              //     else if (mode == LoadStatus.canLoading) {
              //       body = const Text('Release to load more');
              //     }
              //     else {
              //       body = const Text('No more Data');
              //     }
              //     return const SizedBox(
              //       height: 55.0,
              //       // child: Center(child: body),
              //     );
              //   },
              // ),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              // TODO: Get list of books from hive 'books' box
              child: _ReorderableGridWidget(widget: widget, books: books, scrollController: scrollController),

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
            );
          }
        ),
      ),
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    Key? key,
    required this.widget,
    required this.books,
    required this.scrollController,
  }) : super(key: key);

  final HomeScreenMobile widget;
  final List<Book> books;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: kToolbarHeight + 8.0,
        bottom: 8.0,
        left: 4.0,
        right: 4.0,
      ),
      controller: scrollController,
      itemBuilder: (context, index) {
        // Add a book button at the top of the listview
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: OutlinedButton(
              onPressed: widget.addBookAction,
              child: const Text('Add a book'),
            ),
          );
        }

        // List tile
        final book = books[index - 1];
        return FutureBuilder(
          future: book.bookDirectoryPath,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final io.Directory bookDir = snapshot.data! as io.Directory;
              final io.Directory imageDir = io.Directory('${bookDir.path}/cover.png');
              return ListTileWidget(
                key: ValueKey(index - 1),
                title: book.title,
                subtitle: book.author,
                context: context,
                image: imageDir.path,
              );
            }
            
            return const CircularProgressIndicator();
          }
        );
      },
      // itemExtent: 120.0,
      itemCount: books.length + 1,
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget({
    Key? key,
    required this.widget,
    required this.books,
    required this.scrollController,
  }) : super(key: key);

  final HomeScreenMobile widget;
  final List<Book> books;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = getValueForScreenType<int>(
      context: context,
      mobile: 3,
      tablet: 6,
      desktop: 12,
    );
    return StaggeredGridView.countBuilder(
      crossAxisCount: crossAxisCount,
      itemCount: books.length + 1,
      controller: scrollController,
      padding: const EdgeInsets.only(
        top: kToolbarHeight + 8.0,
        bottom: 8.0,
        left: 4.0,
        right: 4.0,
      ),
      staggeredTileBuilder: (index) {
        if (index == 0) {
          return StaggeredTile.fit(crossAxisCount);
        }
        return const StaggeredTile.fit(1);
      },
      itemBuilder: _buildGridItem,
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    // Add a book button at the top of the listview
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: OutlinedButton(
          onPressed: widget.addBookAction,
          child: const Text('Add a book'),
        ),
      );
    }

    // Grid tile
    final book = books[index - 1];
    return FutureBuilder(
      future: book.bookDirectoryPath,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final io.Directory bookDir = snapshot.data! as io.Directory;
          final io.Directory imageDir = io.Directory('${bookDir.path}/cover.png');
          return GridTileWidget(
            title: book.title,
            subtitle: book.author,
            context: context,
            image: imageDir.path,
          );
        }
        
        return const CircularProgressIndicator();
      }
    );
  }
}

class _ReorderableGridWidget extends StatelessWidget {
  const _ReorderableGridWidget({
    Key? key,
    required this.widget,
    required this.books,
    required this.scrollController,
  }) : super(key: key);

  final HomeScreenMobile widget;
  final List<Book> books;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = getValueForScreenType<int>(
      context: context,
      mobile: 3,
      tablet: 6,
      desktop: 12,
    );
    final bookWidgets = [
      for (var i = 0; i < books.length + 1; i++)
        _buildGridItem(context, i)
    ];
    
    return ReorderableGridView(
      crossAxisCount: crossAxisCount,
      padding: const EdgeInsets.only(
        top: kToolbarHeight + 8.0,
        bottom: 8.0,
        left: 4.0,
        right: 4.0,
      ),
      onReorder: (int oldIndex, int newIndex) {  },
      children: bookWidgets,
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    // Add a book button at the top of the listview
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: OutlinedButton(
          onPressed: widget.addBookAction,
          child: const Text('Add a book'),
        ),
      );
    }

    // Grid tile
    final book = books[index - 1];
    return FutureBuilder(
      future: book.bookDirectoryPath,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        final io.Directory bookDir = snapshot.data! as io.Directory;
        final io.Directory imageDir = io.Directory('${bookDir.path}/cover.png');
          return GridTileWidget(
            index: index - 1,
            key: ValueKey(index - 1),
            title: book.title,
            subtitle: book.author,
            context: context,
            image: imageDir.path,
          );
        }
        
        return const CircularProgressIndicator();
      }
    );
  }
}