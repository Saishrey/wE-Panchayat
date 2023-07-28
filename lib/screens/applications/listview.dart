import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/models/applications_response_model.dart';
import 'package:we_panchayat_dev/models/income_certificate_response_model.dart';
import 'package:we_panchayat_dev/models/trade_license_reponse_model.dart';
import 'package:we_panchayat_dev/models/income_certificate_response_model.dart';
import 'package:we_panchayat_dev/screens/review_form/income_certificate_review_form.dart';
import 'package:we_panchayat_dev/screens/review_form/trade_license_review_form.dart';
import 'package:we_panchayat_dev/services/income_certificate_api_service.dart';
import 'package:we_panchayat_dev/services/trade_license_api_service.dart';

import '../dialog_boxes.dart';
import '../review_form/income_certificate_review_form.dart';
import '../review_form/trade_license_review_form.dart';

class ApplicationsListView extends StatelessWidget {
  final List<ApplicationsListItem> entries;

  const ApplicationsListView({super.key, required this.entries});

  final AssetImage _tradeLicenseIcon =
      const AssetImage("assets/images/trade_license.png");
  final AssetImage _birthAndDeathIcon =
      const AssetImage("assets/images/birth_&_death.png");
  final AssetImage _incomeCertIcon =
      const AssetImage("assets/images/income.png");
  final AssetImage _houseTaxIcon =
      const AssetImage("assets/images/house_tax.png");
  final AssetImage _defaultIcon = const AssetImage("assets/images/icon.png");

  AssetImage getImageIcon(String applicationsType) {
    switch (applicationsType) {
      case "Trade License & Signboard":
        return _tradeLicenseIcon;
      case "Birth & Death Certificate":
        return _birthAndDeathIcon;
      case "Income Certificate":
        return _incomeCertIcon;
      case "Pay House Tax":
        return _houseTaxIcon;
      default:
        return _defaultIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            //     BoxShadow(
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
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: getImageIcon(entries[index].applicationType!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  entries[index].applicationType!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins-Medium',
                    color: ColorConstants.darkBlueThemeColor,
                  ),
                ),
                subtitle: Text(
                  "ID: ${entries[index].applicationId!}",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins-Medium',
                    color: ColorConstants.formLabelTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  formatDate(entries[index].date!),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins-Medium',
                    color: ColorConstants.formLabelTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  if (entries[index].applicationType ==
                      "Trade License & Signboard") {
                    _navigateToTradeLicenseDetails(
                        context, entries[index].applicationId!);
                  }
                  if (entries[index].applicationType == "Income Certificate") {
                    _navigateToIncomeCertificateDetails(
                        context, entries[index].applicationId!);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('MMMM dd yyyy').format(date);
  }

  void _navigateToTradeLicenseDetails(
      BuildContext context, String applicationId) async {
    final licenseData = await _fetchLicenseDetails(applicationId);
    if(licenseData != null) {
      if (licenseData.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TradeLicenseReviewForm(
              license: licenseData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not fetch details.')));
      }
    } else {
      DialogBoxes.showServerDownDialogBox(context);
    }

  }

  Future<TradeLicenseFormResponseModel?> _fetchLicenseDetails(
      String applicationId) async {
    // Map<String, String> body1 = {
    //   "application_id": applicationId,
    // };
    var response = await TradeLicenseAPIService.retrieveForm(applicationId);
    if(response != null) {
      return tradeLicenseFormResponseJson(response.body);
    } else {
      return null;
    }
  }

  void _navigateToIncomeCertificateDetails(
      BuildContext context, String applicationId) async {
    final incomeCertificateData =
        await _fetchIncomeCertificateDetails(applicationId);
    if(incomeCertificateData != null) {
      if (incomeCertificateData.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IncomeCertificateReviewForm(
              incomeCertificate: incomeCertificateData,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not fetch details.')));
      }
    } else {
      DialogBoxes.showServerDownDialogBox(context);
    }

  }

  Future<IncomeCertificateFormResponseModel?> _fetchIncomeCertificateDetails(
      String applicationId) async {
    // Map<String, String> body1 = {
    //   "application_id": applicationId,
    // };
    var response = await IncomeCertificateAPIService.retrieveForm(applicationId);
    if(response != null) {
      return incomeCertificateFormResponseJson(response.body);

    } else {
      return null;
    }
  }
}
