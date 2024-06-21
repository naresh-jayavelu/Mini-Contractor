import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Store sensitive data securely
  Future<void> storeUserData(String id, String name, String type) async {
    await _storage.write(key: 'userId', value: id);
    await _storage.write(key: 'userName', value: name);
    await _storage.write(key: 'userType', value: type);
  }

  // Retrieve stored data
  Future<Map<String, String?>> getUserData() async {
    final id = await _storage.read(key: 'userId');
    final name = await _storage.read(key: 'userName');
    final type = await _storage.read(key: 'userType');
    return {'id': id, 'name': name, 'type': type};
  }

  // Clear stored data
  Future<void> clearUserData() async {
    await _storage.delete(key: 'userId');
    await _storage.delete(key: 'userName');
    await _storage.delete(key: 'userType');
  }
}

// Example usage:
void main() async {
  final secureStorage = SecureStorageService();

  // Store user data securely
  await secureStorage.storeUserData('123', 'John Doe', 'Admin');

  // Retrieve user data
  final userData = await secureStorage.getUserData();
  print('User ID: ${userData['id']}');
  print('User Name: ${userData['name']}');
  print('User Type: ${userData['type']}');

  // Clear user data
  await secureStorage.clearUserData();
}
