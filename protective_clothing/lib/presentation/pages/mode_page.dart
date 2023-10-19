import 'package:flutter/material.dart';
import '../resources/string_manager.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/mode_data_provider.dart';
import 'package:provider/provider.dart';


class ModePageView extends StatefulWidget {
  const ModePageView({Key? key}) : super(key: key);

  @override
  State<ModePageView> createState() => _ModePageViewState();
}

class _ModePageViewState extends State<ModePageView> {

  String _selectedOption = AppString.modeChild;

  Future<String?> retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('mode');
    return data;
  }

  Future<void> storeData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mode", data);
  }

  @override
  Widget build(BuildContext context) {
    final providerModeData = Provider.of<ModeDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.modeTitle),
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: FutureBuilder(
        future: retrieveData(),
        builder: (BuildContext context, AsyncSnapshot<String?>snapshot) {
          _selectedOption = snapshot.data ?? '';
          return Column(
            children: <Widget>[
              RadioListTile(
                title: Text(
                  AppString.modeChild,
                  style: getLargeRegularStyle(color: ColorManager.black),
                ),
                value: AppString.modeChild,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                  storeData(value!);
                  providerModeData.name = value;
                },
              ),
              Divider(color: ColorManager.darkGrey, thickness: 1.0,),
              RadioListTile(
                title: Text(
                  AppString.modeOld,
                  style: getLargeRegularStyle(color: ColorManager.black),
                ),
                value: AppString.modeOld,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                  storeData(value!);
                  providerModeData.name = value;
                },
              ),
              Divider(color: ColorManager.darkGrey, thickness: 1.0,),
              RadioListTile(
                title: Text(
                  AppString.modeRap,
                  style: getLargeRegularStyle(color: ColorManager.black),
                ),
                value: AppString.modeRap,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                  storeData(value!);
                  providerModeData.name = value;
                },
              ),
              Divider(color: ColorManager.darkGrey, thickness: 1.0,),
            ],
          );
        },
      ),
    );
  }
}
