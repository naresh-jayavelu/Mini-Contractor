import 'package:flutter/cupertino.dart';
import 'package:mini_contractor_2/constant.dart';
import 'package:mini_contractor_2/controllers/encrypteddata.dart';
import 'package:mini_contractor_2/controllers/loginController.dart';
import 'package:mini_contractor_2/views/Contractor/ProjectDetails.dart';
import 'package:mini_contractor_2/views/Contractor/ProjectListing.dart';
import 'package:mini_contractor_2/views/Home.dart';
import 'package:mini_contractor_2/views/messege.dart';
import 'package:mini_contractor_2/views/myProfile.dart';
import 'package:mini_contractor_2/views/request.dart';
import 'package:mini_contractor_2/views/reviewAndComplaints.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final LoginController loginController = LoginController();
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions = [];
  late String userType = '';
  late BuildContext _navContext;
  late Future<Map<String, dynamic>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = SecureStorageService().getUserData();
    _userDataFuture.then((userData) {
      setState(() {
        userType = userData['type'];
        _widgetOptions = _buildWidgetOptions();
      });
    });
  }

  List<Widget> _buildWidgetOptions() {
    if (userType == contractorCode) {
      return [
        ProjectListing(),
        Request(),
        ChatList(),
        Review(),
        UserProfilePage(),
      ];
    } else {
      return [
        // AddWorkOrder(),
        Home(),
        ChatList(),
        Request(),
        Review(),
        UserProfilePage(),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    loginController.logout(context);
    Navigator.of(_navContext).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        _navContext = context;
        return FutureBuilder<Map<String, dynamic>>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading user data'),
              );
            } else {
              return CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: userType != contractorCode
                      ? <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.home),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(IconData(0xe153, fontFamily: 'MaterialIcons')),
                            label: 'Chat',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon( IconData(0xe44f, fontFamily: 'MaterialIcons')),
                            label: 'Status',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(IconData(0xe537, fontFamily: 'MaterialIcons')),
                            label: 'Review',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.profile_circled),
                            label: 'Profile',
                          ),
                        ]
                      : <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.time),
                            label: 'Projects',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon( IconData(0xe44f, fontFamily: 'MaterialIcons')),
                            label: 'Status',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(IconData(0xe153, fontFamily: 'MaterialIcons')),
                            label: 'Chat',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(IconData(0xe537, fontFamily: 'MaterialIcons')),
                            label: 'Complaint',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.profile_circled),
                            label: 'Profile',
                          ),
                        ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
                tabBuilder: (BuildContext context, int index) {
                  return CupertinoTabView(
                    builder: (BuildContext context) {
                      return CupertinoPageScaffold(
                        navigationBar: CupertinoNavigationBar(
                          middle: Text('Mini Contractor'),
                          trailing: GestureDetector(
                            onTap: _logout,
                            child: Icon(
                              CupertinoIcons.square_arrow_right,
                              color: CupertinoColors.black,
                            ),
                          ),
                        ),
                        child: Navigator(
                          onGenerateRoute: (routeSettings) {
                            switch (routeSettings.name) {
                              case '/':
                                return CupertinoPageRoute(
                                  builder: (_) => _widgetOptions.elementAt(index),
                                  settings: routeSettings,
                                );
                              case '/details':
                                return CupertinoPageRoute(
                                  builder: (_) => ProjectDetails(),
                                  settings: routeSettings,
                                );
                              default:
                                return CupertinoPageRoute(
                                  builder: (_) => Container(),
                                );
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:mini_contractor_2/constant.dart';
// import 'package:mini_contractor_2/controllers/encrypteddata.dart';
// import 'package:mini_contractor_2/controllers/loginController.dart';
// import 'package:mini_contractor_2/views/AddWorkOrder.dart';
// import 'package:mini_contractor_2/views/Contractor/ProjectDetails.dart';
// import 'package:mini_contractor_2/views/Contractor/ProjectListing.dart';
// import 'package:mini_contractor_2/views/messege.dart';
// import 'package:mini_contractor_2/views/myProfile.dart';
// import 'package:mini_contractor_2/views/request.dart';
// import 'package:mini_contractor_2/views/reviewAndComplaints.dart';

// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }

// class _NavbarState extends State<Navbar> {
//   final LoginController loginController = LoginController();
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = [];
//   String userType = '';
//   late BuildContext _navContext; // Member variable to store the context

//   @override
//   void initState() {
//     super.initState();
//     _updateWidgetOptions();
//   }

//   void _updateWidgetOptions() async {
//           var secureStorage = SecureStorageService();
//       var userData = await secureStorage.getUserData();
//     setState(() {

//       print(userData['type']);
//       print(userData['type'] == contractorCode);
//       if (userData['type'] == contractorCode) {
//         _widgetOptions = [
//           ProjectListing(),
//           Request(),
//           ChatList(),
//           Review(),
//           UserProfilePage(),
//         ];
//       } else {
//         _widgetOptions = [
//           AddWorkOrder(),
//           ChatList(),
//           Request(),
//           Review(), 
//           UserProfilePage(),// Additional widget option for non-Contractor
//         ];
//       }
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
      
//     });
//   }

//   void _logout() async {
//     loginController.logout(context);
//     Navigator.of(_navContext).popUntil((route) => route.isFirst);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         // Store the context when available
//         _navContext = context;
//         return CupertinoTabScaffold(
//           tabBar: CupertinoTabBar(
//             items: userType == "Contractor"
//                 ? <BottomNavigationBarItem>[
//                     BottomNavigationBarItem(
//                       icon: Icon(CupertinoIcons.home),
//                       label: 'Home',
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(CupertinoIcons.time),
//                       label: 'New Work',
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(IconData(0xe153, fontFamily: 'MaterialIcons')),
//                       label: 'Chat',
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(CupertinoIcons.profile_circled), // Placeholder icon
//                       label: 'Profile', // Placeholder label
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(CupertinoIcons.profile_circled), // Placeholder icon
//                       label: 'Profile', // Placeholder label
//                     ),
//                   ]
//                 : <BottomNavigationBarItem>[
//                     BottomNavigationBarItem(
//                       icon: Icon(CupertinoIcons.time),
//                       label: 'Projects',
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon( IconData(0xe44f, fontFamily: 'MaterialIcons')),
//                       label: 'Status',
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(IconData(0xe153, fontFamily: 'MaterialIcons')),
//                       label: 'Chat',
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(IconData(0xe537, fontFamily: 'MaterialIcons')), // Placeholder icon
//                       label: 'Profile', // Placeholder label
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Icon(CupertinoIcons.profile_circled), // Placeholder icon
//                       label: 'Profile', // Placeholder label
//                     ),
//                   ],
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//           ),
//           tabBuilder: (BuildContext context, int index) {
//             if (_widgetOptions.isEmpty) {
//               return Center(
//                 child: CupertinoActivityIndicator(),
//               );
//             } else {
//               return CupertinoTabView(
//                 builder: (BuildContext context) {
//                   return CupertinoPageScaffold(
//                     navigationBar: CupertinoNavigationBar(
//                       middle: Text('Mini Contractor'),
//                       trailing: GestureDetector(
//                         onTap: _logout,
//                         child: Icon(
//                           CupertinoIcons.square_arrow_right,
//                           color: CupertinoColors.black,
//                         ),
//                       ),
//                     ),
//                     child: Navigator(
//                       onGenerateRoute: (routeSettings) {
//                         switch (routeSettings.name) {
//                           // Add routes here for each tab
//                           case '/':
//                             return CupertinoPageRoute(
//                               builder: (_) => _widgetOptions.elementAt(index),
//                               settings: routeSettings,
//                             );
//                           case '/details':
//                             return CupertinoPageRoute(
//                               builder: (_) => ProjectDetails(),
//                               settings: routeSettings,
//                             );
//                           // Add more routes as needed
//                           default:
//                             return CupertinoPageRoute(
//                               builder: (_) => Container(),
//                             );
//                         }
//                       },
//                     ),
//                     // Drawer is not available in Cupertino, you can use other navigation patterns like a side menu
//                   );
//                 },
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Name',
//       home: MyWidgetChange(value: 1),
//     );
//   }
// }

// class MyWidgetChange extends StatelessWidget {
//   final int value;

//   const MyWidgetChange({Key? key, required this.value}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return value == 1 ? LoginPage() : Navbar();
//   }
// }



// import 'package:flutter/cupertino.dart';
// import 'package:mini_contractor_2/constant.dart';
// import 'package:mini_contractor_2/controllers/loginController.dart';
// import 'package:mini_contractor_2/reference/shoppingview.dart';
// import 'package:mini_contractor_2/views/Chat.dart';
// import 'package:mini_contractor_2/views/Contractor/Profile.dart';
// import 'package:mini_contractor_2/views/Contractor/ProjectDetails.dart';
// import 'package:mini_contractor_2/views/Contractor/ProjectListing.dart';
// import 'package:mini_contractor_2/views/LoginPage.dart';

// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }

// class _NavbarState extends State<Navbar> {
  
//   final LoginController loginController = LoginController();
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = [];
//   String userType = '';

//   @override
//   void initState() {
//     super.initState();
//     _updateWidgetOptions();
//   }

//   void _updateWidgetOptions() async {
//     userType = await loginController.getUserType();
//     print('User Type: $userType');
//     setState(() {
//       if (userType == "Contractor") {
//         _widgetOptions = [
//           ProjectListing(),
//           ProjectListing(),
//           ProjectListing(),
//           Profile(), // Additional widget option for Contractor
//         ];
//       } else {
//         _widgetOptions = [
//           ProjectListing(),
//           ShoppingPage(),
//           ProjectDetails(),
//           Profile(), // Additional widget option for non-Contractor
//         ];
//       }
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_widgetOptions.isEmpty) {
//       return Center(child: CupertinoActivityIndicator()); // Show loading indicator until _widgetOptions is populated
//     }

//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         items: userType == "Contractor"
//             ? <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.time),
//                   label: 'New Work',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.chat_bubble),
//                   label: 'Chat',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.profile_circled), // Placeholder icon
//                   label: 'Profile', // Placeholder label
//                 ),
//               ]
//             : <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.chat_bubble),
//                   label: 'Chat',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.time),
//                   label: 'Work',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.profile_circled), // Placeholder icon
//                   label: 'Profile', // Placeholder label
//                 ),
//               ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//       tabBuilder: (BuildContext context, int index) {
//         return CupertinoTabView(
//           builder: (BuildContext context) {
//             return CupertinoPageScaffold(
//               navigationBar: CupertinoNavigationBar(
//                 middle: Text('Mini Contractor'),
//               ),
//               child: _widgetOptions.elementAt(index),
//               // Drawer is not available in Cupertino, you can use other navigation patterns like a side menu
//             );
//           },
//         );
//       },
//     );
//   }

//   void logout(BuildContext context) async {
//     loginController.logout(context); // Call the logout function from the login controller
//     // Close the navigation bar
//     Navigator.of(context).popUntil((route) => route.isFirst);
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:mini_contractor_2/constant.dart';
// import 'package:mini_contractor_2/controllers/loginController.dart';
// import 'package:mini_contractor_2/reference/shoppingview.dart';
// import 'package:mini_contractor_2/views/Chat.dart';
// import 'package:mini_contractor_2/views/Contractor/ProjectDetails.dart';
// import 'package:mini_contractor_2/views/Contractor/ProjectListing.dart';
// import 'package:mini_contractor_2/views/LoginPage.dart';

// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }

// class _NavbarState extends State<Navbar> {
//   final LoginController loginController = LoginController();
//   int _selectedIndex = 0;
//   PageController _pageController = PageController();
//   List<Widget> _widgetOptions = [];
//   String userType = '';

//   @override
//   void initState() {
//     super.initState();
//     _updateWidgetOptions();
//   }

//   void _updateWidgetOptions() async {
//     userType = await loginController.getUserType();
//     print('User Type: $userType');
//     setState(() {
//       if (userType == "Contractor") {
//         _widgetOptions = [
//           ProjectListing(),
//           ProjectListing(),
//           ProjectListing(),
//         ];
//       } else {
//         _widgetOptions = [
//           ProjectListing(),
//           ShoppingPage(),
//           ProjectDetails(),
//         ];
//       }
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _pageController.animateToPage(
//         index,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.ease,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mini Contractor'),
//       ),
//       drawer: Drawer(
//         child: FutureBuilder<Map<String, dynamic>?>(
//           future: loginController.initUserData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final userData = snapshot.data;
//               if (userData != null) {
//                 return ListView(
//                   padding: EdgeInsets.zero,
//                   children: <Widget>[
//                     DrawerHeader(
//                       decoration: BoxDecoration(
//                         color: customColor,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'User ID: ${userData['id']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'User Name: ${userData['name']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'User Type: ${userData['type']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ListTile(
//                       title: Text('Logout'),
//                       onTap: () {
//                         loginController.logout(context);
//                       },
//                     ),
//                   ],
//                 );
//               } else {
//                 return Text('No user data found');
//               }
//             }
//           },
//         ),
//       ),
//       body: PageView(
//         controller: _pageController,
//         children: _widgetOptions,
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: userType == "Contractor"
//             ? <BottomNavigationBarItem>[
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.work_history_outlined),
//                   label: 'New Work',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.chat_outlined),
//                   label: 'Chat',
//                 ),
//               ]
//             : <BottomNavigationBarItem>[
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.chat_outlined),
//                   label: 'Chat',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.work_history_outlined),
//                   label: 'Work',
//                 ),
//               ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mini Contractor',
//       theme: ThemeData(
//         primaryColor: customColor, // You can also set primarySwatch if needed
//       ),
//       home: LoginPage(), // Assuming LoginPage is the initial screen
//     );
//   }
// }

// class Navbar extends StatefulWidget {
//   @override
//   _NavbarState createState() => _NavbarState();
// }

// class _NavbarState extends State<Navbar> {
//   final LoginController loginController = LoginController();
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = [];
//   String userType = '';

//   @override
//   void initState() {
//     super.initState();
//     _updateWidgetOptions();
//   }

//   void _updateWidgetOptions() async {
//     userType = await loginController.getUserType();
//     print('User Type: $userType');
//     setState(() {
//       if (userType == "Contractor") {
//         _widgetOptions = [
//           ProjectListing(),
//           ProjectListing(),
//           ProjectListing(),
//         ];
//       } else {
//         _widgetOptions = [
//           ProjectListing(),
//           ShoppingPage(),
//           ProjectDetails(),
//         ];
//       }
//     });
//   }

//   void _onItemTapped(int index) {
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
//       drawer: Drawer(
//         child: FutureBuilder<Map<String, dynamic>?>(
//           future: loginController.initUserData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final userData = snapshot.data;
//               if (userData != null) {
//                 return ListView(
//                   padding: EdgeInsets.zero,
//                   children: <Widget>[
//                     DrawerHeader(
//                       decoration: BoxDecoration(
//                         color: customColor,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'User ID: ${userData['id']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'User Name: ${userData['name']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             'User Type: ${userData['type']}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ListTile(
//                       title: Text('Logout'),
//                       onTap: () {
//                         loginController.logout(context);
//                       },
//                     ),
//                   ],
//                 );
//               } else {
//                 return Text('No user data found');
//               }
//             }
//           },
//         ),
//       ),
//       body: _selectedIndex >= 0 && _selectedIndex < _widgetOptions.length
//           ? _widgetOptions[_selectedIndex]
//           : SizedBox(), // or any other widget to display when index is out of bounds
//       bottomNavigationBar: BottomNavigationBar(
//         items: userType == "Contractor"
//             ? <BottomNavigationBarItem>[
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.work_history_outlined),
//                   label: 'New Work',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.chat_outlined),
//                   label: 'chat',
//                 ),
//               ]
//             : <BottomNavigationBarItem>[
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.chat_outlined),
//                   label: 'Chat',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(Icons.work_history_outlined),
//                   label: 'Work',
//                 ),
                
//               ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Home Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Search Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Cart Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }




// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mini_contractor_2/reference/shoppingview.dart';


// class Navbar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.shopping_cart),
//             label: 'Cart',
//           ),
//         ],
//       ),
//       tabBuilder: (context, index) {
//         switch (index) {
//           case 0:
//             return CupertinoTabView(builder: (context) {
//               return CupertinoPageScaffold(
//                 navigationBar: CupertinoNavigationBar(
//                   middle: Text('Home'),
//                 ),
//                 child: ShoppingPage(),
//               );
//             });
//           case 1:
//             return CupertinoTabView(builder: (context) {
//               return CupertinoPageScaffold(
//                 navigationBar: CupertinoNavigationBar(
//                   middle: Text('Search'),
//                 ),
//                 child: SearchScreen(),
//               );
//             });
//           case 2:
//             return CupertinoTabView(builder: (context) {
//               return CupertinoPageScaffold(
//                 navigationBar: CupertinoNavigationBar(
//                   middle: Text('Cart'),
//                 ),
//                 child: CartScreen(),
//               );
//             });
//           default:
//             return CupertinoTabView(builder: (context) {
//               return CupertinoPageScaffold(
//                 navigationBar: CupertinoNavigationBar(
//                   middle: Text('Home'),
//                 ),
//                 child: HomeScreen(),
//               );
//             });
//         }
//       },
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Home Screen',
//             style: TextStyle(fontSize: 24),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               print("Button pressed"); // Debug statement
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ShoppingPage()),
//               );
//             },
//             child: Text("Press"),
//           ),
//           Spacer(), // Add Spacer widget to push the logout button to the bottom
          
//         ],
//       ),
//     );
//   }
// }

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Search Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Cart Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
