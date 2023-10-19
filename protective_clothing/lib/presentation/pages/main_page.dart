import 'package:flutter/material.dart';
import '../resources/string_manager.dart';
import '../resources/color_manager.dart';
import '../resources/value_manager.dart';
import '../resources/style_manager.dart';
import '../resources/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../domain/mode_data_provider.dart';
import '../view_model/main_page_view_model.dart';
import 'package:firebase_database/firebase_database.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  String mode = AppString.childMode;

  Future<String?> retrieveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('mode');
    return data;
  }
  
  Future<String?> retrieveFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? user = preferences.getStringList('user');
    return user?[2];
  }

  Future<String?> retrieveUid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? user = preferences.getStringList('user');
    return user?[0];
  }

  @override
  Widget build(BuildContext context) {
    final providerModeData = Provider.of<ModeDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appTitle,),
        actions: <Widget>[
          PopupMenuButton(
            color: ColorManager.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r8),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: '1',
                  child: Text(AppString.settings, style: getMediumRegularStyle(color: ColorManager.black)),
                ),
                PopupMenuItem(
                  value: '2',
                  child: Text(AppString.mode, style: getMediumRegularStyle(color: ColorManager.black),),
                ),
                PopupMenuItem(
                  value: '3',
                  child: Text(AppString.about, style: getMediumRegularStyle(color: ColorManager.black),),
                ),
                PopupMenuItem(
                  value: '4',
                  child: Text(AppString.signOut, style: getMediumRegularStyle(color: ColorManager.black),),
                ),
              ];
            },
            onSelected: (value) async {
              if(value == '1') {
                Navigator.pushNamed(context, Routes.settingRoute);
              } else if(value == '2') {
                Navigator.pushNamed(context, Routes.modeRoute);
              } else if(value == '3') {
                Navigator.pushNamed(context, Routes.aboutRoute);
              } else if(value == '4') {
                bool isSignOut = await MainPageViewModel().signOut();
                if(isSignOut) {
                  Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute, (Route<dynamic> route) => false);
                }
              }
            },
          ),
        ],
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: retrieveFirstName(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  width: MediaQuery.of(context).size.width - AppPadding.p8,
                  height: AppSize.s80,
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Text(
                    "Welcome ${snapshot.data}!",
                    style: getExtraLargeBoldStyle(color: ColorManager.primary),
                  ),
                );
              }
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
            ),
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r30),
                ),
                child: Container (
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FutureBuilder(
                      future: retrieveData(),
                      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                        return Text(
                          "Mode: ${providerModeData.name == "" ? snapshot.data : providerModeData.name}",
                          textAlign: TextAlign.center,
                          style: getLargeRegularStyle(color: ColorManager.black),
                        );
                      },
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.modeRoute);
                },
              ),
            ),
            FutureBuilder(
              future: retrieveUid(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return StreamBuilder(
                  stream: FirebaseDatabase.instance.ref('UsersData/${snapshot.data}/readings').onValue,
                  builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> event) {
                    var data = event.data?.snapshot.children;
                    List<ReadingModel> readingModelData = [];
                    data?.forEach((element) {
                      Map<String, String> readingData = {};
                      element.children.forEach((e) {
                        readingData.addAll({
                          e.key.toString() : e.value.toString(),
                        });
                      });
                      ReadingModel data = ReadingModel.fromJSON(readingData);
                      readingModelData.add(data);
                    });
                    if(readingModelData.isNotEmpty) {
                      MainPageViewModel().makePhoneCallAndMsg(readingModelData.last);
                      if(readingModelData.last.chestRight == 'touched') {
                        return Column(
                            children: [
                              // Text(
                              //   "${readingModelData.last.timeStamp.year}/${readingModelData.last.timeStamp.month}/${readingModelData.last.timeStamp.day}/${readingModelData.last.timeStamp.hour}/${readingModelData.last.timeStamp.minute}/${readingModelData.last.timeStamp.second}/",
                              //   style: getLargeBoldStyle(color: ColorManager.primary),
                              // ),
                              Text(
                                "Chest Right : ${readingModelData.last.chestRight}",
                                style: getLargeBoldStyle(color: ColorManager.primary),
                              ),
                            ]
                        );
                      } else if(readingModelData.last.chestLeft == 'touched') {
                        return Column(
                            children: [
                              Text(
                                "Chest Left : ${readingModelData.last.chestLeft}",
                                style: getLargeBoldStyle(color: ColorManager.primary),
                              ),
                            ]
                        );
                      } else if(readingModelData.last.sleeveLeft == 'touched') {
                        return Column(
                          children: [
                            Text(
                              "Sleeve Left : ${readingModelData.last.sleeveLeft}",
                              style: getLargeBoldStyle(color: ColorManager.primary),
                            ),
                          ]
                        );
                      } else if(readingModelData.last.sleeveRight == 'touched') {
                        return Column(
                            children: [
                              Text(
                                "Sleeve Right : ${readingModelData.last.sleeveRight}",
                                style: getLargeBoldStyle(color: ColorManager.primary),
                              ),
                            ]
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    } else {
                      return CircularProgressIndicator(color: ColorManager.primary,);
                    }
                  }
                );
              }
            ),
          ]
        ),
      ),
    );
  }
}
