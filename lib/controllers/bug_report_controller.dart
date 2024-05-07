import 'package:get/get.dart';
import 'package:ppocket_admin/services/firestore_services.dart';

class BugReportsController extends GetxController {
  var bugReports = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBugReports();
  }

  Future<void> fetchBugReports() async {
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = '';

    try {
      bugReports.value = await FireStoreServices.getAllBugReports();
    } catch (e) {
      isError.value = true;
      errorMessage.value = "Error fetching bug reports: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
