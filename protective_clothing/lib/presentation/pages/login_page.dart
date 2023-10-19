import 'package:flutter/material.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../resources/style_manager.dart';
import '../resources/color_manager.dart';
import '../resources/value_manager.dart';
import '../view_model/login_page_view_model.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.loginTitle),
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              MaterialButton(
                color: ColorManager.primaryOpacity70,
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if(!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  bool isValidate = validation(_emailEditingController.text, _passwordEditingController.text);
                  if(isValidate) {
                    LoadingDialog.show(context);
                    Map<String, dynamic> userLogin = await LoginPageViewModel().login(_emailEditingController.text, _passwordEditingController.text);
                    bool isLoggedIn = userLogin['isLoggedIn'];
                    if(isLoggedIn) {
                      LoadingDialog.hide(context);
                      Navigator.pushReplacementNamed(context, Routes.mainRoute);
                    } else {
                      LoadingDialog.hide(context);
                      ErrorDialog.show(context, userLogin['error']);
                    }
                  } else {
                    ErrorDialog.show(context, AppString.inputErrorContent);
                  }
                },
                child: Text(
                  AppString.loginTitle,
                  style: getMediumRegularStyle(color: ColorManager.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppString.newToApp,
                    style: getMediumRegularStyle(color: ColorManager.grey),
                  ),
                  TextButton(
                    child: Text(
                      AppString.registration,
                      style: getMediumRegularStyle(color: ColorManager.darkprimary),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.registerRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool validation(String email, String password) {
  bool isValidate = false;
  if(email.contains('@') && email.contains('.') && password.length > 7) {
    isValidate = true;
  }
  return isValidate;
}

class ErrorDialog {
  static void show(BuildContext context, String error) {
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
            error,
            style: getRegularStyle(color: ColorManager.error),
          ),
        );
      },
    );
  }
}

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.backgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: ColorManager.primary), // Loading circle widget
              const SizedBox(height: 16.0),
              Text('Loading...', style: getMediumStyle(color: ColorManager.primary),), // Optional text message
            ],
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
