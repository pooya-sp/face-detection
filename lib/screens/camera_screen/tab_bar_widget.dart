import 'package:face_detection_app/screens/camera_screen/masks_screen.dart';
import 'package:flutter/material.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';

class TabBarWidget extends StatelessWidget {
  CameraDeepArController cameraDeepArController;
  TabBarWidget._privateConstructor();

  static final TabBarWidget _instance = TabBarWidget._privateConstructor();

  factory TabBarWidget(CameraDeepArController controller) {
    _instance.cameraDeepArController = controller;
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Masks',
              ),
              Tab(
                text: 'Filters',
              ),
              Tab(
                text: 'Effects',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          MasksScreen(cameraDeepArController, 0),
          MasksScreen(cameraDeepArController, 1),
          MasksScreen(cameraDeepArController, 2),
        ]),
      ),
    );
  }
}
