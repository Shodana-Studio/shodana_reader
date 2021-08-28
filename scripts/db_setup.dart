// Run in terminal with "dart scripts/db_setup.dart"

// Before running the program, get the appwrite endpoint,
// project id, and an api key with access to collections and documents read/write
// Run the following:
// flutter run --dart-define=appwriteEndpoint={ENDPOINT}
// flutter run --dart-define=appwriteProjectId={PROJECT_ID}
// flutter run --dart-define=appwriteDatabaseApiKey={KEY}

// ignore_for_file: avoid_print
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:shodana_reader/core/res/environment_config.dart';

Client client = Client(endPoint: EnvironmentConfig.appwriteEndpoint)
  .setProject(EnvironmentConfig.appwriteProjectId)
  .setKey(EnvironmentConfig.appwriteDatabaseApiKey);
Database db = Database(client);

const String readingStatsCollectionName = 'Reading Stats';
const String booksCollectionName = 'Books';
const String shelvesCollectionName = 'Shelves';
const String usersCollectionName = 'Users';

Future<void> main() async {
  final success = await setupDatabase();
  print(success ? 'Database setup completed' : 'Database setup failed... Do the database collections already exist?');

  print('\nCurrent Collections:');
  final collections = await getCollections();
  print(collections);
}

Future<bool> setupDatabase() async {
  final collections = await getCollections();

  bool readingStatsCollectionExists = false;
  bool bookCollectionExists = false;
  bool shelvesCollectionExists = false;
  bool usersCollectionExists = false;

  if (collections == null) {
    return false;
  }

  for (final collection in collections) {
    if (collection['name'] == readingStatsCollectionName) {
      readingStatsCollectionExists = true;
    } else if (collection['name'] == booksCollectionName) {
      bookCollectionExists = true;
    } else if (collection['name'] == shelvesCollectionName) {
      shelvesCollectionExists = true;
    } else if (collection['name'] == usersCollectionName) {
      usersCollectionExists = true;
    }
  }
  
  // TODO: Add required id attribute to each collection
  // TODO: Add the id to each model
  if (readingStatsCollectionExists) {
    print('Collection $readingStatsCollectionName already exists, aborting...');
    return false;
  }

  if (bookCollectionExists) {
    print('Collection $booksCollectionName already exists, aborting...');
    return false;
  }

  if (shelvesCollectionExists) {
    print('Collection $shelvesCollectionName already exists, aborting...');
    return false;
  }

  if (usersCollectionExists) {
    print('Collection $usersCollectionName already exists, aborting...');
    return false;
  }

  final dynamic readingStatsCollectionRes;
  final dynamic booksCollectionRes;
  final dynamic shelvesCollectionRes;
  final dynamic usersCollectionRes;
  
  readingStatsCollectionRes = await createCollection(name: readingStatsCollectionName, read: ['role:member'], write: ['role:member'], rules: [
    {
      'key': 'userId',
      'label': 'User ID',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'timeRead',
      'label': 'Time Read',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'date',
      'label': 'Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'bookId',
      'label': 'Book ID',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
  ]);
  
  if (readingStatsCollectionRes == null) {
    return false;
  }

  print('Collection $readingStatsCollectionName created');

  booksCollectionRes = await createCollection(name: booksCollectionName, read: ['role:member'], write: ['role:member'], rules: [
    {
      'key': 'userId',
      'label': 'User ID',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'createdDate',
      'label': 'Created Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'localStorageId',
      'label': 'Local Storage ID',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'fileId',
      'label': 'File ID',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'bookType',
      'label': 'Book Type',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'title',
      'label': 'Title',
      'type': 'text',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'titleLastModDate',
      'label': 'Title Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'author',
      'label': 'Author',
      'type': 'text',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'authorLastModDate',
      'label': 'Author Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'description',
      'label': 'Description',
      'type': 'text',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'descriptionLastModDate',
      'label': 'Description Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'readingProgress',
      'label': 'Reading Progress',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'readingProgressLastModDate',
      'label': 'Reading Progress Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'publisher',
      'label': 'Publisher',
      'type': 'text',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'publisherLastModDate',
      'label': 'Publisher Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'publishedDate',
      'label': 'Published Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'publishedDateLastModDate',
      'label': 'Published Date Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'startReadingDate',
      'label': 'Start Reading Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'startReadingDateLastModDate',
      'label': 'Start Reading Date Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'finishReadingDate',
      'label': 'Finish Reading Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'finishReadingDateLastModDate',
      'label': 'Finish Reading Date Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'metadata',
      'label': 'Metadata',
      'type': 'text',
      'default': '',
      'array': true,
      'required': false,
    },
    {
      'key': 'metadataLastModDate',
      'label': 'Metadata Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'shelfIds',
      'label': 'Shelf Ids',
      'type': 'text',
      'default': [],
      'array': true,
      'required': true,
    },
    {
      'key': 'shelfIdsLastModDate',
      'label': 'Shelf Ids Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': true,
    },
  ]);
  
  if (booksCollectionRes == null) {
    return false;
  }

  print('Collection $booksCollectionName created');
  
  shelvesCollectionRes = await createCollection(name: shelvesCollectionName, read: ['role:member'], write: ['role:member'], rules: [
    {
      'key': 'userId',
      'label': 'User ID',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'createdDate',
      'label': 'Created Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'title',
      'label': 'Title',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'titleLastModDate',
      'label': 'Title Last ModifiedDate',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'description',
      'label': 'Description',
      'type': 'text',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'descriptionLastModDate',
      'label': 'Description Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'startReadingDate',
      'label': 'Start Reading Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'startReadingDateLastModDate',
      'label': 'Start Reading Date Last ModifiedDate',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'finishReadingDate',
      'label': 'Finish Reading Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    {
      'key': 'finishReadingDateLastModDate',
      'label': 'Finish Reading Date Last Modified Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': false,
    },
    // {
    //   'key': 'books',
    //   'label': 'Books',
    //   'type': 'document',
    //   'default': '',
    //   'array': true,
    //   'required': false,
    //   'list': [booksCollectionRes[r'$id']]
    // },
  ]);

  if (shelvesCollectionRes == null) {
    return false;
  }

  print('Collection $shelvesCollectionName created');
  
  usersCollectionRes = await createCollection(name: usersCollectionName, read: ['role:member'], write: ['role:member'], rules: [
    {
      'key': 'userId',
      'label': 'User ID',
      'type': 'text',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'createdDate',
      'label': 'Created Date',
      'type': 'numeric',
      'default': '',
      'array': false,
      'required': true,
    },
    {
      'key': 'books',
      'label': 'Books',
      'type': 'document',
      'default': '',
      'array': true,
      'required': false,
      'list': [booksCollectionRes[r'$id']],
    },
    {
      'key': 'shelves',
      'label': 'Shelves',
      'type': 'document',
      'default': '',
      'array': true,
      'required': false,
      'list': [shelvesCollectionRes[r'$id']],
    },
  ]);

  if (usersCollectionRes == null) {
    return false;
  }
  
  print('Collection $usersCollectionName created');

  return true;
}

Future<dynamic> createCollection({required String name, required List<String> read, required List<String> write, required List<dynamic> rules}) async {
  try {
    final res = await db.createCollection(name: name, read: read, write: write, rules: rules);
    // print('Collection $name created:');
    // print(res.data);
    return res.data;
  } on AppwriteException catch(e) {
    print(e.message);
    return null;
  }
}

Future<List?> getCollections() async {
  try {
    final res = await db.listCollections();
    return res.data['collections'];
  } on AppwriteException catch(e) {
    print(e.message);
    return null;
  }
}