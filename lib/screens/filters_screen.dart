import 'dart:io';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

// final vp = PageController(viewportFraction: 20);
// Effects currentEffects = Effects.none;
// Filters currentFilters = Filters.none;
// Masks currentMask = Masks.none;

class _FiltersScreenState extends State<FiltersScreen> {
  CameraDeepArController cameraDeepArController;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          CameraDeepAr(
            iosLicenceKey: "",
            androidLicenceKey:
                '4780670a9159ad6f18754a738871fc774af54bd0a470985f5bb1c0bb3d63512f794e78db339d66ce',
            onCameraReady: (_) {},
            onVideoRecorded: (_) {},
            onImageCaptured: (_) {},
            cameraDeepArCallback: (controller) {
              cameraDeepArController = controller;
              setState(() {});
            },
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                    onPressed: () {
                      cameraDeepArController.snapPhoto();
                    },
                    child: Icon(Icons.camera_alt)),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView.builder(
                        itemCount: 8,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 16),
                        itemBuilder: (ctx, index) {
                          if (Platform.isIOS) {
                            return maskIcons('ios', index);
                          } else {
                            return maskIcons('android', index);
                          }
                        }))
              ])
        ]));
  }

  Widget maskIcons(String fileName, int index) {
    return GestureDetector(
        onTap: () {
          currentPage = index;
          cameraDeepArController.changeMask(index);
          setState(() {});
        },
        child: Container(
            margin: EdgeInsets.only(right: 8),
            width: currentPage == index ? 80 : 40,
            height: currentPage == index ? 80 : 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 2),
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(
                //     currentPage == index ? 65 : 30),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/$fileName/$index.jpg",
                    )))));
  }
}
