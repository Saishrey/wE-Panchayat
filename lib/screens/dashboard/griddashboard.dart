import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_panchayat_dev/screens/birth&death_certificate/birth_and_death_certificate.dart';
import 'package:we_panchayat_dev/screens/house_tax/house_tax.dart';

import 'package:we_panchayat_dev/screens/tradelicense/tradelicense.dart';

import '../income_certificate/income_certificate.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
    title: "Trade License\n  & Signboard",
    img: "assets/images/trade_license.png",
    backgroundColor: 0xffDAF5FF,
    textColor: 0xff415EB6,
    formClass: TradeLicense(
      isEdit: false,
    ),
  );

  Items item2 = new Items(
    title: "Birth & Death\n   Certificate",
    img: "assets/images/birth_&_death.png",
    backgroundColor: 0xffFBFACD,
    textColor: 0xffFFB110,
    formClass: BirthAndDeathCertificate(),
  );

  Items item3 = new Items(
    title: "Income Certificate",
    img: "assets/images/income.png",
    backgroundColor: 0xffFAD4D4,
    textColor: 0xffF45656,
    formClass: IncomeCertificate(
      isEdit: false,
    ),
  );

  Items item4 = new Items(
    title: "Pay House Tax",
    img: "assets/images/house_tax.png",
    backgroundColor: 0xffCDF0EA,
    textColor: 0xff23B0B0,
    formClass: HouseTax(),
  );

//   @override
//   Widget build(BuildContext context) {
//     List<Items> myList = [
//       item1,
//       item2,
//       item3,
//       item4,
//     ];
//     return Flexible(
//       child: GridView.count(
//           childAspectRatio: 1.3,
//           padding: EdgeInsets.only(left: 24, right: 24),
//           crossAxisCount: 2,
//           crossAxisSpacing: 24,
//           mainAxisSpacing: 24,
//           children: myList.map((data) {
//             return InkWell(
//               onTap: () {
//                 print("Tapped on ${data.title}");
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => data.formClass),
//                 );
//               },
//               child: Ink(
//                 decoration: BoxDecoration(
//                   color: Color(data.backgroundColor),
//                   borderRadius: BorderRadius.circular(20),
//                   // boxShadow: [
//                   //   BoxShadow(
//                   //     color: const Color(0xFFA7A9AF),
//                   //     blurRadius: 2.0,
//                   //     offset: Offset(0, 1),
//                   //   ),
//                   // ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Image.asset(
//                       data.img,
//                       width: 42,
//                     ),
//                     SizedBox(
//                       height: 14,
//                     ),
//                     Text(
//                       data.title,
//                       style: TextStyle(
//                         color: Color(data.textColor),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Poppins-Medium',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList()),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
    ];

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.3,
                    child: InkWell(
                      onTap: () {
                        print("Tapped on ${myList[0].title}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myList[0].formClass),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(myList[0].backgroundColor),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: const Color(0xFFA7A9AF),
                          //     blurRadius: 2.0,
                          //     offset: Offset(0, 1),
                          //   ),
                          // ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              myList[0].img,
                              width: 42,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              myList[0].title,
                              style: TextStyle(
                                color: Color(myList[0].textColor),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.3,
                    child: InkWell(
                      onTap: () {
                        print("Tapped on ${myList[1].title}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myList[1].formClass),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(myList[1].backgroundColor),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: const Color(0xFFA7A9AF),
                          //     blurRadius: 2.0,
                          //     offset: Offset(0, 1),
                          //   ),
                          // ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              myList[1].img,
                              width: 42,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              myList[1].title,
                              style: TextStyle(
                                color: Color(myList[1].textColor),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.3,
                    child: InkWell(
                      onTap: () {
                        print("Tapped on ${myList[2].title}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myList[2].formClass),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(myList[2].backgroundColor),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: const Color(0xFFA7A9AF),
                          //     blurRadius: 2.0,
                          //     offset: Offset(0, 1),
                          //   ),
                          // ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              myList[2].img,
                              width: 42,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              myList[2].title,
                              style: TextStyle(
                                color: Color(myList[2].textColor),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.3,
                    child: InkWell(
                      onTap: () {
                        print("Tapped on ${myList[3].title}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myList[3].formClass),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(myList[3].backgroundColor),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: const Color(0xFFA7A9AF),
                          //     blurRadius: 2.0,
                          //     offset: Offset(0, 1),
                          //   ),
                          // ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              myList[3].img,
                              width: 42,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              myList[3].title,
                              style: TextStyle(
                                color: Color(myList[3].textColor),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Items {
  String title;
  String img;
  var backgroundColor;
  var textColor;
  var formClass;

  Items({
    required this.title,
    required this.img,
    required this.backgroundColor,
    required this.textColor,
    required this.formClass,
  });
}
