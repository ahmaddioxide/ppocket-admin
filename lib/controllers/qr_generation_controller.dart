import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:ppocket_admin/models/upload_data_model.dart';
import 'package:ppocket_admin/services/firestore_services.dart';
import 'package:ppocket_admin/services/storage_services.dart';

class QrGenerationController extends GetxController {
  RxBool isQrGenerated = false.obs;

  Future<List<PlatformFile>?> pickFileFromPc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // initialDirectory:
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'txt'],
    );
    if (result != null) {
      final file = result.files.first;
      print(file.name);
      return result.files;
    } else {
      return null;
    }
  }

  Future<UploadableDataUrls> uploadFilesToStorage(
      List<PlatformFile>? filesList) async {
    if (filesList == null) {
      return Future.error("No files selected");
    }
    UploadableDataUrls urls =
        await FirebaseStorageService.uploadFilesToStorage(filesList);
    return urls;
  }

  Future<void> pickUploadFiles() async {
    pickFileFromPc().then((pickedFilesList) {
      print(pickedFilesList![0].name);
      print(pickedFilesList[1].name);
      uploadFilesToStorage(pickedFilesList).then((uploadedUrlsObject) {
        print(
            "Image URL to Upload in Firestore " + uploadedUrlsObject.imageUrl);
        print('Text URL to store in FireStore' + uploadedUrlsObject.textUrl);

        FireStoreServices.saveUrlsToFirestore(uploadedUrlsObject).then((_) {
          print("Urls saved to firestore");
        });
      });
    });
  }
}
