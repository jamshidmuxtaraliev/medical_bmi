import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_bmi/api/main_viewmodel.dart';
import 'package:medical_bmi/models/report_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_bmi/utility/color_utility.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../home/home_page.dart';

class SendReportScreen extends StatefulWidget {
  ReportModel currentReport;

  SendReportScreen({Key? key, required this.currentReport}) : super(key: key);

  @override
  State<SendReportScreen> createState() => _SendReportScreenState();
}

class _SendReportScreenState extends State<SendReportScreen> {
  var activeButton = false;

  String imagePath = "";
  String imagePath2 = "";
  String imagePath3 = "";
  String projectId = "";
  var commentController = TextEditingController();
  var titleController = TextEditingController();

  bool isReport = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () {
        return MainViewModel();
      },
      builder: (BuildContext context, MainViewModel viewModel, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF40858B),
                title: Text("Hisobot yuborish"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Topshiriq:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.currentReport.text ?? "Yangi topshiriq",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        (isReport == false) ? "Hisobotni shakllantiring :" : "",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      if (isReport == false)
                        Column(
                          children: [
                            TextField(
                              controller: titleController,
                              textInputAction: TextInputAction.next,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.name,
                              style:
                                  const TextStyle(fontSize: 16, fontFamily: "regular", color: Colors.black),
                              maxLines: 1,
                              onChanged: (text) {
                                setState(() {
                                  activeButton = getActiveButton();
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8, right: 8),
                                border: myInputBorder(1),
                                //normal border
                                enabledBorder: myInputBorder(1),
                                //enabled border
                                focusedBorder: myInputBorder(2),
                                filled: true,
                                hintStyle: const TextStyle(color: Colors.grey),
                                hintText: "Sarlavha matni",
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: commentController,
                              minLines: 7,
                              maxLines: 7,
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Hisobot to'liq matni...",
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: myInputBorder(1),
                                //normal border
                                enabledBorder: myInputBorder(1),
                                //enabled border
                                focusedBorder: myInputBorder(2),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  activeButton = getActiveButton();
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showImageDialog(1);
                                  },
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.green, width: 1)),
                                      child: imagePath.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.file(
                                                File(imagePath),
                                                fit: BoxFit.cover,
                                              ))
                                          : Center(
                                              child: Image.asset(
                                              "assets/images/gallery.png",
                                              height: 64,
                                              width: 64,
                                            ))),
                                ),
                                InkWell(
                                  onTap: () {
                                    showImageDialog(2);
                                  },
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.green, width: 1)),
                                      child: imagePath2.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.file(
                                                File(imagePath2),
                                                fit: BoxFit.cover,
                                              ))
                                          : Center(
                                              child: Image.asset(
                                              "assets/images/gallery.png",
                                              height: 64,
                                              width: 64,
                                            ))),
                                ),
                                InkWell(
                                  onTap: () {
                                    showImageDialog(3);
                                  },
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.green, width: 1)),
                                      child: imagePath3.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.file(
                                                File(imagePath3),
                                                fit: BoxFit.cover,
                                              ))
                                          : Center(
                                              child: Image.asset(
                                              "assets/images/gallery.png",
                                              height: 64,
                                              width: 64,
                                            ))),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            viewModel.progressData
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SizedBox(
                                    height: 55,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(
                                              !activeButton ? Colors.grey : Color(0xFF5DB09E)),
                                        ),
                                        onPressed: () {
                                          viewModel.sendReport(
                                            titleController.text,
                                            commentController.text,
                                            widget.currentReport.id,
                                            imagePath,
                                            imagePath2,
                                            imagePath3,
                                          );
                                          // if (activeButton) {
                                          //   viewModel.sendReport(
                                          //       titleController.text,
                                          //       commentController.text,
                                          //       widget.currentReport.id,
                                          //       imagePath,);
                                          // } else {
                                          //   ScaffoldMessenger.maybeOf(context)
                                          //       ?.showSnackBar(SnackBar(content: Text("Barcha malumotlarni to'ldiring")));
                                          // }
                                        },
                                        child: const Text(
                                          "Yuborish",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                          ],
                        ),
                      if (isReport == true)
                        const SizedBox(
                          height: 200,
                          child: Text(
                            "Siz allaqachon hisobotni yuklagansiz !",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            if (viewModel.progressData) showMyProgress()
          ],
        );
      },
      onViewModelReady: (viewModel) {
        viewModel.isYesReport(widget.currentReport.id);

        viewModel.yesReportData.listen((event) {
          setState(() {
            isReport = (event.id!=null);
          });
        });

        viewModel.errorData.listen((event) {
          CherryToast.error(
            title: const Text('Error'),
            enableIconAnimation: false,
            displayTitle: false,
            description: Text(event),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true,
          ).show(context);
        });

        viewModel.sendReportData.listen((event) async {
          CherryToast.success(
            title: const Text('Ajoyib !'),
            enableIconAnimation: false,
            displayTitle: false,
            description: Text("Hisobotlar muvaffaqiyatli yuborildi !"),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 1000),
            autoDismiss: true,
          ).show(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      },
    );
  }

  void showImageDialog(int type) {
    final ImagePicker _picker = ImagePicker();
    final alert = AlertDialog(
      backgroundColor: Colors.green.withOpacity(.8),
      title: Text("MANBAANI TANLANG", style: TextStyle(color: Colors.white)),
      content: Text(""),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final image = await _picker.pickImage(
                  source: ImageSource.camera, imageQuality: 60, maxHeight: 1000, maxWidth: 1000);
              if (image != null) {
                var croppedFile = await ImageCropper().cropImage(
                  sourcePath: image.path,
                  compressQuality: 60,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.ratio16x9,
                  ],
                );
                if (croppedFile != null) {
                  setState(() {
                    if (type == 1) {
                      imagePath = croppedFile.path;
                    } else if (type == 2) {
                      imagePath2 = croppedFile.path;
                    } else {
                      imagePath3 = croppedFile.path;
                    }
                  });
                }
              }
            },
            child: Text(
              "KAMERA",
              style: TextStyle(color: Colors.black),
            )),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            final image = await _picker.pickImage(
                source: ImageSource.gallery, imageQuality: 60, maxHeight: 1000, maxWidth: 1000);
            if (image != null) {
              var croppedFile = await ImageCropper().cropImage(
                sourcePath: image.path,
                compressQuality: 60,
                aspectRatioPresets: [
                  CropAspectRatioPreset.ratio16x9,
                ],
              );
              if (croppedFile != null) {
                // final size = (await croppedFile.length()) / 1024 / 1024;
                setState(() {
                  setState(() {
                    if (type == 1) {
                      imagePath = croppedFile.path;
                    } else if (type == 2) {
                      imagePath2 = croppedFile.path;
                    } else {
                      imagePath3 = croppedFile.path;
                    }
                  });
                });
              }
            }
          },
          child: Text("GALEREYA", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  bool getActiveButton() {
    return (titleController.text.length > 3 && commentController.text.length > 3);
  }

  OutlineInputBorder myInputBorder(int type) {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: (type == 1) ? Colors.blueGrey : Colors.lightBlueAccent,
          width: 1,
        ));
  }
}
