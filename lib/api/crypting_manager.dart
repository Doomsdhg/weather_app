import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/constants/constants.dart';

class CryptingManager {
  Future<String> getApiKey() async {
    final apiKeyObject = await _getApiKeyData();
    return _getDecryptedApiKey(apiKeyObject);
  }

  Future _getApiKeyData() async {
    final response = await rootBundle.loadString(AssetsPaths.API_KEY);
    final apiKeyObject = await json.decode(response);
    return apiKeyObject;
  }

  String _getDecryptedApiKey(dynamic apiKeyObject) {
    final encryptedApiKey = Encrypted.fromBase64(apiKeyObject[ApiKeyObjectAccessors.ENCRYPTED_API_KEY]);
    final key = Key.fromUtf8(apiKeyObject[ApiKeyObjectAccessors.SECRET_KEY]);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final iv = IV.fromUtf8(apiKeyObject[ApiKeyObjectAccessors.INITIAL_VECTOR]);
    return encrypter.decrypt(encryptedApiKey, iv: iv).toString();
  }
}

