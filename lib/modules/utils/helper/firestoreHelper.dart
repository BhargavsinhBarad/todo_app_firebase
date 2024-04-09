import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firebase/modules/utils/helper/AuthHelper.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addtask(
      {required Map<String, dynamic> data, required String id}) async {
    return await firestore
        .collection("${AuthHelper.authHelper.auth.currentUser!.email}")
        .doc("${id}")
        .set(data);
  }

  Future<Stream<QuerySnapshot>> fetchtask() async {
    return firestore
        .collection("${AuthHelper.authHelper.auth.currentUser!.email}")
        .snapshots();
  }

  Future updatetask(
      {required Map<String, dynamic> newdata, required String id}) async {
    return await firestore
        .collection("${AuthHelper.authHelper.auth.currentUser!.email}")
        .doc("${id}")
        .update(newdata);
  }

  Future deteletask({required String id}) async {
    return await firestore
        .collection("${AuthHelper.authHelper.auth.currentUser!.email}")
        .doc("${id}")
        .delete();
  }
}
