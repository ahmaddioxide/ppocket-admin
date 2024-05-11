import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ppocket_admin/components/snackbars.dart';

class FireStoreService {
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

    static final CollectionReference bugReportsCollection =
      fireStore.collection('bugreports');

 
  static Future<void> reportBug({
    required String userId,
    required String bug,
  }) async {
    await FirebaseFirestore.instance
        .collection('bugreports')
        .add({'userId': userId, 'bug': bug}).then((_) {
    }).catchError((error) {
      AppSnackBar.errorSnackbar(
        title: 'Error',
        message: 'Error Reporting Bug to FireStore',
      );
      debugPrint('Error: $error');
    });
  }

// Get all bug reports
static Future<List<Map<String, dynamic>>> getAllBugReports() async {
    final List<Map<String, dynamic>> bugReports = [];

    await bugReportsCollection.get().then((value) {
      value.docs.forEach((doc) {
        bugReports.add(doc.data() as Map<String, dynamic>);
      });
    }).onError((error, stackTrace) {
      AppSnackBar.errorSnackbar(
        title: 'Error',
        message: 'Error Getting Bug Reports from FireStore',
      );
      if (kDebugMode) {
        print('Error Getting Bug Reports from FireStore: $error');
      }
      return Future.error(error.toString());
    });

    return bugReports;
  }

}
