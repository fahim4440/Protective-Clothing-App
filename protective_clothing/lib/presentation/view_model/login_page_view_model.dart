import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('user', [
        user!.uid,
        user.email!,
      ]);
      prefs.setBool('isLoggedIn', true);
      await retrieveUserData(user.uid);
      Map<String, dynamic> userLogin = {
        'isLoggedIn': true,
        'error' : "No error",
      };
      return userLogin;
    } catch(e) {
      print(e.toString());
      Map<String, dynamic> userLogin = {
        'isLoggedIn' : false,
        'error' : e.toString(),
      };
      return userLogin;
    }
  }

  Future<void> retrieveUserData(String uid) async {

    DataSnapshot snapshot = await FirebaseDatabase.instance.ref('UsersData/$uid/userInfo').get();
    var userInfo = snapshot.value;
    Map<dynamic, dynamic>? map = userInfo as Map?;
    if(snapshot.exists) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<String>? user = preferences.getStringList('user');
      map?['firstName'] == null ? user?.add('') : user?.add(map?['firstName']);
      map?['lastName'] == null ? user?.add('') : user?.add(map?['lastName']);
      preferences.setStringList('user', user!);
    }
  }
}