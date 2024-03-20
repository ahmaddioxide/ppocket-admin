import 'package:cloud_firestore/cloud_firestore.dart';

class UploadableDataUrls {
   String imageUrl;
 String txtUrl;
 int total;
 Timestamp createdAt = Timestamp.now();


  updateImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
  }

  updateTextUrl(String newTxtUrl) {
    txtUrl = newTxtUrl;
  }

  UploadableDataUrls({required this.imageUrl, required this.txtUrl,required this.total,required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'txtUrl': txtUrl,
      'total': total,
      'createdAt': createdAt,
    };
  }


  UploadableDataUrls.fromDataSnapshot({
    required DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  })  : imageUrl = documentSnapshot.data()!['imageUrl'],
        txtUrl = documentSnapshot.data()!['txtUrl'],
         total = documentSnapshot.data()!['total'],
   createdAt = documentSnapshot.data()!['createdAt'];

   //toString
   @override
   String toString() {
     return 'UploadableDataUrls{imageUrl: $imageUrl, textUrl: $txtUrl, total: $total, createdAt: $createdAt}';
   }
}

