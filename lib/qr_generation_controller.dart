import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:ppocket_admin/models/upload_data_model.dart';
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
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
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
    pickFileFromPc().then((value) async {
      print(value![0].name);
      print(value![1].name);

      await uploadFilesToStorage(value).then((value){
        print(value.imageUrl);
        print(value.textUrl);
      });
    });

    // pickFileFromPc().then(
    //     (value) => uploadFilesToStorage(value).then((value) => print(value.imageUrl)));
  }
}
