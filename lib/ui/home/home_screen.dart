import 'dart:io' as io;

import 'package:beamer/beamer.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:file_picker/file_picker.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/data/model/book.dart';
import 'home_screen_mobile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.rootContext}) : super(key: key);
  final BuildContext rootContext;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedItem;

  Future<void> fabOnPressed() async {
    try {
      final PlatformFile file = await fetchFile();
      final io.File newFile = await copyFile(file);
      if (file.extension == 'epub') {
        final List<int> bytes = await newFile.readAsBytes();
        final epubx.EpubBookRef epub = await epubx.EpubReader.openBook(bytes);

        print(newFile.path);
        print(newFile.uri);
        print(epub.Title);
        print(epub.Author);
      }
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
    } on Exception catch (e, _) {
      print(e);
    }
  }

  Future<void> fabOnPressedHiveDb() async {
    final authNotifier = context.authNotifier;
    if (authNotifier.user == null) {
      return;
    }

    try {
      final PlatformFile file = await fetchFile();
      final io.File newFile = await copyFile(file);
      if (file.extension == 'epub') {
        final List<int> bytes = await newFile.readAsBytes();
        final fileStats = newFile.statSync();
        final epubx.EpubBookRef epubRef = await epubx.EpubReader.openBook(bytes);

        // TODO: Remove temp printing
        debugPrint('File path: ${newFile.path}');
        debugPrint('File Uri: ${newFile.uri}');
        debugPrint('Epub title: ${epubRef.Title ?? ''}');
        debugPrint('Epub author: ${epubRef.Author ?? ''}');
        debugPrint('File changed: ${fileStats.changed.toLocal().toString()}');
        // Add to Hive database
        final userId = authNotifier.user!.id;
        // TODO: Change fileId to id given by appwrite storage
        final String fileId = 'ext-${file.extension!}-size-${file.size}';
        debugPrint('File id: ${fileId}');
        final book = Book(
          bookType: BookType.epub,
          fileId: fileId,
          createdDate: DateTime.now(),
          userId: userId,
        );

        // TODO: Add book to hive database


      }
    } on Exception catch (e, _) {
      // TODO: Add proper ui feedback on error
      debugPrint(e.toString());
    }
  }

  void bookOnPressed() {
    context.beamToNamed('/home/0');
    // Navigator.of(widget.rootContext).push(MaterialPageRoute(
    //   builder: (context) {
    //     return const MoreSettingsScreen();
    //   }
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => HomeScreenMobile(
        fabOnPressed: fabOnPressedHiveDb,
        bookOnPressed: bookOnPressed,
        rootContext: widget.rootContext,
      ),
      tablet: (BuildContext context) => HomeScreenMobile(
        fabOnPressed: fabOnPressedHiveDb,
        bookOnPressed: bookOnPressed,
        rootContext: widget.rootContext,
      ),
      desktop: (BuildContext context) => HomeScreenMobile(
        fabOnPressed: fabOnPressedHiveDb,
        bookOnPressed: bookOnPressed,
        rootContext: widget.rootContext,
      ),
      watch: (BuildContext context) => HomeScreenMobile(
        fabOnPressed: fabOnPressedHiveDb,
        bookOnPressed: bookOnPressed,
        rootContext: widget.rootContext,
      ),
    );
  }

  Future<PlatformFile> fetchFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
    );

    if(result != null) {
      final PlatformFile file = result.files.first;

      return file;
    } else {
      // User canceled the picker
      throw Exception('Failed to load epub');
    }
  }

  // TODO: Add support for desktop
  Future<io.File> copyFile(PlatformFile file) async {
    // Save files in directory accessible to the user on android
    io.Directory dir;
    if (io.Platform.isAndroid) {
      dir = (await getExternalStorageDirectory())!;
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    final io.File cachedFile = io.File(file.path ?? '');
    final io.File newFile = await cachedFile.copy('${dir
        .path}/${file.name}');

    return newFile;
  }
}