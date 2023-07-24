import 'package:cloud_firestore/cloud_firestore.dart';

class UploadableDataUrls {
   String imageUrl;
 String textUrl;

  updateImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  updateTextUrl(String newTxtUrl) {
    textUrl = newTxtUrl;
  }

  UploadableDataUrls({required this.imageUrl, required this.textUrl});

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'txtUrl': textUrl,
    };
  }


  UploadableDataUrls.fromDataSnapshot({
    required DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  })  : imageUrl = documentSnapshot.data()!['imageUrl'],
        textUrl = documentSnapshot.data()!['txtUrl'];
}
