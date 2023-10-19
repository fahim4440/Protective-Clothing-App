import 'package:flutter/material.dart';
import 'dart:async';
import '../resources/route_manager.dart';
import '../resources/color_manager.dart';
import '../resources/asset_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({Key? key}) : super(key: key);

  @override
  State<SplashPageView> createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? data = prefs.getBool('isLoggedIn');
    bool isLoggedIn = false;
    if(data != null) {
      isLoggedIn = data;
    }
    if(isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: SizedBox(
            height: 250,
            width: 250,
            child: Image(
                image: AssetImage(ImageAssets.splashLogo)
            ),
          ),
      ),
    );
  }
}
