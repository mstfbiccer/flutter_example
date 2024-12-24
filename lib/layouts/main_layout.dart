import "package:flutter/material.dart";
import "package:flutter_example/screens/basket.dart";
import "package:flutter_example/screens/category.dart";
import "package:flutter_example/screens/home.dart";
import "package:flutter_example/widgets/common/nav_bar.dart";

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();

}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  static const List<Widget> _pages = <Widget> [
    HomeScreen(),
    Category(),
    Basket()
  ];

  void _onTapFnc(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavBar(currentIndex: _currentIndex, onTap: _onTapFnc)
    );
  }
}   

