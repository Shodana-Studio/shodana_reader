import 'dart:typed_data';

import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_constants.dart';
import '../data/appwrite_file.dart';
import '../data/documents_list.dart';
import '../model/book.dart';

final appwriteServiceProvider = Provider<AppwriteService>((ref) {
  final appwriteService = AppwriteService(
    client: Client(endPoint: AppConstant.endpoint,)
        .setProject(AppConstant.project)
        .setSelfSigned() // TODO: Remove in production
  );

  return appwriteService;
});

class AppwriteService {
  AppwriteService({required Client client}) {
    _client = client;
    _account = Account(_client);
    _db = Database(_client);
    _teams = Teams(_client);
    _storage = Storage(_client);
    _avatars = Avatars(_client);
  }

  // TODO: Remove
  AppwriteService._internal() {
    _client = Client(endPoint: AppConstant.endpoint,)
        .setProject(AppConstant.project)
        .setSelfSigned() // TODO: Remove in production
        ;
    _account = Account(_client);
    _db = Database(_client);
    _teams = Teams(_client);
    _storage = Storage(_client);
    _avatars = Avatars(_client);
  }

  // TODO: Remove
  // ignore: prefer_constructors_over_static_methods
  static AppwriteService get instance {
    _instance??= AppwriteService._internal();
    return _instance!;
  }

  static AppwriteService? _instance;
  late final Client _client;
  late final Account _account;
  late final Database _db;
  late final Teams _teams;
  late final Storage _storage;
  late final Avatars _avatars;

  Client get client => _client;
  Account get account => _account;
  Database get db => _db;

  // Account functions in flappwrite_account_kit

  // Database functions
  
  Future<Book> addBook({required Book book, required List<String> read, required List<String> write}) async {
    final Response res = await _db.createDocument(
      collectionId: AppConstant.booksCollection,
      data: book.toMap(),
      read: read,
      write: write,
    );
    return Book.fromMap(res.data);
  }
  
  Future<List<Book>> getBooks() async {
    final Response res = await _db.listDocuments(collectionId: AppConstant.booksCollection);
    // https://appwrite.io/docs/models/documentList
    final List documents = (res.data as DocumentsList).documents;
    return documents.map((e) => Book.fromMap(e)).toList();
  }

  // TODO: Modify and delete books using cloud function

  // Teams functions

  Future listTeams() {
    return _teams.list();
  }

  Future createTeam(String name) {
    return _teams.create(name: name);
  }

  Future deleteTeam(String teamId) {
    return _teams.delete(teamId: teamId);
  }

  Future listMembers(String teamId) {
    return _teams.getMemberships(teamId: teamId);
  }

  Future addMember({
    required String teamId,
    required String email,
    required List<String> roles,
  }) {
    return _teams.createMembership(teamId: teamId, email: email, roles: roles, url: AppConstant.url);
  }

  Future deleteMember({required String teamId, required String membershipId}) {
    return _teams.deleteMembership(teamId: teamId, membershipId: membershipId);
  }

  // Storage functions

  Future<Uint8List> getProfilePicture(String fileId) async {
    final res = await _storage.getFilePreview(fileId: fileId, width: 100, height: 100);
    return res.data;
  }

  // TODO: test
  Future<AppwriteFile> uploadFile(MultipartFile file, List<String> readPermission, List<String> writePermission) async {
    final res = await _storage.createFile(
      file: file,
      read: readPermission,
      write: writePermission,
    );

    return AppwriteFile.fromJson(res.data);
  }

  // TODO: Figure out return type
  // Future<Uint8List> getFile(String fileId) async {
  //   final res = await _storage.getFileDownload(fileId: fileId);

  //   return res.data;
  // }

  // Avatars functions

  Future<Uint8List> getCountryFlag(String code) async {
    final res = await _avatars.getFlag(code: code);
    return res.data;
  }

  Future<Uint8List> getImage(String url) async {
    final res = await _avatars.getImage(url: url);
    return res.data;
  }

  Future<Uint8List> getFavicon(String url) async {
    final res = await _avatars.getFavicon(url: url);
    return res.data;
  }

  Future<Uint8List> getQR(String text, {int size = 400}) async {
    final res = await _avatars.getQR(text: text, size: size);
    return res.data;
  }

  Future<Uint8List> getInitials(String name) async {
    final res = await _avatars.getInitials(name: name);
    return res.data;
  }

  String getInitialsLink(String name, {int width = 100, int height = 100}) {
    return '${AppConstant.endpoint}/avatars/initials?project=${AppConstant.project}&name=$name&width=$width&height=$height';
  }
}