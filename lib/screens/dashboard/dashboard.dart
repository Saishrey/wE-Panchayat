import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dashboard/griddashboard.dart';
import '../dashboard/searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  DashBoardState createState() => new DashBoardState();
}

class DashBoardState extends State<DashBoard> {

  final List<String> _carouselImages = [
    'assets/carousel_images/carousel_img_0.jpeg',
    'assets/carousel_images/carousel_img_1.jpg',
    'assets/carousel_images/carousel_img_2.jpg',
    'assets/carousel_images/carousel_img_3.jpeg',
  ];

  // final List<Widget> _carouselImages = [
  //   Image.asset('assets/carousel_images/carousel_img_0.jpeg'),
  //   Image.asset('assets/carousel_images/carousel_img_1.jpg'),
  //   Image.asset('assets/carousel_images/carousel_img_2.jpg'),
  //   Image.asset('assets/carousel_images/carousel_img_3.jpeg'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/images/icon.png',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 0),
                    child: Text(
                      "VP Davorlim",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xff21205b),
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              IconButton(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(0),
                icon: Image.asset(
                  "assets/images/user.png",
                  width: 75,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SearchBar(),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Panchayat services",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Color(0xff21205b),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GridDashboard(),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Featured updates",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Color(0xff21205b),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        CarouselSlider(
          options: CarouselOptions(
            // height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 20/7,
            viewportFraction: 0.7,
          ),
          items: _carouselImages.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}