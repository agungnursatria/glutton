import 'package:encrypt/encrypt.dart';

/// Encrypt value using AES (Advanced Encryption Standard)
/// Using : https://pub.dev/packages/encrypt
class GluttonEncrypter {
  static final _aesKey = 'Private_AES_Key_GluttonEncrypter';
  Encrypter _encrypter;
  IV _iv;

  GluttonEncrypter({
    Encrypter encrypter,
    IV iv,
  })  : _iv = iv ?? IV.fromLength(16),
        _encrypter = encrypter ?? Encrypter(AES(Key.fromUtf8(_aesKey)));

  /// Encrypt
  String encrypt(String value) => _encrypter.encrypt(value, iv: _iv).base64;
  String encryptTwice(String value) => encrypt(encrypt(value));

  /// Decrypt
  String decrypt(String value) => _encrypter.decrypt64(value, iv: _iv);
  String decryptTwice(String value) => decrypt(decrypt(value));
}
