// Run in terminal with "dart scripts/db_tests.dart"
// Before running, do the following:
// Add appwrite url, endpoint, and project id in "lib/core/res/constants.dart"
// Add api key with permissions for collections and documents read/write in file "scripts/.env" with format:
// DATABASE_KEY={key}

// ignore_for_file: avoid_print
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:shodana_reader/core/data/model/book.dart';
import 'package:shodana_reader/core/data/model/book_type.dart';
import 'package:shodana_reader/core/res/constants.dart';
import 'package:shodana_reader/env/env.dart';

Client client = Client(endPoint: AppConstant.endpoint)
  .setProject(AppConstant.project)
  .setKey(ScriptEnv.databaseKey);
Database db = Database(client);

Future<void> main() async {
  // final Future result = db.createDocument(
  //   collectionId: AppConstant.readingStatsCollection,
  //   data: {
  //     // r'$id': '612145a884273',
  //     // r'$collection': '61205e62f3bc5',
  //     // r'$permissions': {
  //     //     'read': ['*'],
  //     //     'write': ['*']
  //     // },
  //     'userId': 'fgsdf',
  //     'timeRead': 542,
  //     'date': 7452574,
  //     'bookId': 'fdsfsdf'
  //   },
  // );

  // final book = Book(
  //     userId: '4354635432',
  //     fileId: '5646544465', 
  //     bookType: BookType.epub, 
  //     createdDate: DateTime.now(), 
  //     shelfIds: const [], 
  //     shelfIdsLastModDate: DateTime.now()
  //   );

  // final Future result = db.createDocument(
  //   collectionId: AppConstant.readingStatsCollection,
  //   data: book.toMap()
  // );

  // await result
  //   // ignore: unnecessary_lambdas
  //   .then((response) {
  //     print(response);
  //   })
  //   .catchError((AppwriteException error) {
  //     print(error.response);
  //   });
}

