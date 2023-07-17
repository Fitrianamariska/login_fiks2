import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_fiks2/screens/sign_in.dart';
import 'package:file_picker/file_picker.dart';
import '../pengalaman/pengalaman.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Set the username and email in the text fields
      _usernameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _profileImage = File(result.files.single.path!);
      });
    }
  }

  Future<String?> _uploadImage(File? image) async {
    if (image != null) {
      try {
        // Read the image file
        List<int> imageBytes = await image.readAsBytes();

        // Convert the image file to a base64 string
        String base64Image = base64Encode(imageBytes);

        return base64Image;
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
    return null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _usernameFocusNode.unfocus();
        _emailFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                title: Text('PROFILE'),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                ),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 40.0,
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: GestureDetector(
                        onTap: _pickProfileImage,
                        child: CircleAvatar(
                          radius: 150.0,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? Icon(
                                  Icons.person,
                                  size: 150.0,
                                  color: Color.fromRGBO(20, 43, 145, 0.902),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        TextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: SizedBox(
                            width: 200.0, // Adjust the width as needed
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => halPengalaman(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(
                                  255,
                                  31,
                                  33,
                                  146,
                                ),
                              ),
                              child: Text('Pengalaman'),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF090774),
                            ),
                            child: Text(
                              "Logout",
                            ),
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value) {
                                print("Signed Out");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF090774),
                            ),
                            child: Text(
                              "Save",
                            ),
                            onPressed: () async {
                              // Upload the profile image
                              final String? imagePath =
                                  await _uploadImage(_profileImage);

                              // Save the profile information to Firestore
                              FirebaseFirestore.instance
                                  .collection('fotoprofil')
                                  .doc()
                                  .set({
                                'username': _usernameController.text,
                                'email': _emailController.text,
                                'profileImage': imagePath,
                              });

                              // Navigate to another screen or perform any other actions
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
