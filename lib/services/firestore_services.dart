import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final receiptsRef = FirebaseFirestore.instance.collection('receipts');
  static final bugReportsCollection = FirebaseFirestore.instance.collection('bugReports');

  static Future<String?> saveReceiptsToFirestore(uploadableDataUrls) async {
     try {
       final value = await receiptsRef
          .add(uploadableDataUrls.toMap());
       return value.id;
     } on Exception catch (e) {
        print("Error while saving urls to firestore ${e.toString()}");
        return Future.error("Error while saving urls to firestore");
     }
  }

  // Get all bug reports
static Future<List<Map<String, dynamic>>> getAllBugReports() async {
    final List<Map<String, dynamic>> bugReports = [];

    await bugReportsCollection.get().then((value) {
      value.docs.forEach((doc) {
        bugReports.add(doc.data());
      });
    }).onError((error, stackTrace) {
      print('Error Getting Bug Reports from FireStore: $error');
      
      return Future.error(error.toString());
    });

    return bugReports;
  }

}
