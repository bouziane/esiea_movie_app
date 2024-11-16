import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movie_bloc/movie_events.dart';
import 'package:movies_app/movie_bloc/movie_states.dart';

class CounterBloc extends Bloc<MoviesEvent, MoviesState> {
  CounterBloc() : super(MoviesLoading()) {
    
  }
}
