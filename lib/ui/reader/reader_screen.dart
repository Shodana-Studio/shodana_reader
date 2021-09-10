import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_constants.dart';
import '../app_screen/provider/bottom_navigation_provider.dart';
import 'ebook_reader/ebook_reader_screen.dart';
import 'html_reader/html_reader_screen.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({
    Key? key,
    required this.book,
    required this.chapter,
    required this.bookFileType,
  }) : super(key: key);
  final BookFileType bookFileType;
  final Map<String, String> book;
  final List<String> chapter;

  @override
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () async {
        ref.read(shouldShowBottomNavigationProvider).state = true;
        await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        return true;
      },
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowUp) : const IncrementIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown) : const DecrementIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            // TODO: Change these to control page scrolling
            IncrementIntent: CallbackAction<IncrementIntent>(
                onInvoke: (IncrementIntent intent) => setState(() {
                  count = count + 1;
                  debugPrint(count.toString());
                })
            ),
            DecrementIntent: CallbackAction<DecrementIntent>(
                onInvoke: (DecrementIntent intent) => setState(() {
                  count = count - 1;
                  debugPrint(count.toString());
                })
            ),
          },
          child: Focus(
            autofocus: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: widget.bookFileType == BookFileType.epub ?
              EBookReaderScreen(
                  book: widget.book,
                  chapter: widget.chapter
              ) :
              HTMLReaderScreen(
                book: widget.book,
                chapter: widget.chapter,
              ),
            ),
          ),
        ),
      )
    );
  }
}

class IncrementIntent extends Intent {
  const IncrementIntent();
}

class DecrementIntent extends Intent {
  const DecrementIntent();
}