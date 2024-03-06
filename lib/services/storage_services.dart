import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ppocket_admin/models/upload_data_model.dart';

class FirebaseStorageService {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final receiptsRef = FirebaseStorage.instance.ref().child('receipts');

  static Future<UploadableDataUrls> uploadFilesToStorage(
      List<PlatformFile>? filesList) async {
    final List<UploadableDataUrls> urlsList = [];
    UploadableDataUrls urls = UploadableDataUrls(imageUrl: '', textUrl: '',total: 0);

    String file0ContentType = '';
    String file1ContentType = '';
    if (filesList![0].extension == 'png') {
      file0ContentType = 'image/png';
      file1ContentType = 'text/plain';
    } else {
      file0ContentType = 'text/plain';
      file1ContentType = 'image/png';
    }

    Reference ref = receiptsRef.child("${DateTime.now()}${filesList![0].name}");
    UploadTask uploadTask = ref.putData(
      filesList[0].bytes!,
      SettableMetadata(
        contentType: file0ContentType,
      ),
    );
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    final file1Url = await snapshot.ref.getDownloadURL().then((value) {
      print('File1 Uploaded$value');
      return value;
    });
    ref = receiptsRef.child("${DateTime.now()}${filesList![1].name}");
    uploadTask = ref.putData(
      filesList[1].bytes!,
      SettableMetadata(
        contentType: file1ContentType,
      ),
    );
    snapshot = await uploadTask.whenComplete(() => null);

    final file2Url = await snapshot.ref.getDownloadURL().then((value) {
      print("File2 uploaded$value");
      return value;
    });

    if (filesList[0].extension == 'png') {
      urls.updateImageUrl(file1Url);
      urls.updateTextUrl(file2Url);
    } else {
      urls.updateImageUrl(file2Url);
      urls.updateTextUrl(file1Url);
    }

    print("Returning URL $urls.imageUrl");
    print("Returning URL $urls.textUrl");
    return urls;
  }
}
