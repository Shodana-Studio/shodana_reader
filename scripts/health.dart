// Before running the program, get the appwrite endpoint,
// project id, and an api key with access to health read
// 
// Run the following all on the same line:
// dart scripts/health.dart --dart-define=appwriteEndpoint={ENDPOINT}
//  --dart-define=appwriteProjectId={PROJECT_ID}
//  --dart-define=appwriteApiKey={KEY}

// ignore_for_file: avoid_print
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:shodana_reader/core/res/environment_config.dart';

Client client = Client(endPoint: EnvironmentConfig.appwriteEndpoint)
  .setProject(EnvironmentConfig.appwriteProjectId)
  .setKey(EnvironmentConfig.appwriteApiKey);
Health health = Health(client);

Future<void> main() async {
  await getHttpStatus();
  await getDbStatus();
  await getCacheStatus();
  await getTime();
  await getQueueWebhooks();
  await getQueueTasks();
  await getQueueLogs();
  await getQueueUsage();
  await getQueueCertificates();
  await getQueueFunctions();
  await getStorageLocal();
  await getAntiVirus();
}

Future<void> getHttpStatus() async {
  final Future<Response> result = health.get();

  await result.then((response) {
    print('Http Status : ${response.data['status']}');
  }).catchError((error) {
    print(error.response);
  });
}

Future<void> getDbStatus() async {
  final Future<Response> result = health.getDB();

  await result
    .then((response) {
      print('Database Status : ${response.data['status']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getCacheStatus() async {
  final Future<Response> result = health.getCache();

  await result
    .then((response) {
      print('Cache Status : ${response.data['status']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getTime() async {
  final Future<Response> result = health.getTime();

  await result
    .then((response) {
      print('Time status:');
      print('  Remote : ${response.data['remote']}');
      print('  Local : ${response.data['local']}');
      print('  Difference : ${response.data['diff']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getQueueWebhooks() async {
  final Future<Response> result = health.getQueueWebhooks();

  await result
    .then((response) {
      print('Webhooks Queue Size : ${response.data['size']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getQueueTasks() async {
  final Future<Response> result = health.getQueueTasks();

  await result
    .then((response) {
      print('Task Queue Size : ${response.data['size']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getQueueLogs() async {
  final Future<Response> result = health.getQueueLogs();

  await result
    .then((response) {
      print('Logs Queue Size : ${response.data['size']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getQueueUsage() async {
  final Future<Response> result = health.getQueueUsage();

  await result
    .then((response) {
      print('Usage Stats Queue Size : ${response.data['size']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getQueueCertificates() async {
  final Future<Response> result = health.getQueueCertificates();

  await result
    .then((response) {
      print('Certificates Queue Size : ${response.data['size']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getQueueFunctions() async {
  final Future<Response> result = health.getQueueFunctions();

  await result
    .then((response) {
      print('Functions Queue Size : ${response.data['size']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getStorageLocal() async {
  final Future<Response> result = health.getStorageLocal();

  await result
    .then((response) {
      print('Local Storage Status : ${response.data['status']}');
    }).catchError((error) {
      print(error.response);
  });
}

Future<void> getAntiVirus() async {
  final Future<Response> result = health.getAntiVirus();

  await result
    .then((response) {
      print('AntiVirus:');
      print('  Status : ${response.data['status']}');
      print('  Version : ${response.data['version']}');
    }).catchError((error) {
      print(error.response);
  });
}