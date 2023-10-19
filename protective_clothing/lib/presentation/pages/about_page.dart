import 'package:flutter/material.dart';
import '../resources/string_manager.dart';
import '../resources/color_manager.dart';

class AboutPageView extends StatefulWidget {
  const AboutPageView({Key? key}) : super(key: key);

  @override
  State<AboutPageView> createState() => _AboutPageViewState();
}

class _AboutPageViewState extends State<AboutPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.about),
      ),
      backgroundColor: ColorManager.backgroundColor,
    );
  }
}
