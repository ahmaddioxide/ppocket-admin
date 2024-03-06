import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final receiptsRef = FirebaseFirestore.instance.collection('receipts');

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
}
