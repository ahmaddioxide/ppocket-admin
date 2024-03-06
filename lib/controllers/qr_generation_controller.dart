import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:ppocket_admin/models/upload_data_model.dart';
import 'package:ppocket_admin/services/storage_services.dart';

import '../services/firestore_services.dart';

class QrGenerationController extends GetxController {
  RxBool isQrGenerated = false.obs;
  RxString qrData = ''.obs;

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
    pickFileFromPc().then((pickedFilesList) async {
      int? totalAmount;
      // print(pickedFilesList![0].name);
      // print(pickedFilesList[1].name);
      //Pass File which's Extension is txt to get the total
      if (pickedFilesList![0].extension == 'txt') {
        totalAmount = await readFileAndGetTotal(pickedFilesList[0]);
      } else {
        totalAmount = await readFileAndGetTotal(pickedFilesList[1]);
      }
      await uploadFilesToStorage(pickedFilesList).then((
        uploadedUrlsObject,
      ) {
        uploadedUrlsObject.total = totalAmount??0;
        print("\nData TO uploaded$uploadedUrlsObject");
        FireStoreServices.saveReceiptsToFirestore(uploadedUrlsObject)
            .then((value) {
          print("Urls saved to firestore");
          isQrGenerated.value = true;
          if (value != null) {
            qrData.value = value;
          }
        }).onError((error, stackTrace) {
          print("Error while saving urls to firestore ${error.toString()}");
          return Future.error("Error while saving urls to firestore");
        });
      });
    });
  }

  Future<int?> readFileAndGetTotal(PlatformFile file) async {
    final String content = readTextFile(file);
    final total = await getTotalFromTheTextFile(content);
    // the total amount contains $ sign , and .00 at the end
    //remove $ sign and .00 from the total amount
    final totalAmount =
        total?.replaceAll('\$', '').replaceAll('.00', '').replaceAll(',', '');
    print("Total amount is $totalAmount");
    return int.parse(totalAmount!);
  }

  String readTextFile(PlatformFile file) {
    // //Print file name and file extension
    // print("File Name: ${file.name}");
    // print("File Extension: ${file.extension}");

    //Reading  the file
    Uint8List? textFile = file.bytes;
    //unit 8 list to string
    String contents = String.fromCharCodes(textFile!);
    // replace weird characters with empty string
    contents = contents.replaceAll('â¬â', '');
    contents = contents.replaceAll('â­âª', '');
    contents = contents.replaceAll('Â', '');
    contents = contents.replaceAll('â¬', '');
    contents = contents.replaceAll('âª', '');
    contents = contents.replaceAll('Ž', '');

    // print("File Contents: $contents");

    //replace extra spaces with single space
    // contents = contents.replaceAll(RegExp(r'\s+'), ' ');
    print("File Contents: $contents");

    return contents;
  }

  Future<String?> getTotalFromTheTextFile(String content) async {
    // Read the file content
    // Split the content by line breaks
    final lines = content.split('\n');

    // Find the line containing "TOTAL:"
    for (final line in lines) {
      if (line.toUpperCase().contains("TOTAL:")) {
        // Extract the total value from the next line
        if (lines.indexOf(line) + 1 < lines.length) {
          final totalLine = lines[lines.indexOf(line) + 1];
          // Extract the numeric part (assuming it's the first sequence of digits) and start with $ sign and have , in between and end with .00
          final totalMatch = RegExp(r'\$[0-9,]+\.00').firstMatch(totalLine);
          if (totalMatch != null) {
            return totalMatch.group(0)!;
          } else {
            return "Total amount not found";
          }
        } else {
          return "Total amount not found";
        }
      }
    }
    return "Total not found";
  }
}
