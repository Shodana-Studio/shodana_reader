import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/book.dart';
import '../data/failure.dart';
import 'base_command.dart';

final refreshCommandProvider = Provider<RefreshBooksCommand>((ref) {
  return RefreshBooksCommand(ref);
});

class RefreshBooksCommand extends BaseCommand {
  RefreshBooksCommand(ProviderRef ref) : super(ref);

 
  Future<Either<Failure, List<Book>>> run() async {
    // Make service call and inject results into the model
    try {
      // TODO: Sync local books database with appwrite database here
      final DocumentList documents = await appwriteService.getBooks();
      final List<Book> books = documents.documents.map((doc) => Book.fromMap(doc.data)).toList();
      userModelNotifier.setBooks(books);
       
      // Return our posts to the caller in case they care
      return Right(books);
    } on AppwriteException catch (e) {
      return Left(Failure(e.message ?? 'Unknown appwrite error'));
    }
  } 
}