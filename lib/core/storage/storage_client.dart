abstract class StorageClient {
  Future<T?> read<T>(String key);
  Future write<T>(String key, T value);
  Future delete(String key);
  Future deleteAll({List<String> ignoredKeys = const []});
}

abstract class EncryptedStorageClient {
  Future<void> secureWrite<T>(String key, T value);
  Future<T?> secureRead<T>(String key);
  Future<void> secureDelete(String key);
  Future<void> secureDeleteAll();
}

abstract class DatabaseStorage {
  void openDb();
  void closeDb();
  Future<List<T>> readFromDb<T>();
  Future<void> writeToDb<T>(T value);
  Future<void> writeListToDb<T>(List<T> value);
  // Future<List<T>> queryDataWithParams<T>(dynamic query);
}

abstract class LocalStorage {}

class LocalStoragImpl implements LocalStorage {
  final StorageClient storageClient;
  final EncryptedStorageClient encryptedStorageClient;
  final DatabaseStorage databaseStorage;

  LocalStoragImpl({
    required this.storageClient,
    required this.encryptedStorageClient,
    required this.databaseStorage,
  });
}
