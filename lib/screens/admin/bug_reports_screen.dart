import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppocket_admin/controllers/bug_report_controller.dart';

class BugReportScreen extends StatelessWidget {
  final BugReportController bugReportController =
      Get.put(BugReportController());

  @override
  Widget build(BuildContext context) {
    // Fetch bug reports when screen initializes
    bugReportController.getBugReports();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff098670),
        title: const Text('Bug Reports',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.white,),
            onPressed: () {
              Get.back();

            },
          ),
        ],
      ),
      body: Obx(
        () => bugReportController.bugReports.isEmpty
            ? const Center(
                child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: bugReportController.bugReports.length,
                itemBuilder: (context, index) {
                  final bugReport = bugReportController.bugReports[index];
                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: ListTile(
                      title: Text(
                        bugReport['bug'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Reported by: ${bugReport['userId']}'),
                      
                    ),
                  );
                },
              ),
      ),
    );
  }
}
