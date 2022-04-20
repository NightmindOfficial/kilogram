import 'package:flutter/material.dart';
import 'package:kilogram/helpers/size_guide.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kilogram/utils/app_colors.dart';
import 'package:kilogram/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passController.dispose();
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
                  child: const Text("Einloggen"),
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
                    child: const Text("Don't have an account? "),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        "Sign up.",
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
