import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppocket_admin/controllers/bug_report_controller.dart';

class BugReportsScreen extends StatelessWidget {
  final BugReportsController bugReportsController = Get.put(BugReportsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bug Reports'),
      ),
      body: Obx(
        () => bugReportsController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : bugReportsController.isError.value
                ? Center(
                    child: Text(bugReportsController.errorMessage.value),
                  )
                : bugReportsController.bugReports.isEmpty
                    ? Center(
                        child: Text('No Bug Reports found'),
                      )
                    : ListView.builder(
                        itemCount: bugReportsController.bugReports.length,
                        itemBuilder: (context, index) {
                          final report = bugReportsController.bugReports[index];
                          return ListTile(
                            title: Text(report['title']),
                            subtitle: Text(report['description']),
                            // Add more fields if needed
                          );
                        },
                      ),
      ),
    );
  }
}
