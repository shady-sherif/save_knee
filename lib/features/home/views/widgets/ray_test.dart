import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_knee_23/constants.dart';
import 'package:save_knee_23/screens/xray_result_screen.dart';
import 'package:save_knee_23/widgets/bottom_sheet.dart';
import 'package:save_knee_23/widgets/custom_appbar.dart';

import '../../../../core/utils/local_tflite_service.dart';

class XRayScreenT extends StatefulWidget {
  const XRayScreenT({super.key});

  @override
  State<XRayScreenT> createState() => _XRayScreenTState();
}

class _XRayScreenTState extends State<XRayScreenT> {
  File? image;
  ImagePicker imagePicker = ImagePicker();
  late String result;
  String? label;
  late KneeOAClassifier classifier;
  String predictionResult = "Loading...";

  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      String fileName = _extractFileName(pickedFile.path);
      print("Picked file name: $fileName");
      result = (await classifier.predict(image!.readAsBytesSync()));
      setState(() {
        image;
      });

      // Classify the image based on the pattern in the file name
      // if (fileName == '9003316L.png' || fileName == '9003175R.png') {
      //   result = 'Normal';
      // } else if (fileName == '1000398015.jpg' || fileName == '1000417408.png') {
      //   result = 'Moderate';
      // } else if (fileName == '1000398017.jpg' || fileName == '1000398023.jpg') {
      //   result = 'Severe';
      // } else {
      //   result = 'Fady';
      // }

      print("Result: $result");
      setState(() {});
    }
  }

  bool _matchesPattern(String fileName, List<String> patterns) {
    for (String pattern in patterns) {
      if (fileName.contains(pattern)) {
        return true;
      }
    }
    return false;
  }

  String _extractFileName(String filePath) {
    return filePath.split('/').last;
  }

  void _showProgressIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    classifier = KneeOAClassifier();
    WidgetsBinding.instance.addPostFrameCallback((_) => classifier.loadModel());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppBar(
            title: 'Your X-ray',
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/test_bg.jpg'),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              image == null
                  ? CircleAvatar(
                      radius: 100.r,
                      backgroundColor: kHomeScreenColor,
                      child: CircleAvatar(
                        radius: 95.r,
                        backgroundImage:
                            const AssetImage('assets/images/bg_circle.png'),
                      ))
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: kHomeScreenColor),
                      ),
                      child: Image.file(
                        image!,
                        width: 180.w,
                        height: 180.h,
                        fit: BoxFit.fill,
                      ),
                    ),
              const Spacer(flex: 2),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    gradient: LinearGradient(
                        colors: [kHomeScreenColor, Colors.black])),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kHomeScreenColor,
                        fixedSize: Size(220.w, 40.h)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => CustomBottomSheet(
                                context,
                                galleryFunction: _imgFromGallery,
                              ));
                    },
                    child: Text(
                      'Choose X-ray Image',
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    )),
              ),
              const Spacer(flex: 1),
              Container(
                decoration: BoxDecoration(
                  color: kHomeScreenColor,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kHomeScreenColor,
                      fixedSize: Size(100.w, 15.h),
                    ),
                    onPressed: () {
                      if (image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please upload an image"),
                          ),
                        );
                      } else {
                        _showProgressIndicator(context);
                        Future.delayed(const Duration(seconds: 6), () {
                          Navigator.pop(
                              context); // close the progress indicator
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return XRayResultScreen(image!, result);
                          }));
                        });
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    )),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
