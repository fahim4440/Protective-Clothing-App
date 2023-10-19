import 'package:flutter/material.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../resources/style_manager.dart';
import '../resources/color_manager.dart';
import '../resources/value_manager.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final TextEditingController _firstNameEditingController = TextEditingController();
  final TextEditingController _lastNameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.registration),
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p40),
        child: ListView(
          padding: const EdgeInsets.only(top: AppPadding.p60),
          children: <Widget> [
            Column(
              children: <Widget>[
                TextField(
                  controller: _firstNameEditingController,
                  decoration: const InputDecoration(
                    labelText: AppString.firstName,
                  ),
                ),
                const SizedBox(height: AppSize.s20,),
                TextField(
                  controller: _lastNameEditingController,
                  decoration: const InputDecoration(
                    labelText: AppString.lastName,
                  ),
                ),
                const SizedBox(height: AppSize.s20,),
                TextField(
                  controller: _emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: AppString.email,
                  ),
                ),
                const SizedBox(height: AppSize.s20,),
                TextField(
                  controller: _passwordEditingController,
                  decoration: const InputDecoration(
                    labelText: AppString.password,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: AppSize.s20,),
                TextField(
                  controller: _confirmPasswordEditingController,
                  decoration: const InputDecoration(
                    labelText: AppString.confirmPassword,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: AppSize.s20,),
                MaterialButton(
                  color: ColorManager.primaryOpacity70,
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    bool isValidated = validation(_firstNameEditingController.text,
                        _lastNameEditingController.text, _emailEditingController.text,
                        _passwordEditingController.text, _confirmPasswordEditingController.text);
                    if(isValidated) {
                      Navigator.pushReplacementNamed(context, Routes.loginRoute);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: ColorManager.backgroundColor,
                            title: Text(
                              AppString.inputError,
                              style: getLargeBoldStyle(color: ColorManager.error),
                            ),
                            content: Text(
                              AppString.inputErrorContent,
                              style: getRegularStyle(color: ColorManager.error),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    AppString.registration,
                    style: getMediumRegularStyle(color: ColorManager.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppString.alreadyUser,
                      style: getMediumRegularStyle(color: ColorManager.grey),
                    ),
                    TextButton(
                      child: Text(
                        AppString.loginTitle,
                        style: getMediumRegularStyle(color: ColorManager.darkprimary),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.loginRoute);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}

bool validation(String firstName, String lastName, String email, String password, String confirmPassword) {
  bool isValidated = false;
  print("$firstName, $lastName, $email, $password, $confirmPassword");
  if(firstName.length > 2 && lastName.length > 2
      && email.contains('@') && email.contains('.')
      && password.length > 7 && confirmPassword == password) {
    isValidated = true;
  }
  return isValidated;
}
