import 'dart:typed_data';

import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import '../../res/constants.dart';

class AppwriteService {
  AppwriteService._internal() {
    _client = Client(endPoint: AppConstants.endpoint,)
        .setProject(AppConstants.project)
        .setSelfSigned() // TODO: Remove in production
        ;
    _account = Account(_client);
    _db = Database(_client);
    _teams = Teams(_client);
    _storage = Storage(_client);
    _avatars = Avatars(_client);
  }

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

  // Account functions

  // Future verifyEmail() {
  //   return _account.createVerification(url: url;)
  // }

  Future<Map<String, dynamic>> updatePrefs(Map<String, dynamic> prefs) async {
    final res = await _account.updatePrefs(prefs: prefs);
    return res.data;
  }

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
    return _teams.createMembership(teamId: teamId, email: email, roles: roles, url: AppConstants.url);
  }

  Future deleteMember({required String teamId, required String membershipId}) {
    return _teams.deleteMembership(teamId: teamId, membershipId: membershipId);
  }

  // TODO: Db functions

  // Storage functions

  Future<Uint8List> getProfilePicture(String fileId) async {
    final res = await _storage.getFilePreview(fileId: fileId, width: 100, height: 100);
    return res.data;
  }

  Future<Map<String, dynamic>> uploadFile(MultipartFile file, List<String> permission) async {
    final res = await _storage.createFile(
      file: file,
      read: permission,
      write: permission,
    );

    return res.data;
  }

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
    return '${AppConstants.endpoint}/avatars/initials?project=${AppConstants.project}&name=$name&width=$width&height=$height';
  }
}