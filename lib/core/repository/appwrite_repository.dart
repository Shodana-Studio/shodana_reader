import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/book.dart';
import '../model/failure.dart';
import '../res/app_constants.dart';
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

  Future<Either<Failure, Book>> createBook(Book book) async {
    try {
      final response = await _appwriteService.db.createDocument(collectionId: AppConstant.booksCollection, data: book.toMap());
      return Right(response.data as Book);
    } on AppwriteException catch (e) {
      return Left(Failure('AppwriteException\nCode: ${e.code}\nMessage:${e.message}'));
    } on SocketException catch (_) {
      return Left(Failure('No internet connection'));
    } on Exception catch (_) {
      return Left(Failure('Unknown exception'));
    }
  }
}