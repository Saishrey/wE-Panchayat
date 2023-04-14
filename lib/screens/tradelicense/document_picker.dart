import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class DocumentPicker extends StatefulWidget {
  const DocumentPicker({Key? key}) : super(key: key);

  @override
  _DocumentPickerState createState() => _DocumentPickerState();
}

class _DocumentPickerState extends State<DocumentPicker> {

  final List<bool> _isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  bool declaration = false;


  // Map<String, bool> _permissionsMap = {
  //   "Foods & Drugs": false,
  //   "Excise": false,
  //   "Police Dept.": false,
  //   "CRZ": false,
  //   "Tourism": false,
  //   "Fire Brigade": false,
  //   "Factories & Boilers": false,
  //   "Health Services": false,
  //   "Others": false,
  // };
  //
  // final Map<String, int> _permissionsIndexMap = {
  //   "Foods & Drugs": 3,
  //   "Excise": 4,
  //   "Police Dept.": 5,
  //   "CRZ": 6,
  //   "Tourism": 7,
  //   "Fire Brigade": 8,
  //   "Factories & Boilers": 9,
  //   "Health Services": 10,
  //   "Others": 11,
  // };

  // final List<String> _permissionsDropdownItems = [
  //   "Foods & Drugs",
  //   "Excise",
  //   "Police Dept.",
  //   "CRZ",
  //   "Tourism",
  //   "Fire Brigade",
  //   "Factories & Boilers",
  //   "Health Services",
  //   "Others",
  // ];

  String? _permissionsDropDownValue;

  final List<File?> _pdfFiles = List.generate(12, (_) => null);
  final int _maxFileSize = 2 * 1024 * 1024;

  @override
  Widget build(BuildContext context) {
    print(_pdfFiles);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Upload Documents',
            style: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '(Please upload documents in .pdf format. File size not to exceed 2MB)',
            style: TextStyle(
              color: Colors.red,
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Identity Proof',
                style: TextStyle(
                  fontFamily: 'Poppins-Bold',
                  fontSize: 14,
                  color: Color(0xff21205b),
                ),
                textAlign: TextAlign.left,
              ),
              if (_pdfFiles[0] != null) ...[
                _buildPDFListItem(_pdfFiles[0]!)
              ] else ...[
                chooseFileButton(0)
              ],
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Housetax Receipt',
                style: TextStyle(
                  fontFamily: 'Poppins-Bold',
                  fontSize: 14,
                  color: Color(0xff21205b),
                ),
                textAlign: TextAlign.left,
              ),
              if (_pdfFiles[1] != null) ...[
                _buildPDFListItem(_pdfFiles[1]!)
              ] else ...[
                chooseFileButton(1)
              ],
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'No Objection Certificate/ Lease argreement/ Ownership document',
                style: TextStyle(
                  fontFamily: 'Poppins-Bold',
                  fontSize: 14,
                  color: Color(0xff21205b),
                ),
                textAlign: TextAlign.left,
              ),
              if (_pdfFiles[2] != null) ...[
                _buildPDFListItem(_pdfFiles[2]!)
              ] else ...[
                chooseFileButton(2)
              ],
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Please upload permissions granted by the Authorities as per requirement',
            style: TextStyle(
              fontFamily: 'Poppins-Bold',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       border: Border.all(color: Color(0xffBDBDBD), width: 1)),
          //   child: DropdownButton(
          //     menuMaxHeight: 200,
          //     isExpanded: true,
          //     icon: const Icon(
          //       Icons.arrow_drop_down_outlined,
          //       color: Colors.black,
          //     ),
          //     value: _permissionsDropDownValue,
          //     items: _permissionsDropdownItems.map((String option) {
          //       return DropdownMenuItem<String>(
          //         value: option,
          //         child: Text(
          //           option,
          //           style: const TextStyle(
          //             color: Colors.black54,
          //             fontFamily: 'Poppins-Bold',
          //           ),
          //         ),
          //       );
          //     }).toList(),
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         _permissionsDropDownValue = newValue!;
          //         // _permissionsDropDownItemsMap[_permissionsDropDownValue!] = !_permissionsDropDownItemsMap[_permissionsDropDownValue!]!;
          //       });
          //     },
          //     hint: const Text(
          //       "Select Permissions",
          //       style: TextStyle(
          //         color: Colors.black54,
          //         fontFamily: 'Poppins-Bold',
          //       ),
          //     ),
          //   ),
          // ),
          // if (_permissionsDropDownValue != null) ...[
          //   const SizedBox(height: 16),
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Text(
          //         _permissionsDropDownValue!,
          //         style: const TextStyle(
          //           fontFamily: 'Poppins-Bold',
          //           fontSize: 14,
          //           color: Color(0xff21205b),
          //         ),
          //         textAlign: TextAlign.left,
          //       ),
          //       if (_pdfFiles[
          //               _permissionsIndexMap[_permissionsDropDownValue!]!] !=
          //           null) ...[
          //         _buildPDFListItem(_pdfFiles[
          //             _permissionsIndexMap[_permissionsDropDownValue!]!]!)
          //       ] else ...[
          //         chooseFileButton(
          //             _permissionsIndexMap[_permissionsDropDownValue!]!)
          //       ],
          //     ],
          //   ),
          // ],

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[0],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[0] = value!;
                          _pdfFiles[3] = null;
                        });
                      }),
                  const Text(
                    "Foods & Drugs",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[0],
                child: _pdfFiles[3] != null
                    ? _buildPDFListItem(_pdfFiles[3]!)
                    : chooseFileButton(3),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[1],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[1] = value!;
                          _pdfFiles[4] = null;
                        });
                      }),
                  const Text(
                    "Excise",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[1],
                child: _pdfFiles[4] != null
                    ? _buildPDFListItem(_pdfFiles[4]!)
                    : chooseFileButton(4),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[2],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[2] = value!;
                          _pdfFiles[5] = null;
                        });
                      }),
                  const Text(
                    "Police Dept.",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[2],
                child: _pdfFiles[5] != null
                    ? _buildPDFListItem(_pdfFiles[5]!)
                    : chooseFileButton(5),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[3],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[3] = value!;
                          _pdfFiles[6] = null;
                        });
                      }),
                  const Text(
                    "CRZ",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[3],
                child: _pdfFiles[6] != null
                    ? _buildPDFListItem(_pdfFiles[6]!)
                    : chooseFileButton(6),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[4],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[4] = value!;
                          _pdfFiles[7] = null;
                        });
                      }),
                  const Text(
                    "Tourism",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[4],
                child: _pdfFiles[7] != null
                    ? _buildPDFListItem(_pdfFiles[7]!)
                    : chooseFileButton(7),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[5],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[5] = value!;
                          _pdfFiles[8] = null;
                        });
                      }),
                  const Text(
                    "Fire Brigade",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[5],
                child: _pdfFiles[8] != null
                    ? _buildPDFListItem(_pdfFiles[8]!)
                    : chooseFileButton(8),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[6],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[6] = value!;
                          _pdfFiles[9] = null;
                        });
                      }),
                  const Text(
                    "Factories & Boilers",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[6],
                child: _pdfFiles[9] != null
                    ? _buildPDFListItem(_pdfFiles[9]!)
                    : chooseFileButton(9),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[7],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[7] = value!;
                          _pdfFiles[10] = null;
                        });
                      }),
                  const Text(
                    "Health Services",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[7],
                child: _pdfFiles[10] != null
                    ? _buildPDFListItem(_pdfFiles[10]!)
                    : chooseFileButton(10),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: _isChecked[8],
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked[8] = value!;
                          _pdfFiles[11] = null;
                        });
                      }),
                  const Text(
                    "Others",
                    style: TextStyle(
                      fontFamily: 'Poppins-Bold',
                      fontSize: 14,
                      color: Color(0xff21205b),
                    ), // or TextOverflow.fade
                  ),
                ],
              ),
              Visibility(
                visible: _isChecked[8],
                child: _pdfFiles[11] != null
                    ? _buildPDFListItem(_pdfFiles[11]!)
                    : chooseFileButton(11),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Self Declaration",
              style: TextStyle(
                fontFamily: 'Poppins-Bold',
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Checkbox(
                  value: declaration,
                  onChanged: (bool? value) {
                    setState(() {
                      declaration = value!;
                    });
                  }),
              const Expanded(
                child: Text(
                  "I declare that the above information is true to the best of my knowledge and belief. I am well aware that information given by me above is proved false/not true, I will have to face the punishment as per law & also all the permissions obtained by me shall be summarily withdrawn.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      overflow: TextOverflow.visible),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildPDFListItem(File pdfFile) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: InkWell(
        onTap: () async {
          String filePath = pdfFile.path;
          await OpenFile.open(filePath);
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.picture_as_pdf,
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
                        pdfFile.path.split('/').last,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '${(pdfFile!.lengthSync() / 1024).toStringAsFixed(2)} KB',
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
                    int index = _pdfFiles.indexOf(pdfFile);
                    print(index);
                    _pdfFiles[index] = null;
                    print(_pdfFiles);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chooseFileButton(int index) {
    return ElevatedButton(
      onPressed: () async {
        _pickFile(index);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF5386E4)),
      ),
      child: const Text('Choose file'),
    );
  }

  void _pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
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
          _pdfFiles[index] = File(result.files.single.path!);
        });
      }
    }
    print(_pdfFiles);
  }
}
