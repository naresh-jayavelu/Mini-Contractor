// import 'package:flutter/material.dart';
// import 'package:mini_contractor_2/controllers/workOrderController.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
  
//   final WorkOrderController _workOrderController = WorkOrderController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage('lib/asset/download.jpeg'), // Replace with your image path
//               radius: 50, // Adjust according to your design
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Nandini s (PES1PG22CA123)',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Software Developer',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextButton.icon(
//               onPressed: () {
//                 _launch('tel:+1234567890');
//               },
//               icon: Icon(Icons.phone),
//               label: Text('Call'),
//             ),
//             SizedBox(height: 10),
//             TextButton.icon(
//               onPressed: () {
//                 _launch('mailto:naresh@example.com');
//               },
//               icon: Icon(Icons.email),
//               label: Text('Email'),
//             ),
//             SizedBox(height: 10),
//             TextButton.icon(
//               onPressed: () {
//                 _launch('https://example.com'); // Replace with your website URL
//               },
//               icon: Icon(Icons.web),
//               label: Text('Website'),
//             ),
//             SizedBox(height: 10),
//             TextButton.icon(
//               onPressed: () {
//                 _workOrderController.launchMaps('12.977439','77.570839',context);
//               },
//               icon: Icon(Icons.location_on),
//               label: Text('Address'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _launch(String url) async {
//     Uri uris = Uri.parse(url);
//     if (await canLaunchUrl(uris)) {
//       await launchUrl(uris);
//     } else {
//       throw 'Could not launch $uris';
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:mini_contractor_2/Nav.dart';
import 'package:mini_contractor_2/views/LoginPage.dart';
// import 'package:mini_contractor_2/views/Nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name',
      home: MyWidgetChange(value: 1),
    );
  }
}

class MyWidgetChange extends StatelessWidget {
  final int value;

  const MyWidgetChange({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == 1 ? LoginPage() : Navbar();
  }
}
