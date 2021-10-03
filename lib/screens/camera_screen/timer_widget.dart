import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/states/timer_states.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  // Widget buildTime(int duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   // final hours = twoDigits(duration.inHours);
  //   // final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   // final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return Text('$duration');
  // }

  @override
  void initState() {
    super.initState();
    context.read<TimerBloc>().add(TimerStarted(duration: 0));
  }

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    final hoursStr = (duration / 3600).floor().toString().padLeft(2, '0');
    return Text(
      '$hoursStr:$minutesStr:$secondsStr',
      style: TextStyle(color: Colors.white, fontSize: 17),
    );
  }
}
