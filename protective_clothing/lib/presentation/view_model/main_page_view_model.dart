import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:protective_clothing/presentation/resources/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:direct_sms/direct_sms.dart';
import '../../data/firebase_repository.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class MainPageViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseRepository _repository = FirebaseRepository();
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);
      prefs.setStringList('user', []);
      prefs.setStringList('numberList', []);
      prefs.setString('mode', '');
      prefs.setString('selectedOption', '');
      prefs.setBool('isLocChecked', false);
      prefs.setString('numberCalling', '');
      prefs.setString('msg', '');
      prefs.setString('firstName', '');
      prefs.setString('lastName', '');
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  void makePhoneCallAndMsg(ReadingModel readingModel) async {
    if(!readingModel.previouslyDone) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<String>? numberList = preferences.getStringList('numberList');
      String? msg = preferences.getString('msg');
      String? number = preferences.getString('numberCalling');
      String? alertType = preferences.getString('selectedOption');
      bool? isLocChecked = preferences.getBool("isLocChecked");
      double lat = readingModel.lat;
      double lang = readingModel.lang;
      _makePhoneCall(number);
      _sendMsg(numberList, msg, lat, lang, isLocChecked);
      _alert(alertType);
      _repository.updatePreviouslyDone(readingModel);
    }
  }

  void _makePhoneCall(String? number) async {
    if(number != null) {
      await FlutterPhoneDirectCaller.callNumber(number);
    }
  }

  void _sendMsg(List<String>? numberList, String? msg, double lat, double lang, bool? isLocChecked) {
    if(numberList != null && msg != null) {
      if(isLocChecked != null && isLocChecked == true) {
        msg = "$msg. Here is my location https://www.google.com/maps/place/$lat,$lang";
      } else {
        //nothing
      }
      for (var number in numberList) {
        DirectSms().sendSms(phone: number, message: msg);
      }
    }
  }

  void _alert(String? alertType) {
    if(alertType == AppString.alertVibAndRng) {
      FlutterRingtonePlayer.playRingtone(
        volume: 1.0,
        looping: false,
      );
      Vibration.vibrate(amplitude: 128, duration: 60000, pattern: [500, 1000, 500, 2000, 500, 3000, 500, 4000, 500, 5000, 500,
        6000, 500, 7000, 500, 6000, 500, 5000, 500, 4000, 500, 3000, 500, 2000, 500, 1000, 500, 500]);
    } else if(alertType == AppString.alertOnlyRng) {
      FlutterRingtonePlayer.playRingtone(
        volume: 1.0,
        looping: false,
      );
    } else if(alertType == AppString.alertOnlyVib) {
      Vibration.vibrate(amplitude: 128, pattern: [500, 1000, 500, 2000, 500, 3000, 500, 4000, 500, 5000, 500,
        6000, 500, 7000, 500, 6000, 500, 5000, 500, 4000, 500, 3000, 500, 2000, 500, 1000, 500, 500]);
    } else if(alertType == AppString.alertSlnc) {
      //nothing
    }
  }
}

class ReadingModel{
  late final String chestLeft;
  late final String chestRight;
  final String chestLeftTitle = "Left Chest";
  final String chestRightTitle = "Right Chest";
  late final String sleeveLeft;
  late final String sleeveRight;
  late final DateTime timeStamp;
  late final double lat;
  late final double lang;
  late final bool previouslyDone;

  ReadingModel(this.chestLeft, this.chestRight, this.sleeveLeft, this.sleeveRight, this.timeStamp, this.lat, this.lang, this.previouslyDone);

  ReadingModel.fromJSON(Map<String, dynamic> json)
    : chestLeft = json["chest_left"] == null ? "" : json['chest_left'],
      chestRight = json["chest_right"] == null ? "" : json['chest_right'],
      sleeveLeft = json["sleeve_left"] == null ? "" : json['sleeve_left'],
      sleeveRight = json["sleeve_right"] == null ? "" : json['sleeve_right'],
      timeStamp = json["timestamp"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(int.parse(json['timestamp']) * 1000),
      lat = json["lat"] == null ? double.parse("0") : double.parse(json['lat']),
      lang = json["lang"] == null ? double.parse("0") : double.parse(json['lang']),
      previouslyDone = json["previouslyDone"] == null ? false : json['previouslyDone'] == "true";
}

// class ReadingData {
//   late final String title;
//   late final Map<String, dynamic> readingData;
//
//   ReadingData.fromJSON(Map<String, dynamic> json)
//     : title = json[''],
//       readingData = json[''].entries.map((entry) => )
// }