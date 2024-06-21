import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mini_contractor_2/controllers/loginController.dart';
import 'package:mini_contractor_2/models/Address.dart';
import 'package:mini_contractor_2/models/User.dart';

class Register extends StatefulWidget {
  final bool isEdit; // Indicates whether the form is for editing existing user

  Register({Key? key, this.isEdit = false}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  LoginController _loginController=LoginController();

  double? _latitude;
  double? _longitude;
  String? locDetails;

  List<Map<String, dynamic>> genders = [];
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _loadGenders(); // Call method to load genders
    _getLocationDetails();
    pincodeController.addListener(() {
      if (pincodeController.text.length == 6) {
        _getAddressFromPincode(pincodeController.text);
      }
    });
  }

  Future<void> _loadGenders() async {
    try {
      List<Map<String, dynamic>> genderList = await _loginController.fetchGenders();
      setState(() {
        genders = genderList;
      });
    } catch (e) {
      print('Error loading genders: $e');
    }
  }

  Future<void> _getLocationDetails() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
      List<Placemark> placemarks =
          await placemarkFromCoordinates(_latitude!, _longitude!);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          locDetails =
              'Address: ${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
        });
      } else {
        setState(() {
          locDetails = 'No address found for the provided coordinates.';
        });
      }
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        locDetails = "Error getting location: $e";
      });
    }
  }

  Future<void> _getAddressFromPincode(String pincode) async {
    try {
      List<Location> locations = await locationFromAddress(pincode);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        List<Placemark> placemarks =
            await placemarkFromCoordinates(location.latitude, location.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          setState(() {
            addressLine1Controller.text = placemark.street ?? '';
            cityController.text = placemark.locality ?? '';
            stateController.text = placemark.administrativeArea ?? '';
            countryController.text = placemark.country ?? '';
          });
        }
      }
    } catch (e) {
      print("Error getting address from pincode: $e");
    }
  }

  void _submitForm() {
    if (_fieldsAreEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all the required fields.'),
        ),
      );
    } else if (_passwordsDoNotMatch()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password and Confirm Password do not match.'),
        ),
      );
    } else {
       Address address = Address(
        addressLine1: addressLine1Controller.text,
        addressLine2: addressLine2Controller.text,
        pincode: pincodeController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
      );

      // Create User object
      User user = User(// Provide appropriate user ID
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        dob: dobController.text,
        phone: phoneController.text,
        status: '', // Provide appropriate status
        isActive: true, // Provide appropriate value
        roleId: '', // Provide appropriate role ID
        addressId: '', // Provide appropriate address ID
        genderId: selectedGender!, // Provide appropriate gender ID
      );

      // Call the adduser function from LoginController
      _loginController.adduser(address, user,context);

    }
  }

  bool _fieldsAreEmpty() {
    return emailController.text.isEmpty ||
        (!emailController.text.contains('@') || !emailController.text.contains('.')) ||
        firstNameController.text.length<3 ||
        lastNameController.text.isEmpty ||
        genders.isEmpty||
        passwordController.text.length<4 ||
        dobController.text.isEmpty ||
        phoneController.text.isEmpty ||
        phoneController.text.length != 10 ||
        addressLine1Controller.text.isEmpty ||
        pincodeController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        countryController.text.isEmpty;
  }

  bool _passwordsDoNotMatch() {
    return passwordController.text != confirmPasswordController.text;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002, 1, 10),
      firstDate: DateTime(2001),
      lastDate: DateTime(DateTime.now().year - 20),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dobController.text = picked.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit User' : 'Register'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController, // Add confirm password controller
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            TextField(
              controller: dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
              onTap: () => _selectDate(context),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Text('Gender', style: TextStyle(fontSize: 18)),
            DropdownButtonFormField<String>(
              value: selectedGender,
              onChanged: (newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
              items: genders.map((gender) {
                return DropdownMenuItem<String>(
                  value: gender['genderId'],
                  child: Text(gender['genderName']),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Select Gender'),
            ),
            SizedBox(height: 20),
            Text('Address Details', style: TextStyle(fontSize: 18)),
            TextField(
              controller: addressLine1Controller,
              decoration: InputDecoration(labelText: 'Address Line 1'),
            ),
            TextField(
              controller: addressLine2Controller,
              decoration: InputDecoration(labelText: 'Address Line 2'),
            ),
            TextField(
              controller: pincodeController,
              decoration: InputDecoration(labelText: 'Pincode'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            TextField(
              controller: countryController,
              decoration: InputDecoration(labelText: 'Country'),
            ),
            SizedBox(height: 20),
            Text(locDetails ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(widget.isEdit ? 'Update' : 'Register'),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
