import 'dart:io' as io;

import 'package:beamer/beamer.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:file_picker/file_picker.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;

import '../../core/data/model/book.dart';
import '../../core/data/model/book_type.dart';
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
      final PlatformFile file = await fetchFile();
      if (file.extension == 'epub') {
        final List<int> fileBytes = file.bytes!.toList();
        final epubx.EpubBook epubBook = await epubx.EpubReader.readBook(fileBytes);

        // TODO: Remove temp printing
        // debugPrint('File path: ${newFile.path}');
        // debugPrint('File Uri: ${newFile.uri}');
        debugPrint('Epub title: ${epubBook.Title ?? ''}');
        debugPrint('Epub author: ${epubBook.Author ?? ''}');
        // debugPrint('File changed: ${fileStats.changed.toLocal().toString()}');

        // Add to Hive database
        // TODO: Add fileId from id given by appwrite storage

        // Create unique book ID with Uuid v4
        const uuid = Uuid();
        final String bookId = uuid.v4();
        debugPrint('Book id: $bookId');

        // Put data into Book object
        final userId = authNotifier.user!.id;
        final book = Book(
          bookId: bookId,
          bookType: BookType.epub,
          createdDate: DateTime.now(),
          userId: userId,
          shelfIds: const [],
          shelfIdsLastModDate: DateTime.now(),
          title: epubBook.Title,
          author: epubBook.Author,
        );

        // Copy file to device storage
        final io.File newFile = await copyPlatformFile(file: file, folder: bookId, filename: bookId);
        
        // Save image to app directory
        final img.Image? cover = epubBook.CoverImage;
        final io.Directory dir = await StorageUtil.getAppDirectory();
        if (cover != null) {
          final io.File coverImage = await io.File('${dir.path}/$bookId/cover.png').writeAsBytes(img.encodePng(cover));
          debugPrint(coverImage.path);
        } else {
          // If the cover image is null, use the first image
          debugPrint('No cover image was found, using the first image in the book instead...');

          // Book's content (HTML files, stylesheets, images, fonts, etc.)
          final epubx.EpubContent bookContent = epubBook.Content!;

          // All images in the book (file name is the key)
          final Map<String?, epubx.EpubByteContentFile> images = bookContent.Images!;
          final epubx.EpubByteContentFile firstImage = images.values.first;

          // Get the first image content
          final List<int>? imageContent = firstImage.Content;
          if (imageContent != null) {
            // Convert the image content into an img.Image object
            final img.Image? cover = img.decodeImage(imageContent);
            if (cover != null) {
              // Convert the image to png, copy the file to the book's folder with the name 'cover.png'
              final io.File coverImage = await io.File('${dir.path}/$bookId/cover.png').writeAsBytes(img.encodePng(cover));
              debugPrint('Image cover saved to: ${coverImage.path}');
            } else {
              debugPrint('Could not decode image from epub');
            }
          } else {
            debugPrint('imageContent of image from epub is null');
          }
        }

        // TODO: Add book to hive database
        final key = await StorageUtil.addBook(book: book);
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
        fabOnPressed: addBook,
        bookOnPressed: bookOnPressed,
      ),
      tablet: (BuildContext context) => HomeScreenMobile(
        fabOnPressed: addBook,
        bookOnPressed: bookOnPressed,
      ),
      desktop: (BuildContext context) => HomeScreenMobile(
        fabOnPressed: addBook,
        bookOnPressed: bookOnPressed,
      ),
      watch: (BuildContext context) => HomeScreenMobile(
        fabOnPressed: addBook,
        bookOnPressed: bookOnPressed,
      ),
    );
  }

  Future<PlatformFile> fetchFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
      withData: true
    );

    if(result != null) {
      final PlatformFile file = result.files.first;

      return file;
    } else {
      // User canceled the picker
      throw Exception('Failed to load epub');
    }
  }

  Future<io.File> copyPlatformFile({required PlatformFile file, required String folder, required String filename}) async {
    // Save files in directory accessible to the user on android
    final io.Directory dir = await StorageUtil.getAppDirectory();

    // Get the reference to the file
    final io.File fileRef = io.File(file.path!);
    // Create the folder
    await io.Directory('${dir.path}/$folder').create();
    // Copy the file to the app directory
    final io.File newFile = await fileRef.copy('${dir
        .path}/$folder/$filename');
    return newFile;
  }
}