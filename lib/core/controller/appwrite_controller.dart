import 'package:dartz/dartz.dart';
import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/book.dart';
import '../model/failure.dart';
import '../repository/appwrite_repository.dart';
import '../res/app_constants.dart';

class AppwriteController extends StateNotifier<AsyncValue<String>> {
  AppwriteController(
    this._appwriteRepository, [
    AsyncValue<String>? state,
  ]) : super(state ?? const AsyncValue.data(''));

  final AppwriteRepository _appwriteRepository;

  Future<Either<Failure, Response<dynamic>>> createBook(Book book) async {
    state = const AsyncValue.loading();
    final result = await _appwriteRepository.createDocument(collectionId: AppConstant.booksCollection, data: book.toMap());

    result.fold(
      (failure) => state = AsyncValue.error(failure),
      (response) => state = AsyncValue.data((response.data as Book).toJson())
    );

    return result;
  }
}

