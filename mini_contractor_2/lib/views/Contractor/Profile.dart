import 'package:flutter/material.dart';
import 'package:mini_contractor_2/controllers/loginController.dart'; // Import the login controller

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void logout(BuildContext context) async {
      // Call the logout function from the LoginController
      LoginController().logout(context);
    }

    return Scaffold(
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 24),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 70.0,right: 2.0), // Add padding to move the FAB slightly above the bottom
      //   child: FloatingActionButton(
      //     onPressed: () => logout(context), // Call the logout function when the button is pressed
      //     child: const Icon(Icons.logout),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}
