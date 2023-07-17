import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/models/applications_response_model.dart';
import 'package:we_panchayat_dev/models/grievance_retrieve_all_response_model.dart';
import 'package:we_panchayat_dev/models/income_certificate_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/models/income_certificate_response_model.dart';
import 'package:we_panchayat_dev/screens/review_form/grievance_review_form.dart';
import 'package:we_panchayat_dev/screens/review_form/income_certificate_review_form.dart';
import 'package:we_panchayat_dev/screens/review_form/trade_license_review_form.dart';
import 'package:we_panchayat_dev/services/grievance_api_service.dart';
import 'package:we_panchayat_dev/services/income_certificate_api_service.dart';
import 'package:we_panchayat_dev/services/trade_license_api_service.dart';

import '../../models/grievance_data_response_model.dart';

class GrievancesListView extends StatelessWidget {
  final List<GrievancesListItem> entries;

  const GrievancesListView({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Text(
          "No Grievances.",
          style: const TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: entries.length,
      // separatorBuilder: (BuildContext context, int index) {
      //   return const SizedBox(height: 16); // set the height of the separator
      // },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Divider(
            color: Colors.black12,
            thickness: 1.0,
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return Material(
          child: Ink(
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(10),
            //   boxShadow: [

            //       color: Colors.grey.withOpacity(0.5),
            //       spreadRadius: 2,
            //       blurRadius: 5,
            //       offset: const Offset(0, 3),
            //     ),
            //   ],
            // ),
            // decoration: FormConstants.getDropDownBoxDecoration(),
            child: InkWell(
              child: ListTile(
                leading: SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.feedback,
                    color: ColorConstants.grievanceRedColor,
                    size: 36,
                  ),
                ),
                title: Text(
                  "Title: ${entries[index].title!}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins-Medium',
                    color: ColorConstants.darkBlueThemeColor,
                  ),
                ),
                subtitle: Text(
                  "Type: ${entries[index].type!}",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins-Medium',
                    color: ColorConstants.formLabelTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(
                  entries[index].isResolved! ? Icons.check_circle : Icons.info,
                  color: entries[index].isResolved!
                      ? ColorConstants.submitGreenColor
                      : ColorConstants.grievanceYellowColor,
                ),
                // trailing: Text(
                //   "${entries[index].isResolved!}",
                //   style: TextStyle(
                //     fontSize: 12,
                //     fontFamily: 'Poppins-Medium',
                //     color: ColorConstants.formLabelTextColor,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                onTap: () async {
                  _navigateToGrievanceDetails(context, entries[index].gid!);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToGrievanceDetails(
      BuildContext context, String grievanceId) async {
    Map<String, String?> body = {
      "gid": grievanceId,
    };

    var response = await GrievanceAPIService.retrieveGrievance(body);

    if (response.statusCode == 200) {
      GrievanceDataResponseModel model =
          grievanceDataResponseModelJson(response.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GrievanceReviewForm(
            grievanceData: model,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not fetch details.')));
    }
  }
}
