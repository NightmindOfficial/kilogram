import 'package:flutter/material.dart';

import 'package:kilogram/helpers/size_guide.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kilogram/utils/app_colors.dart';
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

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _unameController.dispose();
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
                height: 64,
              ),
              const SizedBox(height: 64.0),

              //Circular Profile Picture Uploader
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64.0,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80"),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo_rounded),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24.0,
              ),

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
              const SizedBox(
                height: 24.0,
              ),

              // Login Button
              InkWell(
                onTap: () {},
                child: Container(
                  child: const Text("Registrieren"),
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
              // Transition to Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already have an account? "),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        "Log in.",
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
