import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import '../dashboard/dashboard.dart';
import '../menu/menu.dart';
import '../settings/settings.dart';
import '../dashboard/navbar.dart';
import 'custom_appbar.dart';


import 'package:fluttertoast/fluttertoast.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {

  int _selectedIndex = 0;


  static const List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    Menu(),
    Settings(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: CustomAppBar(
            imageUrl: 'assets/images/icon.png',
            onDrawerIconTap: () {
              // Open the drawer
            },
          ),
          drawer: NavBar(),
          backgroundColor: Colors.transparent,
          body: WillPopScope(
            onWillPop: () async {
              final now = DateTime.now();
              final maxDuration = Duration(seconds: 2);
              final isWarningNeeded =
                  lastPressed == null || now.difference(lastPressed!) > maxDuration;
              if (isWarningNeeded) {
                lastPressed = DateTime.now();
                Fluttertoast.showToast(
                  msg: "Press back again to exit",
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                );
                return false;
              }
              return true;
            },
            child: _widgetOptions[_selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
    );
  }

}
