import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:we_panchayat_dev/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:we_panchayat_dev/services/grievance_api_service.dart';

import '../../models/login_response_model.dart';
import '../../services/shared_service.dart';
import '../application_submitted.dart';

class Grievances extends StatefulWidget {
  const Grievances({super.key});

  @override
  GrievancesState createState() => new GrievancesState();
}

class GrievancesState extends State<Grievances> {
  Map<String, File> _fileMap = {};

  final int _maxFileSize = 2 * 1024 * 1024;

  final List<String> _imageNames = [
    "img-1",
    "img-2",
    "img-3",
  ];

  final _formKey = GlobalKey<FormState>();

  String? _selectedGrievanceType;

  final List<String> _grievanceTypes = [
    "Suggestions",
    "General Public",
  ];

  TextEditingController _grievanceTitleController = TextEditingController();
  TextEditingController _grievanceBodyController = TextEditingController();

  void selected(_value) {
    setState(() {
      _selectedGrievanceType = _value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            "Grievance Portal",
            style: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: ColorConstants.darkBlueThemeColor,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  controller: _grievanceTitleController,
                  style: FormConstants.getTextStyle(),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: FormConstants.getLabelAndHintStyle(),
                    filled: true,
                    fillColor: Colors.white,
                    border: FormConstants.getEnabledBorder(),
                    enabledBorder: FormConstants.getEnabledBorder(),
                    focusedBorder: FormConstants.getFocusedBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: FormConstants.getDropDownBoxDecoration(),
                  child: DropdownButtonFormField(
                    menuMaxHeight: 200,
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Remove the bottom border
                    ),
                    isExpanded: true,
                    icon: FormConstants.getDropDownIcon(),
                    value: _selectedGrievanceType,
                    items: _grievanceTypes.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: FormConstants.getDropDownTextStyle(),
                        ),
                      );
                    }).toList(),
                    onChanged: (_value) => selected(_value),
                    hint: Text(
                      "Type",
                      style: FormConstants.getDropDownHintStyle(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        // Add validation to check if a value is selected
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 6,
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                  controller: _grievanceBodyController,
                  style: FormConstants.getTextStyle(),
                  decoration: InputDecoration(
                    labelText: 'Type your grievance',
                    labelStyle: FormConstants.getLabelAndHintStyle(),
                    filled: true,
                    fillColor: Colors.white,
                    border: FormConstants.getEnabledBorder(),
                    enabledBorder: FormConstants.getEnabledBorder(),
                    focusedBorder: FormConstants.getFocusedBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(16.0),
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
                      Text(
                        'Attach images(JPEG format, Max 3 files)',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 14,
                          color: ColorConstants.formLabelTextColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      if (_fileMap[_imageNames[0]] != null) ...[
                        _buildImageItem(_fileMap[_imageNames[0]]!),
                        const SizedBox(height: 10),
                      ],
                      if (_fileMap[_imageNames[1]] != null) ...[
                        _buildImageItem(_fileMap[_imageNames[1]]!),
                        const SizedBox(height: 10),
                      ],
                      if (_fileMap[_imageNames[2]] != null) ...[
                        _buildImageItem(_fileMap[_imageNames[2]]!),
                        const SizedBox(height: 10),
                      ],
                      if (_fileMap.length < 3) ...[
                        chooseFileButton(),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {

                        LoginResponseModel? model = await getUserDetails();

                        Map<String, String?> body = {
                          "taluka": model?.taluka,
                          "village": model?.village,
                          "phone": model?.phone,
                          "title": _grievanceTitleController.text,
                          "type": _selectedGrievanceType!,
                          "body": _grievanceBodyController.text,
                        };

                        var response = await GrievanceAPIService.submitGrievance(body, _fileMap);

                        if (response.statusCode == 200) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ApplicationSubmitted()),
                                (route) => false,
                          );
                        } else {
                          print("Failed to upload documents INCOME CERTIFICATE");
                        }

                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.submitGreenColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Bold',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<LoginResponseModel?> getUserDetails() async {
    LoginResponseModel? loginResponseModel = await SharedService.loginDetails();
    return loginResponseModel;
  }

  void _pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      if (file.size > _maxFileSize) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('File too large'),
            content: Text('Selected file is larger than 2 MB.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _fileMap[_imageNames[index]] = File(result.files.single.path!);
        });
      }
    }
    print(_fileMap);
  }

  Widget chooseFileButton() {
    int index = 0;

    for (int i = 0; i < _imageNames.length; i++) {
      if (_fileMap[_imageNames[i]] == null) {
        index = i;
        break;
      }
    }
    return InkWell(
      onTap: () {
        _pickFile(index);
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          padding: EdgeInsets.all(16.0),
          radius: const Radius.circular(20),
          dashPattern: [10, 10],
          color: ColorConstants.formLabelTextColor,
          strokeWidth: 2,
          child: Center(
            child: Icon(
              Icons.upload,
              color: ColorConstants.formLabelTextColor,
            ),
          ),
        ),
      ),
    );
  }

  String getKeyFromValue(File targetFile) {
    for (var entry in _fileMap.entries) {
      if (entry.value == targetFile) {
        return entry.key;
      }
    }
    return "null"; // no key found for the value
  }

  Widget _buildImageItem(File file) {
    return InkWell(
      onTap: () async {
        String filePath = file.path;
        var r = await OpenFile.open(filePath);
        print("MESSAGE: ${r.message}");
      },
      child: Ink(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border:
              Border.all(width: 2.0, color: ColorConstants.formLabelTextColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.image,
              size: 48.0,
              color: Color(0xffDD2025),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.path.split('/').last,
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        overflow: TextOverflow.ellipsis,
                        color: ColorConstants.darkBlueThemeColor,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      '${(file.lengthSync() / 1024).toStringAsFixed(2)} KB',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Color(0xFF5386E4),
              ),
              // onPressed: () {},
              onPressed: () {
                setState(() {
                  String key = getKeyFromValue(file);
                  _fileMap.remove(key);
                  print(_fileMap);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
