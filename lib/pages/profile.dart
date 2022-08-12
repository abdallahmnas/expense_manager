import 'dart:io';

import 'package:expense_management/components/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/colors.dart';
import '../utils/shared_preference.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? image;
  late File imageFile;
  TextEditingController nameController =
      TextEditingController(text: 'Abdul Developer');
  TextEditingController emailController =
      TextEditingController(text: 'abdul@testmail.com');
  TextEditingController phoneController =
      TextEditingController(text: '+2348098765432');
  TextEditingController addressController =
      TextEditingController(text: 'Kano, Nigeria');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile().then((getProf) {
      print(getProf.toString() + ' UIs oro');
      setState(() {
        if (getProf != null && getProf! != '') {
          nameController.text = getProf['name'];
          emailController.text = getProf['email'];
          phoneController.text = getProf['phone'];
          addressController.text = getProf['address'];
        } else {
          print('Empty');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile', style: TextStyle(color: primary_color)),
        backgroundColor: appBar_color,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: primary_color,
            )),
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                  child: Column(
                children: [
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black38,
                          radius: 100,
                          child: image == null
                              ? Icon(Icons.person, color: Colors.white)
                              : Image.file(image!),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: GestureDetector(
                                onTap: () => pickImage(),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                            radius: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(6),
                      child: Text(
                        '${nameController.text}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Text(
                    'Technology Department',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyField(
                      controller: nameController,
                      hint: 'Full Name',
                      kType: 'text'),
                  SizedBox(
                    height: 20,
                  ),
                  MyField(
                      controller: emailController,
                      hint: 'Email',
                      kType: 'email'),
                  SizedBox(
                    height: 20,
                  ),
                  MyField(
                      controller: phoneController,
                      hint: 'Phone Number',
                      kType: 'text'),
                  SizedBox(
                    height: 20,
                  ),
                  MyField(
                      // controller: phoneController,
                      hint: 'Job Description',
                      kType: 'text'),
                  SizedBox(
                    height: 20,
                  ),
                  MyField(
                      controller: addressController,
                      hint: 'Full Address',
                      kType: 'text'),
                  SizedBox(
                    height: 20,
                  ),
                  InkBtn(
                      context: context,
                      text: 'Update Profile',
                      onClick: () {
                        setState(() {
                          nameController.text = nameController.text;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )),
            ),
          ),
        ),
      ]),
    );
  }

//  Image Picker
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
