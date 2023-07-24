import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static saveUrlsToFirestore(uploadableDataUrls) async {
    await _firestore.collection('urls').add(uploadableDataUrls.toMap());
  }
}
