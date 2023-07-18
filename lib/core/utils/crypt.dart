import 'dart:convert';

import 'package:encrypt/encrypt.dart' as crypt;

class CryptoSystem {
  static final crypt.Key _key =
      crypt.Key.fromUtf8('lYfg78mF6hHsTGw9lYfg78mF6hHsTGw9');

  static final crypt.Encrypter _encrypter =
      crypt.Encrypter(crypt.AES(_key, mode: crypt.AESMode.cbc));

  static final crypt.IV _iv = crypt.IV.fromUtf8('37HVLSf3UYwZ6vUp');

  static String encrypt(String input) {
    return _encrypter.encrypt(input, iv: _iv).base64;
  }

  static String? decrypt(String? input) {
    if (input == null || input == '') return null;
    return _encrypter.decrypt64(base64.normalize(input), iv: _iv);
  }
}
