import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movie_bloc/movie_events.dart';
import 'package:movies_app/movie_bloc/movie_states.dart';

class MovieBloc extends Bloc<MoviesEvent, MoviesState> {
  MovieBloc() : super(MoviesLoading()) {
    on<FetchUpcomingMovies>((event, emit) {
      
    });
  }
}
