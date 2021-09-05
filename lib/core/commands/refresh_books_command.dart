import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';

import '../data/book.dart';
import '../data/failure.dart';
import 'base_command.dart';

class RefreshBooksCommand extends BaseCommand {
 
  Future<Either<Failure, List<Book>>> run() async {
    // Make service call and inject results into the model
    try {
      // TODO: Sync local books database with appwrite database here
      final List<Book> books = await appwriteService.getBooks();
      userModel.userBooks = books;
       
      // Return our posts to the caller in case they care
      return Right(books);
    } on AppwriteException catch (e) {
      return Left(Failure(e.message ?? 'Unknown appwrite error'));
    }
  } 
}