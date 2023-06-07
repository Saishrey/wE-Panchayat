import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_panchayat_dev/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:image/image.dart' as img;
import 'package:we_panchayat_dev/services/grievance_api_service.dart';

import '../../models/grievance_data_response_model.dart';
import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';
import '../application_submitted.dart';

import 'package:path_provider/path_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GrievanceReviewForm extends StatefulWidget {
  final GrievanceDataResponseModel grievanceData;

  const GrievanceReviewForm({super.key, required this.grievanceData});

  @override
  GrievanceReviewFormState createState() => new GrievanceReviewFormState();
}

class GrievanceReviewFormState extends State<GrievanceReviewForm> {
  GrievanceDataResponseModel? _grievanceDataResponseModel;

  Map<String, File> _fileMap = {};

  int _currentImageIndex = 0;

  final List<String> _imageNames = [
    "img-1",
    "img-2",
    "img-3",
  ];

  String? _tempPath;


  @override
  void initState() {
    super.initState();

    _grievanceDataResponseModel = widget.grievanceData;

    _initTempPath();
  }

  void _initTempPath() async {
    Directory? tempDir = await getExternalStorageDirectory();

    setState(() {
      if (tempDir != null) {
        _tempPath = tempDir.path;
      }
    });

    List<int>? binaryData;
    binaryData = _grievanceDataResponseModel?.data?.images?.img1?.data;
    assignFile(_imageNames[0], "IMAGE_${_imageNames[0]}_${_grievanceDataResponseModel?.data?.gid}", binaryData);

    binaryData = _grievanceDataResponseModel?.data?.images?.img2?.data;
    assignFile(_imageNames[1], "IMAGE_${_imageNames[1]}_${_grievanceDataResponseModel?.data?.gid}", binaryData);

    binaryData = _grievanceDataResponseModel?.data?.images?.img3?.data;
    assignFile(_imageNames[2], "IMAGE_${_imageNames[2]}_${_grievanceDataResponseModel?.data?.gid}", binaryData);
  }

  void assignFile(String key, String filename, List<int>? binaryData) async {
    File? imgFile = await binaryToTempFile(filename, binaryData);
    if (imgFile != null) {
      setState(() {
        _fileMap[key] = imgFile;
      });
    }
  }

  Future<File?> binaryToTempFile(String filename, List<int>? binaryData) async {
    // final directory = await getTemporaryDirectory();
    if (binaryData != null && _tempPath != null) {
      final File file;
      // Decode binary data to image
      img.Image? image = img.decodeImage(binaryData);
      // Encode image to JPEG format
      List<int> jpeg = img.encodeJpg(image!);
      file = File('$_tempPath/$filename.jpeg');
      print('$filename.jpeg');

      await file.writeAsBytes(jpeg);

      return file;
    }
    return null;
  }

  Future<bool> _handleBackPressed() async {
    // Delete files from the file map
    _fileMap.values.forEach((file) {
      // file.deleteSync();
      if (file.existsSync()) {
        file.deleteSync();
        print('File deleted');
      } else {
        print('File not found');
      }
    });

    return true; // Allow the app to be closed
  }

  @override
  Widget build(BuildContext context) {
    print(_fileMap);

    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.formBorderColor,
          foregroundColor: ColorConstants.darkBlueThemeColor,
          title: Text(
            'Grievance Form Data',
            style: TextStyle(
                fontFamily: 'Poppins-Medium',
                color: ColorConstants.darkBlueThemeColor,
                fontSize: 18),
          ),
          elevation: 0,
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Status : ",
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            color: Color(0xff7b7f9e),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (_grievanceDataResponseModel?.data?.isResolved! ==
                          true) ...[
                        Expanded(
                          child: Text(
                            "Resolved",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              color: ColorConstants.submitGreenColor,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: Text(
                            "Pending...",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(
                        text: widget.grievanceData.data?.title),
                    style: FormConstants.getTextStyle(),
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: FormConstants.getLabelAndHintStyle(),
                      filled: true,
                      fillColor: Colors.white,
                      border: FormConstants.getEnabledBorder(),
                      enabledBorder: FormConstants.getEnabledBorder(),
                      disabledBorder: FormConstants.getEnabledBorder(),
                      focusedBorder: FormConstants.getFocusedBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(
                        text: widget.grievanceData.data?.type),
                    style: FormConstants.getTextStyle(),
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Type',
                      labelStyle: FormConstants.getLabelAndHintStyle(),
                      filled: true,
                      fillColor: Colors.white,
                      border: FormConstants.getEnabledBorder(),
                      enabledBorder: FormConstants.getEnabledBorder(),
                      disabledBorder: FormConstants.getEnabledBorder(),
                      focusedBorder: FormConstants.getFocusedBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 6,
                    maxLines: 6,
                    controller: TextEditingController(
                        text: widget.grievanceData.data?.body),
                    style: FormConstants.getTextStyle(),
                    // enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Body',
                      labelStyle: FormConstants.getLabelAndHintStyle(),
                      filled: true,
                      fillColor: Colors.white,
                      border: FormConstants.getEnabledBorder(),
                      enabledBorder: FormConstants.getEnabledBorder(),
                      disabledBorder: FormConstants.getEnabledBorder(),
                      focusedBorder: FormConstants.getFocusedBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    // padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorConstants.formBorderColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Images',
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              fontSize: 14,
                              color: ColorConstants.formLabelTextColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_fileMap.isEmpty) ...[
                          Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 40,
                                  color: ColorConstants.formLabelTextColor,
                                ),
                                Text(
                                  "No Images.",
                                  style: TextStyle(
                                    color: ColorConstants.formLabelTextColor,
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 16 / 9,
                                  enableInfiniteScroll: false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 0.8,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentImageIndex = index;
                                    });
                                  },
                                ),
                                items: _fileMap.values.toList().map((file) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5.0),
                                        child:
                                            Image.file(file, fit: BoxFit.cover),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _fileMap.keys.map((key) {
                                    int? index = _fileMap.values
                                        .toList()
                                        .indexOf(_fileMap[key]!);
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
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
