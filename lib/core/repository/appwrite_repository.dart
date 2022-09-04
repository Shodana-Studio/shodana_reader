import 'dart:io';

import 'package:appwrite/models.dart';
import 'package:appwrite_auth_kit/appwrite_auth_kit.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/failure.dart';
import '../service/appwrite_service.dart';

final appwriteRepositoryProvider = Provider<AppwriteRepository>((ref) {
  final appwriteService = ref.watch(appwriteServiceProvider);

  return AppwriteRepository(appwriteService);
});

class AppwriteRepository {
  AppwriteRepository(this._appwriteService);
  final AppwriteService _appwriteService;

  Future<Either<Failure, Document>> createDocument(
      {required String collectionId,
      required Map<dynamic, dynamic> data}) async {
    try {
      final doc = await _appwriteService.db.createDocument(
          collectionId: collectionId, data: data, documentId: 'unique()');
      return Right(doc);
    } on AppwriteException catch (e) {
      return Left(
          Failure('AppwriteException\nCode: ${e.code}\nMessage:${e.message}'));
    } on SocketException catch (_) {
      return Left(Failure('No internet connection'));
    } on Exception catch (_) {
      return Left(Failure('Unknown exception'));
    }
  }
}
