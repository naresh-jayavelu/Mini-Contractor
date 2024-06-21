import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_contractor_2/Nav.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/controllers/loginController.dart';
import 'package:mini_contractor_2/views/forgetPassword.dart';
import 'package:mini_contractor_2/views/register.dart'; 

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  SecureStorageService secureStorage = SecureStorageService(); // Initialize secureStorage object

  @override
  void initState() {
    super.initState();
    checkUserData();
  }

  Future<void> checkUserData() async {
    final userData = await secureStorage.getUserData();
    if (userData != null && userData.isNotEmpty) {
      print(userData);
      print("nfhdb");
      if (userData['id']!=null){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Navbar()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('lib/asset/images/login_page.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => ForgetPassword()));
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    await loginController.login(email, password, context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));
                },
                child: const Text(
                  'New User? Create Account',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
