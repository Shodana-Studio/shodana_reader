import 'dart:io' as io;
import 'dart:typed_data';

import 'package:beamer/beamer.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';

import '../../core/data/model/book_type.dart';
import '../../core/data/model/epub.dart';
import '../../core/data/service/storage_util.dart';
import 'home_screen_mobile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedItem;

  // Pick a book from storage
  Future<void> addBook() async {
    final authNotifier = context.authNotifier;
    if (authNotifier.user == null) {
      print('User is not logged in');
      return;
    }

    // TODO: User is not logged in (Run in offline mode)
    // Add book to upload queue for when logged-in/online
    // Check the local db if the book exists
    //    if it exists, display the already existing book and ask the user for confirmation before adding it
    //    else add the book to the Hive db

    // TODO: User is logged in (Upload book to server)
    // Check if book already exists on server
    //    if it exists, display the already existing book and ask the user for confirmation before uploading it
    //    else, upload the book
    // Add the book to the Hive db

    try {
      final String? fileExtension;
      final Uint8List bytes;
      final io.File fileRef;

      // Get the file from the user
      // Uses a different package on windows due to instability with FilePicker
      if (io.Platform.isWindows) {
        const String epubExtension = 'epub';
        final typeGroup = XTypeGroup(label: 'ebooks', extensions: [epubExtension]);
        final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
        fileExtension = epubExtension;
        if (file == null) {
          debugPrint('File not chosen');
          return;
        }
        bytes = await file.readAsBytes();
        fileRef = io.File(file.path);
      } else {
        final PlatformFile file = await StorageUtil.fetchFile(
          dialogTitle: 'Choose an epub file',
          type: FileType.custom,
          allowedExtensions: ['epub'],
          withData: true,
          allowCompression: false,
        );
        fileExtension = file.extension;

        if (file.bytes == null) {
          return;
        }
        bytes = file.bytes!;
        fileRef = io.File(file.path!);
      }
      
      // debugPrint('File path: ${file.path}');

      if (fileExtension == 'epub') {
        final List<int> fileBytes = bytes.toList();
        final epubx.EpubBookRef epubBook = await epubx.EpubReader.openBook(fileBytes);

        // TODO: Remove temp printing
        // debugPrint('File Uri: ${newFile.uri}');
        debugPrint('Epub title: ${epubBook.Title ?? ''}');
        debugPrint('Epub author: ${epubBook.Author ?? ''}');
        // debugPrint('File changed: ${fileStats.changed.toLocal().toString()}');

        // Create unique book ID with Uuid v4
        const uuid = Uuid();
        final String bookId = uuid.v4();
        debugPrint('Book id: $bookId');

        // TODO: Add fileId from id given by appwrite storage
        // Put data into Book object
        final userId = authNotifier.user!.id;
        final book = EPUB(
          id: bookId,
          bookType: BookType.epub,
          createdDate: DateTime.now().toUtc(),
          userId: userId,
          shelfIds: const [],
          shelfIdsLastModDate: DateTime.now().toUtc(),
          title: epubBook.Title,
          author: epubBook.Author,
        );

        // Copy file to device storage
        // ignore: unused_local_variable
        final io.File newFile = await StorageUtil.copyFile(fileRef: fileRef, folder: bookId, filename: bookId);
        debugPrint('Successfully saved the book');
        // Save image to app directory
        final int success = await book.saveCoverImage(epubBookRef: epubBook);
        switch (success) {
          case 0:
            debugPrint('Success, saved the cover image to device');
            break;
          case 1:
            debugPrint('Success, saved first image in epub contents to device');
            break;
          case -1:
            debugPrint('Failed, Could not decode image from epub');
            break;
          case -2:
            debugPrint('Failed, bookContent from epub is null');
            break;
          case -3:
            debugPrint('Failed, no images in epub');
            break;
        }

        // Add book to hive database
        /*final key = */await StorageUtil.addBook(book: book);
        if (io.Platform.isAndroid || io.Platform.isIOS) {
          final bool? success = await FilePicker.platform.clearTemporaryFiles();
        }
      }
    } on Exception catch (e, _) {
      // TODO: Add proper ui feedback on error
      debugPrint(e.toString());
    }
  }

  void bookOnPressed() {
    context.beamToNamed('/home/0');
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return const MoreSettingsScreen();
    //   }
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => HomeScreenMobile(
        addBookAction: addBook,
        bookOnPressed: bookOnPressed,
      ),
      tablet: (BuildContext context) => HomeScreenMobile(
        addBookAction: addBook,
        bookOnPressed: bookOnPressed,
      ),
      desktop: (BuildContext context) => HomeScreenMobile(
        addBookAction: addBook,
        bookOnPressed: bookOnPressed,
      ),
      watch: (BuildContext context) => HomeScreenMobile(
        addBookAction: addBook,
        bookOnPressed: bookOnPressed,
      ),
    );
  }
}