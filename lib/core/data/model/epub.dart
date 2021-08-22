import 'dart:io' as io;
import 'package:image/image.dart' as img;
import 'package:epubx/epubx.dart' as epubx;
import '../service/storage_util.dart';

import 'book.dart';

class EPUB extends Book {
  const EPUB({
    required bookId,
    required userId,
    fileId,
    required bookType,
    title,
    titleLastModDate,
    author,
    authorLastModDate,
    description,
    descriptionLastModDate,
    readingProgress,
    readingProgressLastModDate,
    publisher,
    publisherLastModDate,
    publishedDate,
    publishedDateLastModDate,
    required createdDate,
    startReadingDate,
    startReadingDateLastModDate,
    finishReadingDate,
    finishReadingDateLastModDate,
    metadata,
    metadataLastModDate,
    required List<String> shelfIds,
    required shelfIdsLastModDate
  }) : super(bookId: bookId, userId: userId, fileId: fileId, bookType: bookType, title: title,
              titleLastModDate: titleLastModDate, author: author, authorLastModDate: authorLastModDate,
              description: description, descriptionLastModDate: descriptionLastModDate,
              readingProgress: readingProgress, readingProgressLastModDate: readingProgressLastModDate,
              publisher: publisher, publisherLastModDate: publisherLastModDate, publishedDate: publishedDate,
              publishedDateLastModDate: publishedDateLastModDate, createdDate: createdDate,
              startReadingDate: startReadingDate, startReadingDateLastModDate: startReadingDateLastModDate,
              finishReadingDate: finishReadingDate, finishReadingDateLastModDate: finishReadingDateLastModDate,
              metadata: metadata, metadataLastModDate: metadataLastModDate, shelfIds: shelfIds,
              shelfIdsLastModDate: shelfIdsLastModDate);



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
  /// `-2`: Failed, imageContent of the image from epub is null (Should never happen)
  Future<int> saveCoverImage({required epubx.EpubBook epubBook}) async {
    // Save image to app directory
    final img.Image? cover = epubBook.CoverImage;
    final io.Directory dir = await StorageUtil.getAppDirectory();
    if (cover != null) {
      /*final io.File coverImage = */await io.File('${dir.path}/$bookId/cover.png').writeAsBytes(img.encodePng(cover));
      return 0;
    } else {
      // If the cover image is null, use the first image
      // debugPrint('No cover image was found, using the first image in the book instead...');

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
          /*final io.File coverImage = */await io.File('${dir.path}/$bookId/cover.png').writeAsBytes(img.encodePng(cover));
          // debugPrint('Image cover saved to: ${coverImage.path}');
          return 1;
        } else {
          // debugPrint('Could not decode image from epub');
          return -1;
        }
      } else {
        // debugPrint('imageContent of image from epub is null');
        return -2;
      }
    }
  }

}