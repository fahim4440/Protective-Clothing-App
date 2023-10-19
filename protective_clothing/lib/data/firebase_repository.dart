import 'package:firebase_database/firebase_database.dart';
import '../presentation/view_model/main_page_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  final DatabaseReference _reference = FirebaseDatabase.instance.ref();

  void updatePreviouslyDone(ReadingModel readingModel) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String userUid = "";
    String time = (readingModel.timeStamp.millisecondsSinceEpoch ~/ 1000).toString();
    if(currentUser != null) {
      userUid = currentUser.uid;
    }
    await _reference.child("UsersData/$userUid/readings/$time").update({
      "previouslyDone": true,
    });
  }
}