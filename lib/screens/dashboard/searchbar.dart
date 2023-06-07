import 'package:flutter/material.dart';
import 'package:we_panchayat_dev/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search a service',
          hintStyle: FormConstants.getDropDownHintStyle(),
          prefixIcon: Icon(Icons.search_sharp, color: ColorConstants.formLabelTextColor,),
          border: FormConstants.getEnabledBorder(),
          enabledBorder: FormConstants.getEnabledBorder(),
          focusedBorder: FormConstants.getFocusedBorder(),
        ),
      ),
    );
  }
}
