import 'dart:io';
import 'package:face_detection_app/business_logic/Blocs/filters_bloc/events/filters_events.dart';
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
  CameraDeepAr _cameraDeepAr;
  List masksAndFilters = [];
  String folderName = '';
  int currentItem = 0;

  @override
  void initState() {
    super.initState();
    context.read<FiltersBloc>().add(PreparingFilters());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FiltersBloc, FiltersState>(
        listener: (context, filterState) {
      if (filterState is FiltersPrepared) {
        _cameraDeepAr = filterState.cameraDeepAr;
        BlocProvider.of<FiltersBloc>(context, listen: false)
            .add(FiltersReady());
      }
      if (filterState is MasksHasChanged) {
        switch (widget.tabIndex) {
          case 0:
            masksAndFilters = _cameraDeepAr.supportedMasks;
            folderName = 'masks';
            currentItem = filterState.currentMask;
            break;
          case 1:
            masksAndFilters = _cameraDeepAr.supportedFilters;
            folderName = 'filters';
            currentItem = filterState.currentFilter;
            break;
          case 2:
            masksAndFilters = _cameraDeepAr.supportedEffects;
            folderName = 'effects';
            currentItem = filterState.currentEffect;
            break;
        }
      }
    }, builder: (context, filterState) {
      if (filterState is FiltersPrepared) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
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
    });
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
                currentItem = index;
                switch (widget.tabIndex) {
                  case 0:
                    widget.cameraDeepArController.changeMask(index);
                    BlocProvider.of<FiltersBloc>(context)
                        .add(ChangeMask(index));
                    break;
                  case 1:
                    widget.cameraDeepArController.changeFilter(index);
                    BlocProvider.of<FiltersBloc>(context)
                        .add(ChangeFilter(index));
                    break;
                  case 2:
                    widget.cameraDeepArController.changeEffect(index);
                    BlocProvider.of<FiltersBloc>(context)
                        .add(ChangeEffect(index));
                    break;
                }
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
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
