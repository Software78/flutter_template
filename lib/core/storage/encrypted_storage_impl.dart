import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'storage_client.dart';

class SecureStorageClient implements EncryptedStorageClient {
  final storage = const FlutterSecureStorage();

  @override
  Future secureDelete(String key) {
    return storage.delete(key: key);
  }

  @override
  Future secureDeleteAll() {
    return storage.deleteAll();
  }

  @override
  Future<T?> secureRead<T>(String key) {
    return storage.read(key: key) as Future<T?>;
  }

  @override
  Future<void> secureWrite<T>(String key, T value) {
    return storage.write(key: key, value: value.toString());
  }
}
