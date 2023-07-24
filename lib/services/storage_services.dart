import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ppocket_admin/models/upload_data_model.dart';

class FirebaseStorageService {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final receiptsRef = FirebaseStorage.instance.ref().child('receipts');

  static Future<UploadableDataUrls> uploadFilesToStorage(
      List<PlatformFile>? filesList) async {
    // final List<UploadableDataUrls> urlsList = []
    // final List<String> urls = [];
    UploadableDataUrls urls = UploadableDataUrls(imageUrl: '', textUrl: '');

    try {
      filesList!.forEach((file) async {
        final ref = receiptsRef.child("${DateTime.now()}${file.name}");
        final uploadTask = ref.putData(file.bytes!);
        final snapshot = await uploadTask.whenComplete(() => null);
        final url = await snapshot.ref.getDownloadURL().then((value){
          print(value);
          return value;
        });
        if (file.extension == 'png') {
          urls.updateImageUrl(url);
        } else if (file.extension == 'txt') {
          urls.updateTextUrl(url);
        }
      });
    } on Exception catch (e) {
      print(e);
    }
    return urls;
  }
}
