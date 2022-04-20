import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kilogram/helpers/size_guide.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kilogram/resources/auth_methods.dart';
import 'package:kilogram/utils/app_colors.dart';
import 'package:kilogram/utils/image_picker.dart';
import 'package:kilogram/utils/snackbar_creator.dart';
import 'package:kilogram/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _unameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _unameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signupUser(
      _mailController.text,
      _passController.text,
      _unameController.text,
      _bioController.text,
      _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res == "Login:Success") {
      showSnackbar("Dein Account wurde erfolgreich erstellt!", context);
    } else {
      showSnackbar(res, context);
      _passController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                proportionateScreenWidthFraction(ScreenFraction.onetenth),
          ),
          width: realScreenWidth(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              SvgPicture.asset(
                "assets/svg/kilogram.svg",
                color: Colors.white,
                height: 48,
              ),
              const SizedBox(height: 64.0),

              //Circular Profile Picture Uploader
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64.0, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 64.0,
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                        ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo_rounded),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24.0,
              ),
              Expanded(
                flex: 3,
                child: ListView(
                  children: [
                    TextFieldInput(
                      _unameController,
                      hintText: "Username",
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFieldInput(
                      _bioController,
                      hintText: "Über dich",
                      textInputType: TextInputType.multiline,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),

                    // Text fields input Email
                    TextFieldInput(
                      _mailController,
                      hintText: "E-Mail",
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    // Text fields input Password
                    TextFieldInput(
                      _passController,
                      hintText: "Passwort",
                      textInputType: TextInputType.visiblePassword,
                      isPass: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),

              // Login Button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: !_isLoading
                      ? const Text("Registrieren")
                      : const SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: primaryColor,
                          ),
                        ),
                  width: realScreenWidth(),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              // Transition to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Du hast einen Account? "),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        "Hier einloggen.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
