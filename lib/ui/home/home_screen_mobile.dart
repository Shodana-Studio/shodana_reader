import 'dart:io' as io;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/data/book.dart';
import '../../core/model/book_search_model.dart';
import '../../core/service/storage_util.dart';
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

  // Test downloading file to a location
  // Future<io.File> _downloadFile() async {
  //   final Uint8List data = await AppwriteService.instance.getFileDownload('612e5e93b5068');
  //   final io.Directory dir = await StorageUtil.getAppDirectory();
  //   // print(dir.path);
  //   final io.File file = await io.File('${dir.path}/download1.epub').writeAsBytes(data.toList());
  //   return file;
  // }

  Future<void> _onRefresh() async {
    books = StorageUtil.getAllBooks();
    debugPrint(books.toString());
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
    debugPrint(books.toString());
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
      //   onPressed: _downloadFile,
      //   tooltip: 'Download'.i18n,
      //   child: const Icon(Icons.download),
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
              // child: _GridWidget(widget: widget, books: books, scrollController: scrollController),
              child: _ReorderableListWidget(widget: widget, books: books, scrollController: scrollController),

              // TODO: Add support for staggered grid view and normal grid view
            );
          }
        ),
      ),
    );
  }
}
class _ReorderableListWidget extends StatefulWidget {
  const _ReorderableListWidget({
    Key? key,
    required this.widget,
    required this.books,
    required this.scrollController,
  }) : super(key: key);

  final HomeScreenMobile widget;
  final List<Book> books;
  final ScrollController scrollController;

  @override
  _ReorderableListWidgetState createState() => _ReorderableListWidgetState();
}

class _ReorderableListWidgetState extends State<_ReorderableListWidget> {
  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedReorderableList<Book>(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 4.0,
        right: 4.0,
      ),
      items: widget.books,
      areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
      onReorderFinished: (item, from, to, newItems) {
        // Remember to update the underlying data when the list has been
        // reordered.
        // TODO: Change order of data in hive box
        setState(() {
          widget.books
            ..clear()
            ..addAll(newItems);
        });
      },
      itemBuilder: (context, itemAnimation, item, index) {
        // Each item must be wrapped in a Reorderable widget.
        return Reorderable(
          // Each item must have an unique key.
          key: ValueKey(item),
          // The animation of the Reorderable builder can be used to
          // change to appearance of the item between dragged and normal
          // state. For example to add elevation when the item is being dragged.
          // This is not to be confused with the animation of the itemBuilder.
          // Implicit animations (like AnimatedContainer) are sadly not yet supported.
          builder: (context, dragAnimation, inDrag) {
            final t = dragAnimation.value;
            final elevation = lerpDouble(0, 8, t);
            final color = Color.lerp(Colors.white, Colors.white.withOpacity(0.8), t);

            return SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: itemAnimation,
              child: Material(
                color: color,
                elevation: elevation ?? 0,
                type: MaterialType.transparency,
                child: _BookReorderableListTile(book: item),
              ),
            );
          },
        );
      },
      // Since version 0.2.0 you can also display a widget
      // before the reorderable items...
      header: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: kToolbarHeight + 8.0, bottom: 4.0),
        child: OutlinedButton(
          onPressed: widget.widget.addBookAction,
          child: const Text('Add a book'),
        ),
      ),
      // If you want to use headers or footers, you should set shrinkWrap to true
      shrinkWrap: true,
    );
  }
}

class _BookReorderableListTile extends StatelessWidget {
  const _BookReorderableListTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: book.bookDirectoryPath,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final io.Directory bookDir = snapshot.data! as io.Directory;
          final io.Directory imageDir = io.Directory('${bookDir.path}/cover.png');
          return ListTileWidget(
            title: book.title,
            subtitle: book.author,
            image: imageDir.path,
            trailing: const Handle(
              delay: Duration(milliseconds: 50),
              // TODO: Get icon color from context theme
              child: Icon(
                Icons.list,
                color: Colors.grey,
              ),
            ),
          );
        }
        
        return const CircularProgressIndicator();
      }
    );
  }
}

// ignore: unused_element
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