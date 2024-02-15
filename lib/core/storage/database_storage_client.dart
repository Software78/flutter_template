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

  @override
  Future<List<T>> readFromDb<T>() async {
    final collection = _isar.collection<T, T>();
    return collection.where().findAll();
  }

  @override
  Future<void> writeToDb<T>(T value) async {
    final collection = _isar.collection<T, T>();
    return collection.put(value);
  }

  @override
  Future<void> writeListToDb<T>(List<T> value) async {
    final collection = _isar.collection<T, T>();
    return collection.putAll(value);
  }

  // @override
  // Future<List<T>> queryDataWithParams<T>(IsarQuery<T> query) async {
  //   final collection = _isar.collection<T, T>();
  //   return collection.where().f
        
  // }
}
