import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mini_contractor_2/controllers/sessionController.dart';
import 'package:mini_contractor_2/controllers/testcontroller.dart';
import 'package:mockito/mockito.dart';

class MockContext extends Mock implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('SessionController Tests', () {
    test('Test setSession method', () {
      final controller = SessionController();
      const String id = 'PES!PG22CA124';
      const String name = 'Naresh J';
      const String type = 'Client';

      controller.setSession(id, name, type);
      print("SessionController Tests");
      print("Test setSession method");
      expect(controller.userId.value, id);
      expect(controller.userName.value, name);
      expect(controller.userType.value, type);
    });

    test('Test clearSession method', () {
      final controller = SessionController();
      controller.setSession('PG22CA124', 'Naresh J', 'Client');
      controller.clearSession();
      print("SessionController Tests");
      print("Test clearSession method");
      expect(controller.userId.value, '');
      expect(controller.userName.value, '');
      expect(controller.userType.value, '');
    });
  });

   group('TestchatController Tests', () {
    test('Test sendMessage function success', () async {
      final mockResponse = '{"status": "success"}';
      final mockClient = MockClient((request) async {
        return http.Response(mockResponse, 200);
      });

      final controller = TestchatController();
      final context = MockContext();

      await controller.sendMessage(
        "Test message", 
        "91008c5f-6714-4d00-9658-5cb5f77c7876", 
        "91008c5f-6714-4d00-9658-5cb5f77c7876", 
        "ef5fb81a-1728-474b-8f00-0df19b0731e0"
        );
      
      print("SendMessege Controller Tests");
      print("Test sendMessage function success");
    });

    test('Test sendMessage function error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Error sending message', 500);
      });

      final controller = TestchatController();
      final context = MockContext();

      await controller.sendMessage("", "", "", "");
      print("SendMessege Controller Tests");
      print("Test sendMessage function error");
    });

    test('Test login function ', () async {
      final controller = TestchatController();

      await controller.login("1111", "snandini143@gmail.com");

      print("Login Controller Tests");
      print("Test login function");
    });

    test('Test login method with invalid credentials', () async {
      final controller = TestchatController();
      await controller.login("11110", "snandini143@gmail.com");

      print("Login Controller Tests");
      print("Test login method with invalid credentials");
    });
  });
}