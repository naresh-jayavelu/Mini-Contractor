// import 'package:flutter/material.dart';
// import 'package:mini_contractor_2/reference/shoppingview.dart';

// class Nav extends StatefulWidget {
//   @override
//   _NavState createState() => _NavState();
// }

// class _NavState extends State<Nav> {
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = <Widget>[
//     ShoppingPage(),
//     Text('Messgaes Screen'),
//     Text('Profile Screen'),
//   ];

//   void _onItemTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mini Contractor'),
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTap,
//         selectedFontSize: 13.0,
//         unselectedFontSize: 13.0,
//       ),
//     );
//   }
// }
