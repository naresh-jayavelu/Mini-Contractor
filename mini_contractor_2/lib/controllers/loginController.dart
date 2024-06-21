import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/chatController.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/controllers/messegeController.dart';
import 'package:mini_contractor_2/models/Address.dart';
import 'package:mini_contractor_2/models/User.dart';
import 'package:mini_contractor_2/views/LoginPage.dart';
import 'package:mini_contractor_2/views/message.dart';

import '../Nav.dart';

class LoginController {
  final SecureStorageService secureStorage = SecureStorageService();
  Future<void> login(String password, String email, BuildContext context) async {
  try {
    final response = await http.get(Uri.parse('$url/login/?email=$email&password=$password'));
    print('API Response: ${response.body}'); // Step 1: Print API response body

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('JSON Response: $jsonResponse'); // Step 2: Print decoded JSON response

      final apiResponse = APIResponse.fromJson(jsonResponse);
      print('API Response Object: $apiResponse'); // Step 3: Print APIResponse object

      if (apiResponse.success) {
  var userData = apiResponse.data;
  var userId = userData['userId'] ?? '';
  var userName = '${userData['firstName']} ${userData['lastName']}' ?? '';
  var userType = userData['roolId'] ?? '';

  await secureStorage.storeUserData(userId, userName, userType);
  Navigator.push(context, MaterialPageRoute(builder: (_) => Navbar(),));

      } else {
        print(apiResponse.data);
        showDialog(
          context: context,
          builder: (_) => StatusDialog(success: false, data: apiResponse.data),
        );
      }
    } else {
      print("HTTP Error: ${response.statusCode}");
      showDialog(
          context: context,
          builder: (_) => StatusDialog(success: false, data: response.statusCode),
        );
    }
  } catch (e) {
    print('Error: $e'); 
    showDialog(
          context: context,
          builder: (_) => StatusDialog(success: false, data: e),
        );
  }
}
   Future<List<Map<String, dynamic>>> fetchGenders() async {
    final response = await http.get(Uri.parse('$url/gender'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('Failed to load genders');
    }
  }
  void logout(BuildContext context) async {
    // LoginController.logout(context); // Call the logout function from the login controller
    // Clear the navigation stack and replace the current route with the LoginPage
    await secureStorage.clearUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
    );
  }

Future<Map<String, dynamic>?> initUserData() async {
  var secureStorage = SecureStorageService();
  var userData = await secureStorage.getUserData();
  print(userData);
  return userData.isNotEmpty ? userData : null; 
}

Future<String> getUserType() async {
  var userData = await initUserData();
  if (userData != null && userData['type'] == '915d98c6-9989-11ee-85ed-18473df2be1e') {
    return "Client";
  }
  return "Contractor";
}
Future<void> updateUserProfile(String field, String data, BuildContext context) async {
  try {
    var secureStorage = SecureStorageService();
    var userData = await secureStorage.getUserData();
    var userId = userData['id'];
    if (userId==null){
      userId=field;
      field='pass';
    }
    
    final response = await http.put(
      Uri.parse('$url/userupdate/$userId/$field/$data/'),
    );
    if (response.statusCode == 200) {
      // Successful update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
        ),
      );
    } else {
      messege("User not found", false, context);
    }
  } catch (e) {
    print('Error: $e');
    // Handle error gracefully
  }
}
Future<void> adduser(Address address,User user,BuildContext context) async {
var addressdata = address.toJson();
      
      final response2 = await http.post(
        Uri.parse('$url/address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(addressdata),
      );
var addressids='';
      if (response2.statusCode == 200) {
        print('Request sent successfully');
        // message("Request sent", true, context);
         var responseData = jsonDecode(response2.body);
         print('Response data: $responseData');
      addressids=responseData;
      } else {
        print('Failed to send request. Status code: ${response2.statusCode}');
        message("Failed to send address", false, context);
      }
      user.addressId=addressids;
      var userdata = user.toJson();
      print(userdata);
      final response = await http.post(
        Uri.parse('$url/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userdata),
      );

      if (response.statusCode == 200) {
        print('Request sent successfully');
        // message("Request sent", true, context);
         var responseData = jsonDecode(response.body);
         print('Response data: $responseData');
      } else {
        print('Failed to send request. Status code: ${response.statusCode}');
        message("Failed to send address", false, context);
      }
      message("User created successfully", false, context);
}
Future<void> message(String data,bool type, BuildContext context) async {
  Future.microtask(() {
    showDialog(
      context: context,
      builder: (_) => StatusDialog(success: type, data: data),
    );
  });
}
}


