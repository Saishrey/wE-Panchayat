import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:we_panchayat_dev/models/applications_response_model.dart';
import 'package:we_panchayat_dev/models/grievance_retrieve_all_response_model.dart';
import 'package:we_panchayat_dev/models/login_response_model.dart';
import 'package:we_panchayat_dev/services/grievance_api_service.dart';
import 'package:we_panchayat_dev/services/shared_service.dart';
import '../../services/applications_api_service.dart';
import '../dashboard/griddashboard.dart';
import '../dashboard/searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'grievances_listview.dart';
import 'listview.dart';

class Applications extends StatefulWidget {
  const Applications({super.key});

  @override
  ApplicationsState createState() => ApplicationsState();
}

class ApplicationsState extends State<Applications> {
  final List<String> _applicationTypes = [
    "All",
    "Trade License & Signboard",
    // "Birth & Death Certificate",
    "Income Certificate",
    // "Pay House Tax",
    "Grievances",
  ];
  String _selectedApplicationType = "All";

  ApplicationsResponseModel? _applicationsResponseModel;
  GrievanceRetrieveAllResponseModel? _grievancesResponseModel;

  List<ApplicationsListItem>? _applications;
  List<GrievancesListItem>? _grievances;

  List<ApplicationsListItem>? _applicationsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                decoration: BoxDecoration(
                  color: ColorConstants.backgroundClipperColor,
                  // border: Border(
                  //   bottom: BorderSide(
                  //     color: Colors.grey,
                  //     width: 1.0,
                  //   ),
                  // ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Text(
                        'Search by:',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: DropdownButton<String>(
                          underline: SizedBox.shrink(),
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          value: _selectedApplicationType,
                          icon: const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedApplicationType = value!;
                              _applicationsList = _filteredApplications!;
                            });
                          },
                          items: _applicationTypes
                              .map(
                                (type) => DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 14,
                                      color: Color(0xff21205b),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_applicationsResponseModel == null) ...[
                Expanded(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ]
              // else if (_applicationsResponseModel?.statusCode != 200) ...[
              //   Expanded(
              //     child: const Center(
              //       child: Text(
              //         "No applications.",
              //         style: const TextStyle(
              //           fontFamily: 'Poppins-Medium',
              //           fontSize: 12,
              //           color: Colors.black54,
              //         ),
              //       ),
              //     ),
              //   ),
              // ]
              else if (_selectedApplicationType == "Grievances") ...[
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: GrievancesListView(entries: _grievances ?? []),
                  ),
                ),
              ] else if (_applicationsList?.isEmpty ?? true) ...[
                Expanded(
                  child: Center(
                    child: Text(
                      "No applications of type '${_selectedApplicationType}'.",
                      style: const TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ApplicationsListView(entries: _applicationsList ?? []),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  List<ApplicationsListItem>? get _filteredApplications {
    print(_selectedApplicationType);
    if (_selectedApplicationType == 'All') {
      if (_applications?.isEmpty ?? true) {
        // If there are no items that match the selected filter, return an empty list
        return [];
      }
      _applications?.sort(
          (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
      return _applications;
    } else {
      List<ApplicationsListItem>? filteredList = _applications
          ?.where((item) => item.applicationType == _selectedApplicationType)
          .toList();
      if (filteredList?.isEmpty ?? true) {
        // If there are no items that match the selected filter, return an empty list
        return [];
      } else {
        filteredList?.sort((a, b) =>
            DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
        return filteredList;
      }
    }
  }

  // List<GrievancesListItem>? get _filteredGrievances {
  //     _grievances?.sort(
  //             (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
  //     return _grievances;
  // }

  @override
  void initState() {
    fetchApplicationsList();
  }

  void fetchApplicationsList() async {
    ApplicationsResponseModel responseModel =
        await ApplicationsAPIService.retrieveAllApplications();

    GrievanceRetrieveAllResponseModel grievanceRetrieveAllResponseModel =
        await GrievanceAPIService.retrieveAllGrievances();

    setState(() {
      _applicationsResponseModel = responseModel;
      _applications = _applicationsResponseModel?.data?.reversed.toList();
      _applicationsList = _filteredApplications;

      _grievancesResponseModel = grievanceRetrieveAllResponseModel;
      _grievances = _grievancesResponseModel?.data?.reversed.toList();
    });
  }
}
