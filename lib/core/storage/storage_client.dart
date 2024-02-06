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
}

abstract class LocalStorage
    implements StorageClient, EncryptedStorageClient, DatabaseStorage {}
