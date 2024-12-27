import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_example/providers/auth_provider.dart";
import "package:flutter_example/screens/basket.dart";
import "package:flutter_example/screens/category.dart";
import "package:flutter_example/screens/home.dart";
import "package:flutter_example/screens/login.dart";
import "package:flutter_example/screens/logs.dart";
import "package:flutter_example/widgets/common/nav_bar.dart";
import "package:location/location.dart";
import "package:provider/provider.dart";

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();

}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  Location location = Location();
  late LocationData _locationData;


  Future<bool> requestPermission() async {
    final permission = await location.requestPermission();
    print("Permission: $permission");
    return permission == PermissionStatus.granted;
  }

  Future _firebaseForegroundMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Got a message whilst in the foreground!");
      print("Message data: ${message.data}");
      // data stringify
      if (message.notification != null) {
        print("Message also contained a notification: ${message.notification}");
      }
      if (message.notification != null) {
        print("Message also contained a notification: ${message.notification}");
      }
    });
  }

  Future _getLocation() async {
    try {
      print("tesst");
      _locationData = await location.getLocation();
      print(PermissionStatus.granted);
      print("Location: $_locationData");
    } catch (e) {
      print("Error: $e");
    }
  }
   
  static final List<Widget> _pages = <Widget> [
    HomeScreen(),
    Category(),
    Basket(),
    LogScreen()    
  ];



  @override
  void initState() {
    super.initState(); 
    requestPermission();
    _getLocation();
    location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("Location: ${currentLocation.latitude} ${currentLocation.longitude}");
      // Use current location
    });
  }


 @override
  void didUpdateWidget(covariant MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("MainLayout widget updated!");
    // Eğer güncellenen widget üzerinde bir işlem yapmak istiyorsanız:
    if (_currentIndex != 0) {
      print("Current index has changed: $_currentIndex");
    }
  }


  void _onTapFnc(int index) {
    print(index);
    if (index == 4) {
      Provider.of<AuthProvider>(context, listen: false).clearToken();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen())
      );
      return;
    }
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