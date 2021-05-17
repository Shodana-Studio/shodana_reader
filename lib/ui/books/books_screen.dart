import 'dart:io' as io;
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:path_provider/path_provider.dart';

import 'package:beamer/beamer.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shodana_reader/data/repository/fake_data.dart';

import 'book_details_screen.dart';


class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  int? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: const BooksBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: fabOnPressed,
        tooltip: 'Add an eBook',
        child: const Icon(Icons.add),
      ),
    );

    //   MasterDetailLayout(
    //   master: Scaffold(
    //     appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
    //     body: const BooksBody(),
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: fabOnPressed,
    //       tooltip: 'Add an eBook',
    //       child: const Icon(Icons.add),
    //     ),
    //   ),
    //   detail: BookDetailsScreen(book: book,),
    //   isSelected: selectedItem != null,
    // );
  }

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

class BooksBody extends StatelessWidget {
  const BooksBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              return context.beamToNamed('/books/0}');
            },
            child: const Text('Beam to Test Book 0 Details'),
          ),
        ],
      ),
    );
  }
}