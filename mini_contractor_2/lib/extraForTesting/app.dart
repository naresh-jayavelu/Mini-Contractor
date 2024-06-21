import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mini_contractor_2/reference/dummy.dart';
import 'package:mini_contractor_2/reference/shoppingview.dart';

class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Products', // Use label instead of title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search', // Use label instead of title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart', // Use label instead of title
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Dummy(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ShoppingPage(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Dummy(),
              );
            });
          default: return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Dummy(),
              );
            });
        }
      },
    );
  }
}
