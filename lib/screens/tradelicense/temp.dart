// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
//
// class FileUpload extends StatefulWidget {
//   const FileUpload({ Key? key }) : super(key: key);
//
//   @override
//   _FileUploadState createState() => _FileUploadState();
// }
//
// class _FileUploadState extends State<FileUpload> with SingleTickerProviderStateMixin {
//   String _image = 'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
//   late AnimationController loadingController;
//
//   File? _file;
//   PlatformFile? _platformFile;
//
//   selectFile() async {
//     final file = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['png', 'jpg', 'jpeg']
//     );
//
//     if (file != null) {
//       setState(() {
//         _file = File(file.files.single.path!);
//         _platformFile = file.files.first;
//       });
//     }
//
//     loadingController.forward();
//   }
//
//   @override
//   void initState() {
//     loadingController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 10),
//     )..addListener(() { setState(() {}); });
//
//     super.initState();
//   }
//
//   //////////////////////////////////
//   /// @theflutterlover on Instagram
//   ///
//   /// https://afgprogrammer.com
//   //////////////////////////////////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: 100,),
//             Image.network(_image, width: 300,),
//             SizedBox(height: 50,),
//             Text('Upload your file', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
//             SizedBox(height: 10,),
//             Text('File should be jpg, png', style: TextStyle(fontSize: 15, color: Colors.grey.shade500),),
//             SizedBox(height: 20,),
//             GestureDetector(
//               onTap: selectFile,
//               child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
//                   child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: Radius.circular(10),
//                     dashPattern: [10, 4],
//                     strokeCap: StrokeCap.round,
//                     color: Colors.blue.shade400,
//                     child: Container(
//                       width: double.infinity,
//                       height: 150,
//                       decoration: BoxDecoration(
//                           color: Colors.blue.shade50.withOpacity(.3),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Iconsax.folder_open, color: Colors.blue, size: 40,),
//                           SizedBox(height: 15,),
//                           Text('Select your file', style: TextStyle(fontSize: 15, color: Colors.grey.shade400),),
//                         ],
//                       ),
//                     ),
//                   )
//               ),
//             ),
//             _platformFile != null
//                 ? Container(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Selected File',
//                       style: TextStyle(color: Colors.grey.shade400, fontSize: 15, ),),
//                     SizedBox(height: 10,),
//                     Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.shade200,
//                                 offset: Offset(0, 1),
//                                 blurRadius: 3,
//                                 spreadRadius: 2,
//                               )
//                             ]
//                         ),
//                         child: Row(
//                           children: [
//                             ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.file(_file!, width: 70,)
//                             ),
//                             SizedBox(width: 10,),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(_platformFile!.name,
//                                     style: TextStyle(fontSize: 13, color: Colors.black),),
//                                   SizedBox(height: 5,),
//                                   Text('${(_platformFile!.size / 1024).ceil()} KB',
//                                     style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
//                                   ),
//                                   SizedBox(height: 5,),
//                                   Container(
//                                       height: 5,
//                                       clipBehavior: Clip.hardEdge,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         color: Colors.blue.shade50,
//                                       ),
//                                       child: LinearProgressIndicator(
//                                         value: loadingController.value,
//                                       )
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: 10,),
//                           ],
//                         )
//                     ),
//                     SizedBox(height: 20,),
//                     MaterialButton(
//                       minWidth: double.infinity,
//                       height: 45,
//                       onPressed: () {},
//                       color: Colors.black,
//                       child: Text('Upload', style: TextStyle(color: Colors.white),),
//                     )
//                   ],
//                 ))
//                 : Container(),
//             SizedBox(height: 150,),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class FilePickerDemo extends StatefulWidget {
  late final ValueChanged<PlatformFile> onOpenedFile;

  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  File? _selectedFile;

  final int _maxFileSize = 2 * 1024 * 1024;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      // maxSize: 2 * 1024 * 1024, // 2MB
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      if(file.size > _maxFileSize) {
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
      }
      else {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    }
  }

  void _deleteFile() {
    setState(() {
      _selectedFile = null;
    });
  }

  void _viewFile() async {
    if (_selectedFile != null) {
      String filePath = _selectedFile!.path;
      await OpenFile.open(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF File Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedFile != null)
              InkWell(
                onTap: _viewFile,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.picture_as_pdf, size: 48.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedFile!.path.split('/').last,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                '${(_selectedFile!.lengthSync() / 1024).toStringAsFixed(2)} KB',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: _deleteFile,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick a PDF file'),
            ),
          ],
        ),
      ),
    );
  }
}

