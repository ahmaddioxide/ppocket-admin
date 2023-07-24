import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppocket_admin/controllers/qr_generation_controller.dart';

class QrGenerationScreen extends StatefulWidget {
  const QrGenerationScreen({super.key});

  @override
  State<QrGenerationScreen> createState() => _QrGenerationScreenState();
}

class _QrGenerationScreenState extends State<QrGenerationScreen> {
  final qrGenerationController = Get.put(QrGenerationController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            qrGenerationController.pickUploadFiles();
          },
          child: const Icon(Icons.qr_code),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          title: const Text(
            'QR Generation Screen',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: height,
          width: width,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return qrGenerationController.isQrGenerated.value
                    ? const Text("QR Code Generated")
                    : Container(
                        height: height * 0.4,
                        width: height * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: SizedBox(
                          height: height * 0.4,
                          width: height * 0.4,
                          child: const Center(
                            child: AutoSizeText(
                              "QR Code will be generated here",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
              }),

              // SizedBox(
              //   width: width*0.2,
              //   height: height*0.1,
              //   child: ElevatedButton(onPressed: (){}, child:const Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //     Icon(Icons.qr_code),
              //     SizedBox(width: 10,),
              //     Text("Generate QR Code")
              //   ],) ),
              // )
            ],
          ),
        ));
  }
}
