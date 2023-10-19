import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protective_clothing/presentation/resources/style_manager.dart';
import '../resources/string_manager.dart';
import '../resources/color_manager.dart';
import '../resources/value_manager.dart';
import '../resources/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {

  bool isChecked = false;
  String _selectedOption = AppString.alertVibAndRng;
  final TextEditingController _textEditingController = TextEditingController();
  String _numberCalling = "";
  String _msg = "";

  Future<bool?> retrieveIsCheckedLoc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isChecked = prefs.getBool('isLocChecked');
    return isChecked;
  }

  Future<void> storeIsCheckedLoc(bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLocChecked', isChecked);
  }

  Future<String?> retrieveAlertTypeSelectedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedOption = prefs.getString('selectedOption');
    return selectedOption;
  }

  Future<void> storeAlertTypeSelectedOption(String selectedOption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedOption', selectedOption);
  }

  Future<String?> retrieveNumberCalling() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? numberCalling = prefs.getString('numberCalling');
    return numberCalling;
  }

  Future<void> storeNumberCalling(String numberCalling) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('numberCalling', numberCalling);
  }

  Future<String?> retrieveMsg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? msg = prefs.getString('msg');
    return msg;
  }

  Future<void> storeMsg(String msg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('msg', msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.settings),
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p8,),
        children: <Widget> [
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    AppString.settingAlert,
                    style: getLargeRegularStyle(color: ColorManager.black),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    child: FutureBuilder(
                      future: retrieveAlertTypeSelectedOption(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData) {
                          _selectedOption = snapshot.data;
                        }
                        return Text(
                          _selectedOption,
                          style: getMediumStyle(color: ColorManager.grey),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        backgroundColor: ColorManager.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r20),
                        ),
                        title: const Text(AppString.settingAlert),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 230,
                          child: ListView(
                            children: <Widget>[
                              RadioListTile(
                                title: Text(
                                  AppString.alertVibAndRng,
                                  style: getLargeRegularStyle(color: ColorManager.black),
                                ),
                                value: AppString.alertVibAndRng,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                    this.setState(() {});
                                  });
                                  storeAlertTypeSelectedOption(value!);
                                },
                              ),
                              RadioListTile(
                                title: Text(
                                  AppString.alertOnlyRng,
                                  style: getLargeRegularStyle(color: ColorManager.black),
                                ),
                                value: AppString.alertOnlyRng,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                    this.setState(() {});
                                  });
                                  storeAlertTypeSelectedOption(value!);
                                },
                              ),
                              RadioListTile(
                                title: Text(
                                  AppString.alertOnlyVib,
                                  style: getLargeRegularStyle(color: ColorManager.black),
                                ),
                                value: AppString.alertOnlyVib,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                    this.setState(() {});
                                  });
                                  storeAlertTypeSelectedOption(value!);
                                },
                              ),
                              RadioListTile(
                                title: Text(
                                  AppString.alertSlnc,
                                  style: getLargeRegularStyle(color: ColorManager.black),
                                ),
                                value: AppString.alertSlnc,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value!;
                                    this.setState(() {});
                                  });
                                  storeAlertTypeSelectedOption(value!);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  );
                },
              );
            },
          ),
          Divider(
            color: ColorManager.darkGrey,
            thickness: 1.0,
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    AppString.settingSetNumCall,
                    style: getLargeRegularStyle(color: ColorManager.black),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    child: FutureBuilder(
                      future: retrieveNumberCalling(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData) {
                          _numberCalling = snapshot.data;
                        }
                        return Text(
                          _numberCalling,
                          style: getMediumStyle(color: ColorManager.grey),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: ColorManager.backgroundColor,
                    title: const Text(AppString.alertSetMobileTitle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r20),
                    ),
                    content: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: AppString.hintSetNum,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text(AppString.ok),
                        onPressed: () {
                          String newNumber = _textEditingController.text;
                          setState(() {
                            bool unique = _numberCalling != newNumber && newNumber.length == 11;
                            if (unique) {
                              _numberCalling = newNumber;
                              storeNumberCalling(newNumber);
                            }
                            _textEditingController.clear();
                          });
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text(AppString.cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
              );
            },
          ),
          Divider(
            color: ColorManager.darkGrey,
            thickness: 1.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FutureBuilder(
                future: retrieveIsCheckedLoc(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    isChecked = snapshot.data;
                  }
                  return CheckboxListTile(
                    title: Text(
                      AppString.settingMsgLoc,
                      style: getLargeRegularStyle(color: ColorManager.black),
                    ),
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                      storeIsCheckedLoc(value!);
                    },
                  );
                },
              ),
            ),
          ),
          Divider(
            color: ColorManager.darkGrey,
            thickness: 1.0,
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    AppString.settingMsg,
                    style: getLargeRegularStyle(color: ColorManager.black),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    child: FutureBuilder(
                      future: retrieveMsg(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData) {
                          _msg = snapshot.data;
                        }
                        return Text(
                          _msg,
                          style: getMediumStyle(color: ColorManager.grey),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: ColorManager.backgroundColor,
                    title: const Text(AppString.alertSetMsg),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r20),
                    ),
                    content: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: AppString.hintMsg,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text(AppString.ok),
                        onPressed: () {
                          String newMsg = _textEditingController.text;
                          setState(() {
                            bool unique = _msg != newMsg;
                            if (unique) {
                              _msg = newMsg;
                              storeMsg(newMsg);
                            }
                            _textEditingController.clear();
                          });
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text(AppString.cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Divider(
            color: ColorManager.darkGrey,
            thickness: 1.0,
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppString.settingSetNumMsg,
                  style: getLargeRegularStyle(color: ColorManager.black),
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.mobileNumber);
            },
          ),
          Divider(
            color: ColorManager.darkGrey,
            thickness: 1.0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }
}
