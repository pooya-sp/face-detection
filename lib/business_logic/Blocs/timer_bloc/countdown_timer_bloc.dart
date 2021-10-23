import 'dart:async';

import 'package:camera/camera.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/countdown_timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/events/timer_events.dart';
import 'package:face_detection_app/business_logic/Blocs/timer_bloc/states/countdown_timer_states.dart';
import 'package:face_detection_app/data/Ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountDownTimerBloc
    extends Bloc<CountDownTimerEvent, CountDownTimerState> {
  int _duration = 0;
  StreamSubscription<int> _tickerSubscription;
  final Ticker _ticker = Ticker();
  CountDownTimerBloc() : super(CountDownTimerInitial());
  @override
  Stream<CountDownTimerState> mapEventToState(
      CountDownTimerEvent event) async* {
    if (event is SpecifyTimerDuration) {
      _duration = event.duration;
    }
    if (event is CountDownTimerStarted) {
      if (_duration == 0) {
        yield CountDownTimerInitial();
      } else {
        _tickerSubscription?.cancel();
        _tickerSubscription =
            _ticker.countDown(ticks: _duration).listen((duration) {
          add(CountDownTimerTicked(duration));
        });
        yield CountDownTimerRunInProgress(_duration);
      }
    }
    if (event is CountDownTimerTicked) {
      if (event.secondsToEnd > 0) {
        yield CountDownTimerRunInProgress(event.secondsToEnd);
      } else {
        _duration = 0;
        yield CountDownTimerInitial();
      }
    }
    if (event is CountDownTimerEnded) {
      _duration = 0;

      _tickerSubscription.cancel();
      yield CountDownTimerHasEnded();
    }
  }
}
  // int seconds = st.seconds;
  //                         Timer.periodic(Duration(seconds: 1), (timer) {
  //                           print(seconds);
  //                           if (seconds != 0) {
  //                             BlocProvider.of<CountDownTimerBloc>(context,
  //                                     listen: false)
  //                                 .add(CountDownTimerIsRunning(seconds));
  //                           }
  //                           if (seconds == 0) {
  //                             BlocProvider.of<CountDownTimerBloc>(context,
  //                                     listen: false)
  //                                 .add(CountDownTimerEnded());
                            //   widget._controller.takePicture().then((image) {
                            //     FileSaver.saveFileToStorage(image);
                            //     Navigator.of(context).pushNamed(
                            //         DisplayPictureScreen.routName,
                            //         arguments: image.path);
                            //     timer.cancel();
                            //   });
                            // }
  //                           seconds--;
  //                         });
