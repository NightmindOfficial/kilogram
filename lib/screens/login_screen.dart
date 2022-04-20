import 'package:flutter/material.dart';
import 'package:kilogram/helpers/size_guide.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kilogram/resources/auth_methods.dart';
import 'package:kilogram/utils/app_colors.dart';
import 'package:kilogram/utils/snackbar_creator.dart';
import 'package:kilogram/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _mailController.dispose();
    _passController.dispose();
  }

  void logInUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .logInUser(_mailController.text, _passController.text);
    setState(() {
      _isLoading = false;
    });

    if (res == "Login:Success") {
      showSnackbar("Du hast dich erfolgreich eingeloggt!", context);
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
                onTap: logInUser,
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
              // Transition to Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Noch keinen Account? "),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        "Hier Registrieren.",
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
