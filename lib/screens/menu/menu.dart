import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard/griddashboard.dart';
import '../dashboard/searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';




class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  MenuState createState() => new MenuState();
}

class MenuState extends State<Menu> {

  final List<Widget> _items = [
    Image.asset('assets/carousel_images/carousel_img_0.jpeg'),
    Image.asset('assets/carousel_images/carousel_img_1.jpg'),
    Image.asset('assets/carousel_images/carousel_img_2.jpg'),
    Image.asset('assets/carousel_images/carousel_img_3.jpeg'),
  ];



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        Text('Menu'),
      ],
    );
  }
}