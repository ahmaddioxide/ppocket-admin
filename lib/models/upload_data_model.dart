import 'package:cloud_firestore/cloud_firestore.dart';

class UploadableDataUrls {
   String imageUrl;
 String textUrl;
 int total;

  updateImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  updateTextUrl(String newTxtUrl) {
    textUrl = newTxtUrl;
  }

  UploadableDataUrls({required this.imageUrl, required this.textUrl,required this.total});

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'txtUrl': textUrl,
      'total': total,
    };
  }


  UploadableDataUrls.fromDataSnapshot({
    required DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  })  : imageUrl = documentSnapshot.data()!['imageUrl'],
        textUrl = documentSnapshot.data()!['txtUrl'],
         total = documentSnapshot.data()!['total'];

   //toString
   @override
   String toString() {
     return 'UploadableDataUrls{imageUrl: $imageUrl, textUrl: $textUrl, total: $total}';
   }
}

