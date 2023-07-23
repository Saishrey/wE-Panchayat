import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_panchayat_dev/models/login_request_model.dart';
import 'package:we_panchayat_dev/models/login_response_model.dart';
import '../../constants.dart';
import '../../services/auth_api_service.dart';
import '../../services/shared_service.dart';
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

  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        SearchBar(),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        GridDashboard(),
        const SizedBox(
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
        const SizedBox(
          height: 10,
        ),
        CarouselSlider(
          options: CarouselOptions(
            // height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 20 / 9,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _carouselImages.map((img) {
              int? index = _carouselImages
                  .indexOf(img);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index
                      ? ColorConstants.darkBlueThemeColor
                      : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

