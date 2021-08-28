// Before running the program, get the appwrite endpoint,
// project id, and an api key with access to collections and documents read/write
// Run the following:
// dart scripts/db_tests.dart --dart-define=appwriteEndpoint={ENDPOINT}
//   --dart-define=appwriteProjectId={PROJECT_ID}
//   --dart-define=appwriteApiKey={KEY}

// ignore_for_file: avoid_print
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:shodana_reader/core/res/environment_config.dart';

Client client = Client(endPoint: EnvironmentConfig.appwriteEndpoint)
  .setProject(EnvironmentConfig.appwriteProjectId)
  .setKey(EnvironmentConfig.appwriteApiKey);
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
  //     createdDate: DateTime.now().toUtc(), 
  //     shelfIds: const [], 
  //     shelfIdsLastModDate: DateTime.now().toUtc()
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

