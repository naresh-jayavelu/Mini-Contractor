import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mini_contractor_2/models/Address.dart';

class PositionController {
  Position? value;

  void updatePosition(Position newPosition) {
    value = newPosition;
  }
}

class AddAddress extends StatefulWidget {
  final ValueChanged<Address?> onSubmit;

  const AddAddress({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _addressline1Controller = TextEditingController();
  TextEditingController _addressline2Controller = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;
  PositionController positionController = PositionController();
  double? _latitude;
  double? _longitude;
  String pinCodeDetails = '';
  String locDetails = '';

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _pincodeController.addListener(() {
      if (_pincodeController.text.length == 6) {
        getDataFromPinCode(_pincodeController.text);

        setState(() {
          _selectedCountry = null;
          _selectedState = null;
          _selectedCity = null;
        });
      }
    });
  }

  Future<void> _determinePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
      print('Latitude: $_latitude, Longitude: $_longitude');
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
      return;
    }
  }

  Future<void> getDataFromPinCode(String pinCode) async {
    final url = "http://www.postalpincode.in/api/pincode/$pinCode";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Status'] == 'Error') {
          // Show a snackbar if the PIN code is not valid
          showSnackbar(context, "Pin Code is not valid. ");
          setState(() {
            pinCodeDetails = 'Pin code is not valid.';
          });
        } else {
          // Parse and display details if the PIN code is valid
          final postOfficeArray = jsonResponse['PostOffice'] as List;
          final obj = postOfficeArray[0];

          final district = obj['District'];
          final state = obj['State'];
          final country = obj['Country'];

          setState(() {
            pinCodeDetails = '$district, $state, $country';
            _selectedCountry = country;
            _selectedState = state;
            _selectedCity = district;
          });
        }
      } else {
        // Show a snackbar if there is an issue fetching data
        showSnackbar(context, "Failed to fetch data. Please try again");
        setState(() {
          pinCodeDetails = 'Failed to fetch data. Please try again.';
        });
      }
    } catch (e) {
      // Show a snackbar if an error occurs during the API call
      showSnackbar(context, "Error Occurred. Please try again");
      setState(() {
        pinCodeDetails = 'Error occurred. Please try again.';
      });
    }
  }

  // Function to display a snackbar with a specified message
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _addressline1Controller,
                decoration: InputDecoration(labelText: 'Address Line 1'),
              ),
              TextFormField(
                controller: _addressline2Controller,
                decoration: InputDecoration(labelText: 'Address Line 2'),
              ),
              TextFormField(
                controller: _pincodeController,
                decoration: InputDecoration(labelText: 'Pincode'),
              ),
              SizedBox(height: 20),
              Text(
                pinCodeDetails,
                style: TextStyle(color: Colors.black54),
              ),
              // SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Address newAddress = Address(
                    addressLine1: _addressline1Controller.text,
                    addressLine2: _addressline2Controller.text,
                    pincode: _pincodeController.text,
                    country: _selectedCountry ?? '',
                    state: _selectedState ?? '',
                    city: _selectedCity ?? '',
                    latitude: '',
                    longitude: '',
                  );
                  if (_addressline1Controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please addressline1'),
                      ),
                    );
                    return;
                  }
                  if (_pincodeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please pincode'),
                      ),
                    );
                    return;
                  }
                  Navigator.pop(context, newAddress);
                },
                child: Text('Add Address'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Divider(),
                  const Text("or"),
                  const Divider(),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                locDetails,
                style: TextStyle(color: Colors.black54),
              ),
              ElevatedButton(
                onPressed: () {
                  Address newAddress = Address(
                    addressLine1: '',
                    addressLine2: '',
                    pincode: '',
                    country: '',
                    state: '',
                    city: '',
                    latitude: _latitude?.toString() ?? '',
                    longitude: _longitude?.toString() ?? '',
                  );
                  Navigator.pop(context, newAddress);
                },
                child: Text('Add Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mini_contractor_2/models/Address.dart';

// class PositionController {
//   Position? value;

//   void updatePosition(Position newPosition) {
//     value = newPosition;
//   }
// }

// class AddAddress extends StatefulWidget {
//   final ValueChanged<Address?> onSubmit;

//   const AddAddress({Key? key, required this.onSubmit}) : super(key: key);

//   @override
//   _AddAddressState createState() => _AddAddressState();
// }

// class _AddAddressState extends State<AddAddress> {
//   TextEditingController _addressline1Controller = TextEditingController();
//   TextEditingController _addressline2Controller = TextEditingController();
//   TextEditingController _pincodeController = TextEditingController();
//   String? _selectedCountry;
//   String? _selectedState;
//   String? _selectedCity;
//   PositionController positionController = PositionController();
//   double? _latitude;
//   double? _longitude;

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }

//   Future<Position> _determinePosition() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition();
//       setState(() {
//         _latitude = position.latitude;
//         _longitude = position.longitude;
//       });
//       print('Latitude: $_latitude, Longitude: $_longitude');
//       return position;
//     } catch (e) {
//       print("Error getting location: $e");
//       throw e;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Address'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: _addressline1Controller,
//               decoration: InputDecoration(labelText: 'Address Line 1'),
//             ),
//             TextFormField(
//               controller: _addressline2Controller,
//               decoration: InputDecoration(labelText: 'Address Line 2'),
//             ),
//             TextFormField(
//               controller: _pincodeController,
//               decoration: InputDecoration(labelText: 'Pincode'),
//             ),
//             SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: _selectedCountry,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCountry = value;
//                 });
//               },
//               items: <String>['Country 1', 'Country 2', 'Country 3']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: InputDecoration(labelText: 'Country'),
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedState,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedState = value;
//                 });
//               },
//               items: <String>['State 1', 'State 2', 'State 3']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: InputDecoration(labelText: 'State'),
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedCity,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCity = value;
//                 });
//               },
//               items: <String>['City 1', 'City 2', 'City 3']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: InputDecoration(labelText: 'City'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Address newAddress = Address(
//                   addressLine1: _addressline1Controller.text,
//                   addressLine2: _addressline2Controller.text,
//                   pincode: _pincodeController.text,
//                   country: _selectedCountry ?? '',
//                   state: _selectedState ?? '',
//                   city: _selectedCity ?? '',
//                   latitude: '',
//                   longitude:'',
//                 );
//                 Navigator.pop(context, newAddress);
//               },
//               child: Text('Add Address'),
//             ),
//             const SizedBox(height: 20),
//             const Divider(),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Address newAddress = Address(
//                   addressLine1:'',
//                   addressLine2: '',
//                   pincode: '',
//                   country:  '',
//                   state:   '',
//                   city: '',
//                   latitude: _latitude?.toString() ?? '',
//                   longitude:_longitude?.toString() ?? '',
//                 );
//                 Navigator.pop(context, newAddress);
//               },
//               child: Text('Add Address'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mini_contractor_2/models/Address.dart';

// bool locCheck = false;

// class AddAddress extends StatefulWidget {
//   final ValueChanged<Address?> onSubmit;

//   const AddAddress({Key? key, required this.onSubmit}) : super(key: key);

//   @override
//   _AddAddressState createState() => _AddAddressState();
// }
// class PositionController {
//   Position? value;

//   void updatePosition(Position newPosition) {
//     value = newPosition;
//   }
// }

// class _AddAddressState extends State<AddAddress> {
//   TextEditingController _addressline1Controller = TextEditingController();
//   TextEditingController _addressline2Controller = TextEditingController();
//   TextEditingController _pincodeController = TextEditingController();
//   String? _selectedCountry;
//   String? _selectedState;
//   String? _selectedCity;
//   PositionController positionController = PositionController();
// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   print("erfewre");

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     print("erfewre");
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     print("erfewre");
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   Position position = await Geolocator.getCurrentPosition();
//   print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
//   locCheck = true;
//   @override
//   void initState() {
//     locCheck = true;
//     // _determinePosition();
//   }

//   return await Geolocator.getCurrentPosition();
// }
// @override
//   void initState() {
//     // locCheck = true;
//     _determinePosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Address'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: _addressline1Controller,
//               decoration: InputDecoration(labelText: 'Address Line 1'),
//             ),
//             TextFormField(
//               controller: _addressline2Controller,
//               decoration: InputDecoration(labelText: 'Address Line 2'),
//             ),
//             TextFormField(
//               controller: _pincodeController,
//               decoration: InputDecoration(labelText: 'Pincode'),
//             ),
//             SizedBox(height: 20),
//             // Added: DropdownButtonFormField for selecting country
//             DropdownButtonFormField<String>(
//               value: _selectedCountry,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCountry = value;
//                 });
//               },
//               items: <String>['Country 1', 'Country 2', 'Country 3']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: InputDecoration(labelText: 'Country'),
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedState,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedState = value;
//                 });
//               },
//               items: <String>['State 1', 'State 2', 'State 3']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: InputDecoration(labelText: 'State'),
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedCity,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCity = value;
//                 });
//               },
//               items: <String>['City 1', 'City 2', 'City 3']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: InputDecoration(labelText: 'City'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//   onPressed: () {
//     // Create the address object
//     Address newAddress = Address(
//       addressLine1: _addressline1Controller.text,
//       addressLine2: _addressline2Controller.text,
//       pincode: _pincodeController.text,
//       country: _selectedCountry ?? '',
//       state: _selectedState ?? '',
//       city: _selectedCity ?? '',
//       latitude: '',
//       longitude: '',
//     );
//     // Pass the address object back to the parent widget
//     Navigator.pop(context, newAddress);
//   },
//   child: Text('Add Address'),
// ),
// ElevatedButton.icon(
//                       onPressed: () async {
//                         Position position = await _determinePosition();
//                         positionController.updatePosition(position);
//                         // Now you can access the position using positionController.value
//                         print(
//                             'Latitude: ${positionController.value?.latitude}, Longitude: ${positionController.value?.longitude}');
//                       },
//                       icon: const Icon(Icons.maps_ugc_rounded),
//                       label: const Text("Location"),
//                     ),
//           ],
//         ),
//       ),
//     );
//   }
// }
