import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:appwrite_auth_kit/appwrite_auth_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_constants.dart';
import '../data/book.dart';

final appwriteServiceProvider = Provider<AppwriteService>((ref) {
  final appwriteService = AppwriteService(
      client: Client(
    endPoint: AppConstant.endpoint,
  )
          .setProject(AppConstant.project)
          .setSelfSigned() // TODO: Remove in production
      );

  return appwriteService;
});

class AppwriteService extends AuthNotifier {
  AppwriteService({required Client client}) : super(client) {
    _db = Databases(client, databaseId: AppConstant.booksDatabaseId);
    _storage = Storage(client);
    _avatars = Avatars(client);
  }

  late final Databases _db;
  late final Storage _storage;
  late final Avatars _avatars;
  Databases get db => _db;

  // Account functions in flappwrite_account_kit

  // Database functions

  Future<Document> addBook({
    required Book book,
    required List<String> read,
    required List<String> write,
  }) async {
    final Document doc = await _db.createDocument(
      collectionId: AppConstant.booksCollection,
      data: book.toMap(),
      read: read,
      write: write,
      documentId: AppConstant.booksDatabaseId,
    );
    return doc;
  }

  Future<DocumentList> getBooks() async {
    final DocumentList docList =
        await _db.listDocuments(collectionId: AppConstant.booksCollection);
    // https://appwrite.io/docs/models/documentList
    return docList;
  }

  // TODO: Modify and delete books using cloud function

  // Storage functions

  Future<Uint8List> getProfilePicture(String fileId) async {
    final data = await _storage.getFilePreview(
      fileId: fileId,
      width: 100,
      height: 100,
      bucketId: AppConstant.booksStorageBucketId,
    );
    return data;
  }

  Future<File> uploadFile(
    InputFile file,
    String fileId,
    List<String> readPermission,
    List<String> writePermission,
  ) async {
    final appwriteFile = await _storage.createFile(
      file: file,
      fileId: fileId,
      read: readPermission,
      write: writePermission,
      bucketId: AppConstant.booksStorageBucketId,
    );

    return appwriteFile;
  }

  Future<Uint8List> getFileDownload(String fileId) async {
    final data = await _storage.getFileDownload(
        fileId: fileId, bucketId: AppConstant.booksStorageBucketId);

    return data;
  }

  // Avatars functions

  Future<Uint8List> getCountryFlag(String code) async {
    final data = await _avatars.getFlag(code: code);
    return data;
  }

  Future<Uint8List> getImage(String url) async {
    final data = await _avatars.getImage(url: url);
    return data;
  }

  Future<Uint8List> getFavicon(String url) async {
    final data = await _avatars.getFavicon(url: url);
    return data;
  }

  Future<Uint8List> getQR(String text, {int size = 400}) async {
    final data = await _avatars.getQR(text: text, size: size);
    return data;
  }

  Future<Uint8List> getInitials(String name) async {
    final data = await _avatars.getInitials(name: name);
    return data;
  }

  String getInitialsLink(String name, {int width = 100, int height = 100}) {
    return '${AppConstant.endpoint}/avatars/initials?project=${AppConstant.project}&name=$name&width=$width&height=$height';
  }
}
