import 'package:face_detection_app/business_logic/Blocs/camera_bloc/camera_bloc.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/events/camera_events.dart';
import 'package:face_detection_app/business_logic/Blocs/camera_bloc/states/camera_states.dart';
import 'package:face_detection_app/screens/camera_screen/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<CameraBloc>().add(CameraRequested(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CameraBloc, CameraStates>(
          builder: (context, state) {
            if (state is CameraIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (state is CameraLoadingSuccess) {
                return ElevatedButton(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.camera_alt),
                        Text('Take a picture'),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CameraScreen.routName,
                    );
                  },
                );
              } else {
                return Text('Something went wrong. Please try again later');
              }
            }
          },
        ),
      ),
    );
  }
}
