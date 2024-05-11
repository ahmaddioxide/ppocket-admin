import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ppocket_admin/components/snackbars.dart';
import 'package:ppocket_admin/services/database_service.dart';

class BugReportController extends GetxController {
  final TextEditingController bugDescriptionController =
      TextEditingController();
  RxList bugReports = [].obs;


  // Get all bug reports
  Future<void> getBugReports() async {
    try {
      final List<Map<String, dynamic>> reports =
          await FireStoreService.getAllBugReports();
      bugReports.assignAll(reports);
    } catch (error) {
      AppSnackBar.errorSnackbar(
        title: 'Error',
        message: 'Failed to get bug reports: $error',
      );
    }
  }
}
