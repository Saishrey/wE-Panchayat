import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Trade License\n  & Signboard",
      img: "assets/images/trade_license.png",
      backgroundColor: 0xffEEF7FE,
      textColor: 0xff415EB6);

  Items item2 = new Items(
      title: "Birth & Death\n   Certificate",
      img: "assets/images/birth_&_death.png",
      backgroundColor: 0xffFFFBEC,
      textColor: 0xffFFB110);

  Items item3 = new Items(
      title: "Income Certificate",
      img: "assets/images/income.png",
      backgroundColor: 0xffFEEEEE,
      textColor: 0xffF45656);

  Items item4 = new Items(
      title: "Pay House Tax",
      img: "assets/images/house_tax.png",
      backgroundColor: 0xffF0FFFF,
      textColor: 0xff23B0B0);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
    ];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.3,
          padding: EdgeInsets.only(left: 24, right: 24),
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                color: Color(data.backgroundColor),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA7A9AF),
                    blurRadius: 5.0,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Color(data.textColor),
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String img;
  var backgroundColor;
  var textColor;

  Items({
    required this.title,
    required this.img,
    required this.backgroundColor,
    required this.textColor,
  });
}