import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/controllers/loginController.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Map<String, dynamic> userProfile = {};
  LoginController _loginController=LoginController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      var secureStorage = SecureStorageService();
      var userData = await secureStorage.getUserData();
      var userid = userData['id'];
      final response = await http.get(Uri.parse('$url/user/$userid/'));
      if (response.statusCode == 200) {
        setState(() {
          userProfile = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error gracefully
    }
  }
void editPhoneNumber() {
  TextEditingController phoneNumberController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Phone Number'),
        content: TextField(
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(hintText: 'Enter new phone number'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String newPhoneNumber = phoneNumberController.text.trim();
              if (newPhoneNumber.isNotEmpty) {
                await _loginController.updateUserProfile('phone', newPhoneNumber,context);
                Navigator.of(context).pop();
                // Refresh user profile
                fetchUserProfile();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter a valid phone number'),
                  ),
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

void editEmail() {
  TextEditingController emailController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Email'),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Enter new email address'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String newEmail = emailController.text.trim();
              if (newEmail.isNotEmpty && newEmail.contains('@')) {
                await _loginController.updateUserProfile('email', newEmail, context);
                Navigator.of(context).pop();
                // Refresh user profile
                fetchUserProfile();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter a valid email address'),
                  ),
                );
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: userProfile.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                      '${userProfile['firstName'][0]}${userProfile['lastName'][0]}'.toUpperCase(),
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Name: ${userProfile['firstName']} ${userProfile['lastName']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Email: ${userProfile['email'] ?? 'N/A'}'),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: editEmail,
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Phone: ${userProfile['phone'] ?? 'N/A'}'),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: editPhoneNumber,
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Date of Birth: ${userProfile['dob'] ?? 'N/A'}'),
                  SizedBox(height: 10),
                  Text('Gender: ${userProfile['genderId']['genderName'] ?? 'N/A'}'),
                  SizedBox(height: 10),
                  Text('Address:'),
                  SizedBox(height: 5),
                  Text(
                    '${userProfile['addressId']['addressLine1'] ?? 'N/A'}, '
                    '${userProfile['addressId']['addressLine2'] ?? 'N/A'}, '
                    '${userProfile['addressId']['city'] ?? 'N/A'}, '
                    '${userProfile['addressId']['state'] ?? 'N/A'}, '
                    '${userProfile['addressId']['country'] ?? 'N/A'}, '
                    '${userProfile['addressId']['pincode'] ?? 'N/A'}',
                  ),
                ],
              ),
            ),
    );
  }
}
