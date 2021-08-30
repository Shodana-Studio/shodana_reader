import 'dart:io' as io;
import 'dart:typed_data';

import 'package:beamer/beamer.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';

import '../../core/model/book_type.dart';
import '../../core/model/epub.dart';
import '../../core/service/storage_util.dart';
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
      debugPrint('User is not logged in');
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
        // Read in the file as a stream to not lock up the ui
        final stream = http.ByteStream(file.openRead());
        bytes = await stream.toBytes();
      } else {
        const bool readAsStream = true;
        final List<PlatformFile> files = await StorageUtil.fetchFile(
          dialogTitle: 'Choose an epub file',
          type: FileType.custom,
          allowedExtensions: ['epub'],
          // Must be false when withReadStream is true
          // withData: !readAsStream,
          allowCompression: false,
          withReadStream: readAsStream
        );
        final PlatformFile file = files.first;

        fileExtension = file.extension;

       // Read in the file as a stream to not lock up the ui
        final stream = http.ByteStream(file.readStream!);
        bytes = await stream.toBytes();
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
        final String localStorageId = uuid.v4();
        debugPrint('Local Storage Id: $localStorageId');

        // TODO: Add fileId from id given by appwrite storage
        // Put data into Book object
        final userId = authNotifier.user!.id;
        final book = EPUB(
          bookType: BookType.epub,
          createdDate: DateTime.now().toUtc(),
          userId: userId,
          localStorageId: localStorageId,
          shelfIds: const [],
          shelfIdsLastModDate: DateTime.now().toUtc(),
          title: epubBook.Title,
          author: epubBook.Author,
        );

        // Copy file to device storage
        // ignore: unused_local_variable
        final io.File newFile = await StorageUtil.copyFile(bytes: bytes, folder: localStorageId, filename: localStorageId);
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

        // Clear the cached file (Android/iOS)
        if (io.Platform.isAndroid || io.Platform.isIOS) {
          // clearTemporaryFiles is only available on iOS and Android.
          // This is run to keep the storage used to a minimum. This is not required,
          // as the platform will clear the cache if it needs more space.
          // I clear it anyway because there is no point to uploading the same book twice.

          // success should not be null since this is only run on android and ios platforms
          /*final bool? success = */await FilePicker.platform.clearTemporaryFiles();
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