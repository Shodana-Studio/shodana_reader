import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
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
    _db = Database(client);
    _teams = Teams(client);
    _storage = Storage(client);
    _avatars = Avatars(client);
  }

  late final Database _db;
  late final Teams _teams;
  late final Storage _storage;
  late final Avatars _avatars;
  Database get db => _db;

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

  // Teams functions

  Future<TeamList> listTeams() {
    return _teams.list();
  }

  Future<Team> createTeam(String name) {
    return _teams.create(name: name);
  }

  Future<dynamic> deleteTeam(String teamId) {
    return _teams.delete(teamId: teamId);
  }

  Future<MembershipList> listMembers(String teamId) {
    return _teams.getMemberships(teamId: teamId);
  }

  Future<Membership> addMember({
    required String teamId,
    required String email,
    required List<String> roles,
  }) {
    return _teams.createMembership(
        teamId: teamId, email: email, roles: roles, url: AppConstant.url);
  }

  /// Delete Team Membership
  ///
  /// This endpoint allows a user to leave a team or for a team owner to delete the
  /// membership of any other team member. You can also use this endpoint to delete
  /// a user membership even if it is not accepted.
  Future<dynamic> deleteMember({
    required String teamId,
    required String membershipId,
  }) {
    return _teams.deleteMembership(teamId: teamId, membershipId: membershipId);
  }

  // Storage functions

  Future<Uint8List> getProfilePicture(String fileId) async {
    final data =
        await _storage.getFilePreview(fileId: fileId, width: 100, height: 100);
    return data;
  }

  Future<File> uploadFile(
    MultipartFile file,
    List<String> readPermission,
    List<String> writePermission,
  ) async {
    final appwriteFile = await _storage.createFile(
      file: file,
      read: readPermission,
      write: writePermission,
    );

    return appwriteFile;
  }

  /// Upload a file to Appwrite using its byte data
  ///
  /// Ex: [readPermission] Each entry should be in format 'user:$userId'
  ///
  /// See Appwrite docs for details
  Future<File> uploadFileFromBytes({
    required List<int> bytes,
    required String filename,
    required List<String> readPermission,
    required List<String> writePermission,
  }) async {
    final appwriteFile = await _storage.createFile(
      file: MultipartFile.fromBytes(
        'file',
        bytes,
        filename: filename,
      ),
      read: readPermission,
      write: writePermission,
    );

    return appwriteFile;
  }

  Future<Uint8List> getFileDownload(String fileId) async {
    final data = await _storage.getFileDownload(fileId: fileId);

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
