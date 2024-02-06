import 'package:encrypt/encrypt.dart' as crypt;

abstract class CryptoSystem {
  String encrypt(String data);
  String decrypt(String data);
}

class AESCryptoSystem implements CryptoSystem {
  final String key;
  final String vector;

  const AESCryptoSystem({
    required this.key,
    required this.vector,
  });

  @override
  String encrypt(String? input) {
    final crypt.Encrypter encrypter = crypt.Encrypter(
        crypt.AES(crypt.Key.fromUtf8(key), mode: crypt.AESMode.cbc));
    return input == null
        ? ""
        : encrypter.encrypt(input, iv: crypt.IV.fromUtf8(vector)).base64;
  }

  @override
  String decrypt(String? input) {
    final crypt.Key deckey = crypt.Key.fromUtf8(key);
    final crypt.Encrypter decrypter =
        crypt.Encrypter(crypt.AES(deckey, mode: crypt.AESMode.cbc));
    final crypt.IV deciv = crypt.IV.fromUtf8(vector);
    return input == null ? "" : decrypter.decrypt64(input, iv: deciv);
  }
}
