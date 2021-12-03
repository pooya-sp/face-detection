import 'dart:io';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/filters_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/states/filters.states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rwa_deep_ar/rwa_deep_ar.dart';
import 'package:flutter/material.dart';

class MasksScreen extends StatefulWidget {
  final CameraDeepArController cameraDeepArController;
  final int tabIndex;
  MasksScreen(this.cameraDeepArController, this.tabIndex);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<MasksScreen> {
  int currentItem = 0;
  CameraDeepAr _cameraDeepAr;
  List masksAndFilters = [];
  String folderName = '';
  @override
  void initState() {
    super.initState();
    final fiterState =
        BlocProvider.of<FiltersBloc>(context, listen: false).state;
    if (fiterState is FiltersAreReady) {
      _cameraDeepAr = fiterState.cameraDeepAr;
    }
    checkIndex();
  }

  void checkIndex() {
    switch (widget.tabIndex) {
      case 0:
        masksAndFilters = _cameraDeepAr.supportedMasks;
        folderName = 'masks';
        break;
      case 1:
        masksAndFilters = _cameraDeepAr.supportedFilters;
        folderName = 'filters';
        break;
      case 2:
        masksAndFilters = _cameraDeepAr.supportedEffects;
        folderName = 'effects';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
            itemCount: masksAndFilters.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16),
            itemBuilder: (ctx, index) {
              if (Platform.isIOS) {
                return maskIcons('ios', index);
              } else {
                return maskIcons('android', index);
              }
            }));
  }

  Widget maskIcons(String fileName, int index) {
    final string = masksAndFilters[index].toString();
    final filtersName = string.split('.')[1];
    return Container(
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                widget.cameraDeepArController.changeMask(index);
                setState(() {
                  currentItem = index;
                });
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      // border: Border.all(
                      //     color: index > 2 ? Colors.yellow : Colors.red,
                      //     width: 2),
                      image: DecorationImage(
                          colorFilter: currentItem == index
                              ? ColorFilter.mode(Colors.blue, BlendMode.color)
                              : null,
                          fit: currentItem == index
                              ? BoxFit.scaleDown
                              : BoxFit.cover,
                          image: AssetImage(
                              "assets/$fileName/$folderName/$index.jpg")))),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              filtersName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
        // child:
        //  Container(
        //     margin: EdgeInsets.only(right: 4),
        //     width: currentPage == index ? 30.w : 10.w,
        //     height: currentPage == index ? 30.h : 10.h,
        //     decoration: BoxDecoration(
        //         border: Border.all(color: Colors.yellow, width: 2),
        //         shape: BoxShape.circle,
        //         image: DecorationImage(
        //             fit: BoxFit.cover,
        //             image: AssetImage(
        //               "assets/$fileName/$index.jpg",
        //             )))));
