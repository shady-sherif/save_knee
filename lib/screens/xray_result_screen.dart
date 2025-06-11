import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import '../widgets/custom_appbar.dart';

class XRayResultScreen extends StatefulWidget {
  final File? _image;
  final String result;

  const XRayResultScreen(this._image, this.result, {super.key});

  @override
  State<XRayResultScreen> createState() => _XRayResultScreenState();
}

class _XRayResultScreenState extends State<XRayResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: CustomAppBar(
            title: 'Your Result',
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: kHomeScreenColor),
                ),
                child: Image.file(
                  widget._image!,
                  width: 180.w,
                  height: 180.h,
                  fit: BoxFit.fill,
                ),
              ),
              const Spacer(flex: 2),
              Container(
                height: 80.h,
                width: MediaQuery.of(context).size.width * .75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0).w,
                    gradient: LinearGradient(
                        colors: [kHomeScreenColor, Colors.black])),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      widget.result,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
