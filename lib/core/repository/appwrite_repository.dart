import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_constants.dart';
import '../data/failure.dart';
import '../service/appwrite_service.dart';

final appwriteServiceProvider = Provider<AppwriteService>((ref) {
  final appwriteService = AppwriteService(
    client: Client(endPoint: AppConstant.endpoint,)
        .setProject(AppConstant.project)
        .setSelfSigned() // TODO: Remove in production
  );

  return appwriteService;
});

final appwriteRepositoryProvider = Provider<AppwriteRepository>((ref) {
  final appwriteService = ref.watch(appwriteServiceProvider);

  return AppwriteRepository(appwriteService);
});

class AppwriteRepository {
  AppwriteRepository(this._appwriteService);
  final AppwriteService _appwriteService;

  Future<Either<Failure, Response<dynamic>>> createDocument({required String collectionId, required Map<dynamic, dynamic> data}) async {
    try {
      final response = await _appwriteService.db.createDocument(collectionId: collectionId, data: data);
      return Right(response);
    } on AppwriteException catch (e) {
      return Left(Failure('AppwriteException\nCode: ${e.code}\nMessage:${e.message}'));
    } on SocketException catch (_) {
      return Left(Failure('No internet connection'));
    } on Exception catch (_) {
      return Left(Failure('Unknown exception'));
    }
  }
}