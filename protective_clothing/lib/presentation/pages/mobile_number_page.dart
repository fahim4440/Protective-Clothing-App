import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/value_manager.dart';
import '../resources/string_manager.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileNumberPageView extends StatefulWidget {
  const MobileNumberPageView({Key? key}) : super(key: key);

  @override
  State<MobileNumberPageView> createState() => _MobileNumberPageViewState();
}

class _MobileNumberPageViewState extends State<MobileNumberPageView> {
  final TextEditingController _textEditingController = TextEditingController();

  List<String> numberList = [];

  Future<List<String>?> retrieveNumberList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? numberList = prefs.getStringList('numberList');
    return numberList;
  }

  Future<void> storeNumberList(List<String> numberList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('numberList', numberList);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.mobileNumTitle),
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: FutureBuilder(
        future: retrieveNumberList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            numberList = snapshot.data;
          }
          return ListView.builder(
            itemCount: numberList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget> [
                  ListTile(
                    title: Text(
                      numberList[index],
                      style: getLargeRegularStyle(color: ColorManager.black),
                    ),
                    trailing: GestureDetector(
                      child: const Icon(Icons.cancel),
                      onTap: () {
                        setState(() {
                          numberList.remove(numberList[index]);
                        });
                        storeNumberList(numberList);
                      },
                    ),
                  ),
                  Divider(color: ColorManager.darkGrey, thickness: 1.0,),
                ]
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.darkprimary,
        child: Icon(Icons.add, color: ColorManager.white,),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r20),
                ),
                backgroundColor: ColorManager.backgroundColor,
                title: const Text(AppString.alertSetMobum),
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
                        bool unique = numberList.where((element) => element == newNumber).isEmpty && newNumber.length == 11;
                        if (unique) {
                          numberList.add(newNumber);
                          storeNumberList(numberList);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
