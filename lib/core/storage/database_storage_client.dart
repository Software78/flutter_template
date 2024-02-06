import 'package:isar/isar.dart';

import 'storage_client.dart';

class IsarStorageClient implements DatabaseStorage {
  late Isar _isar;
  List<IsarCollectionSchema> schemas;
  final String directory;

  IsarStorageClient({required this.directory, required this.schemas}) {
    openDb();
  }

  @override
  void openDb() async {
    _isar = Isar.open(
      schemas: schemas,
      directory: directory,
    );
  }

  @override
  void closeDb() {
    _isar.close();
  }
}