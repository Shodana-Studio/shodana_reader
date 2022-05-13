// ignore_for_file: implementation_imports
import 'dart:io' as io;

import 'package:epubx/epubx.dart' as epubx;
import 'package:epubx/src/ref_entities/epub_byte_content_file_ref.dart' as epubx;
import 'package:epubx/src/ref_entities/epub_content_ref.dart' as epubx;
import 'package:image/image.dart' as img;

import 'book.dart';

class EPUB extends Book {
  const EPUB({
    id,
    userId,
    fileId,
    localStorageId,
    bookType,
    title,
    author,
    description,
    readingProgress,
    publisher,
    publishedDate,
    createdDate,
    required lastModifiedDate,
    startReadingDate,
    finishReadingDate,
    metadata,
    shelfIds,
  }) : super(
    id: id,
    userId: userId,
    fileId: fileId,
    localStorageId: localStorageId,
    bookType: bookType,
    title: title,
    author: author,
    description: description,
    readingProgress: readingProgress,
    publisher: publisher,
    publishedDate: publishedDate,
    createdDate: createdDate,
    lastModifiedDate: lastModifiedDate,
    startReadingDate: startReadingDate,
    finishReadingDate: finishReadingDate,
    metadata: metadata,
    shelfIds: shelfIds,
  );



  /// Save the cover image of the book to the app directory
  /// 
  /// Returns:
  /// 
  /// `0`: Success, saved the cover image to device
  /// 
  /// `1`: Success, saved first image in epub contents to device
  /// 
  /// `-1`: Failed, Could not decode image from epub
  /// 
  /// `-2`: Failed, bookContent from epub is null
  /// 
  ///  `-3`: Failed, no images in epub
  /// 
  Future<int> saveCoverImage({required epubx.EpubBookRef epubBookRef}) async {
    // Save image to app directory
    final img.Image? cover = await epubBookRef.readCover();
    if (cover != null) {
      final io.Directory dir = await bookDirectoryPath;
      final String coverImagePath = '${dir.path}/cover.png';
      /*final io.File coverImage = */await io.File(coverImagePath).writeAsBytes(img.encodePng(cover));
      return 0;
    } else {
      // If the cover image is null, use the first image

      // Reference to the book's content (HTML files, stylesheets, images, fonts, etc.)
      final epubx.EpubContentRef? bookContentRef = epubBookRef.Content;

      if (bookContentRef == null) {
        // bookContent from epub is null
        return -2;
      }

      // Get the reference to all images in the book (file name is the key)
      final Map<String?, epubx.EpubByteContentFileRef>? images = bookContentRef.Images;

      if (images == null) {
        // images from epub is null
        return -3;
      }
      
      // Get the reference to the first image
      final epubx.EpubByteContentFileRef firstImage = images.values.first;

      // Read in the first image
      final List<int> imageContent = await firstImage.readContent();
      
      // Convert the image content into an img.Image object
      final img.Image? cover = img.decodeImage(imageContent);
      if (cover != null) {
        // Convert the image to png, copy the file to the book's folder with the name 'cover.png'
        final io.Directory dir = await bookDirectoryPath;
        final String coverImagePath = '${dir.path}/cover.png';
        /*final io.File coverImage = */await io.File(coverImagePath).writeAsBytes(img.encodePng(cover));
        // Image cover saved to: ${coverImage.path}
        return 1;
      } else {
        // Could not decode image from epub
        return -1;
      }
    }
  }

}