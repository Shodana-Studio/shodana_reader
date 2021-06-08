// ignore_for_file: avoid_print
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:shodana_reader/core/res/constants.dart';
import 'package:shodana_reader/env/env.dart';

Client client = Client(endPoint: AppConstant.endpoint)
  .setProject(AppConstant.project)
  .setKey(ScriptEnv.databaseKey);
Database db = Database(client);

const String readingStatsCollectionName = 'Reading Stats';
const String booksCollectionName = 'Books';
const String shelvesCollectionName = 'Shelves';
const String usersCollectionName = 'Users';

Future<void> main() async {
  print('Current Collections:');
  final collections = await getCollections();
  print(collections);

  bool readingStatsCollectionExists = false;
  bool bookCollectionExists = false;
  bool shelvesCollectionExists = false;
  bool usersCollectionExists = false;
  if (collections != null) {
    collections.forEach((element) {
      if (element['name'] == readingStatsCollectionName) {
        readingStatsCollectionExists = true;
      } else if (element['name'] == booksCollectionName) {
        bookCollectionExists = true;
      } else if (element['name'] == shelvesCollectionName) {
        shelvesCollectionExists = true;
      } else if (element['name'] == usersCollectionName) {
        usersCollectionExists = true;
      }
    });
  }

  final readingStatsCollectionRes;
  final booksCollectionRes;
  final shelvesCollectionRes;
  final usersCollectionRes;
  if (!readingStatsCollectionExists) {
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
    ]);
    
    if (!bookCollectionExists && readingStatsCollectionRes != null) {
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
          'key': 'filename',
          'label': 'Filename',
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
          'key': 'readingTimes',
          'label': 'Reading Times',
          'type': 'document',
          'default': '',
          'array': true,
          'required': false,
          'list': [readingStatsCollectionRes[r'$id']]
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
      ]);
      
      if (!shelvesCollectionExists && booksCollectionRes != null) {
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
          {
            'key': 'books',
            'label': 'Books',
            'type': 'document',
            'default': '',
            'array': true,
            'required': false,
            'list': [booksCollectionRes[r'$id']]
          },
        ]);

        if (!usersCollectionExists && booksCollectionRes != null && shelvesCollectionRes != null) {
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
              'list': [shelvesCollectionRes[r'$id'], booksCollectionRes[r'$id']],
            },
          ]);


        } else {
          print('Collection $usersCollectionName already exists');
        }
      } else {
        print('Collection $shelvesCollectionName already exists');
      }
    } else {
      print('Collection $booksCollectionName already exists');
    }
  } else {
    print('Collection $readingStatsCollectionName already exists');
  }
}

Future<dynamic> createCollection({required String name, required List<String> read, required List<String> write, required List<dynamic> rules}) async {
  try {
    final res = await db.createCollection(name: name, read: read, write: write, rules: rules);
    print('Collection $name created:');
    print(res.data);
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