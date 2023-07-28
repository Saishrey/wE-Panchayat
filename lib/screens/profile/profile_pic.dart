import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_panchayat_dev/config.dart';
import 'package:we_panchayat_dev/screens/profile/user_profile.dart';
import 'package:we_panchayat_dev/services/profile_pic_api_service.dart';

import '../../constants.dart';
import '../../services/shared_service.dart';
import '../homepage/homepage.dart';
import '../security/mpin_create.dart';

class ProfilePicturePage extends StatefulWidget {
  final int userId;
  final String mongoId;
  final bool isSignup;

  const ProfilePicturePage(
      {super.key,
      required this.userId,
      required this.mongoId,
      required this.isSignup});

  @override
  _ProfilePicturePageState createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  final int _maxFileSize = 2 * 1024 * 1024;

  File? _image;

  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      // Check if the selected file has a JPG or JPEG extension
      if (pickedFile.path.endsWith('.jpg') ||
          pickedFile.path.endsWith('.jpeg')) {
        final file = File(pickedFile.path);
        final fileStat = await file.stat();
        final fileSize = fileStat.size;

        print('File Size: $fileSize bytes');

        if (fileSize > _maxFileSize) {
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
            _image = file;
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Select JPEG image'),
            content: Text('Selected file is not of the type jpeg or jpg.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      print('No image selected.');
    }
  }

  void deleteImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  void initState() {
    super.initState();
    if(!widget.isSignup) {
      _initProfilePic();
    }
  }

  void _initProfilePic() async {
    File? file = await SharedService.getProfilePicture();
    if (file != null) {
      setState(() {
        _image = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("IMAGE: $_image");
    if (widget.isSignup) {
      return Container(
        padding: EdgeInsets.only(top: 60.0),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/auth_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'Profile Picture',
                      style: TextStyle(
                        fontFamily: 'Poppins-Bold',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.darkBlueThemeColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: _image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage(
                                  'assets/images/user_profile_blue.png'),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => getImage(ImageSource.camera),
                      child: Ink(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xffDAF5FF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 45,
                                    color: ColorConstants.lightBlueThemeColor,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Camera',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 12,
                                  color: Color(0xff2B2730),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => getImage(ImageSource.gallery),
                      child: Ink(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xffDDF7E3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.photo_rounded,
                                    size: 45,
                                    color: ColorConstants.submitGreenColor,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Gallery',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 12,
                                  color: Color(0xff2B2730),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => deleteImage(),
                      child: Ink(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xffF5EAEA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.delete,
                                    size: 45,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 12,
                                  color: Color(0xff2B2730),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const CreateMPINScreen(isSignUp: true)),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: ColorConstants.colorHuntCode2,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Poppins-Medium',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: _image != null
                        ? () async {
                            bool response =
                                await ProfilePicAPIService.uploadProfilePic(
                                    _image!, widget.userId);
                            if (response) {
                              await SharedService.setProfilePicture(_image, false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Profile picture uploaded successfully"),
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const CreateMPINScreen(isSignUp: true)),
                                    (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Error uploading profile picture"),
                                ),
                              );
                            }
                          }
                        : null,
                    child: Text(
                      "Set Profile Picture",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Bold',
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: _image != null
                          ? MaterialStateProperty.all<Color>(
                              ColorConstants.lightBlueThemeColor)
                          : MaterialStateProperty.all<Color>(Colors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: ColorConstants.darkBlueThemeColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                  top: 16, left: 24, right: 24, bottom: 8),
              child: const Text(
                'Change profile picture',
                style: TextStyle(
                  fontFamily: 'Poppins-Bold',
                  fontSize: 26,
                  color: Color(0xff2B2730),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4.0,
                        ),
                      ),
                      child: _image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage(
                                  'assets/images/user_profile_blue.png'),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => getImage(ImageSource.camera),
                          child: Ink(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDAF5FF),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 45,
                                        color:
                                            ColorConstants.lightBlueThemeColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 12,
                                      color: Color(0xff2B2730),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => getImage(ImageSource.gallery),
                          child: Ink(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDDF7E3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.photo_rounded,
                                        size: 45,
                                        color: ColorConstants.submitGreenColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'Gallery',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 12,
                                      color: Color(0xff2B2730),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => deleteImage(),
                          child: Ink(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF5EAEA),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        size: 45,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 12,
                                      color: Color(0xff2B2730),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xff2B2730),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: Color(0xff2B2730),
                              ),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(top: 15.0, bottom: 15.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if(widget.mongoId == "NA") {
                            bool response =
                            await ProfilePicAPIService.uploadProfilePic(
                                _image!, widget.userId);
                            if (response) {
                              await SharedService.setProfilePicture(_image, false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Profile picture uploaded successfully"),
                                ),
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text("Error uploading profile picture"),
                                ),
                              );
                            }
                          } else if(_image == null) {
                            bool response =
                            await ProfilePicAPIService.deleteProfilePic(
                                widget.userId, widget.mongoId);
                            if (response) {
                              await SharedService.deleteProfilePicture();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Profile picture deleted successfully"),
                                ),
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text("Error deleting profile picture"),
                                ),
                              );
                            }
                          }
                          else {
                            bool response =
                            await ProfilePicAPIService.updateProfilePic(
                                _image!, widget.mongoId);
                            if (response) {
                              await SharedService.updateProfilePicture(_image);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Profile picture updated successfully"),
                                ),
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text("Error updating profile picture"),
                                ),
                              );
                            }
                          }

                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConstants.lightBlueThemeColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(top: 15.0, bottom: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
