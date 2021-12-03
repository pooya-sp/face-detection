import 'package:face_detection_app/screens/camera_screen/masks_screen.dart';
import 'package:flutter/material.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';

class TabBarWidget extends StatefulWidget {
  final CameraDeepArController cameraDeepArController;
  TabBarWidget(this.cameraDeepArController);
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
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
          MasksScreen(widget.cameraDeepArController, 0),
          MasksScreen(widget.cameraDeepArController, 1),
          MasksScreen(widget.cameraDeepArController, 2),
        ]),
      ),
    );
  }
}
