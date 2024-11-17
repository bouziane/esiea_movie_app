import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/http_helper.dart';
import 'package:movies_app/movie_bloc/movie_events.dart';
import 'package:movies_app/movie_bloc/movie_states.dart';

class MovieBloc extends Bloc<MoviesEvent, MoviesState> {
  HttpHelper httpHelper = HttpHelper();

  MovieBloc(this.httpHelper) : super(MoviesInitial()) {
    on<FetchUpcomingMovies>((event, emit) async {
      emit(MoviesLoading());

      try {
        final movies = await httpHelper.getUpComing();
        emit(MoviesLoaded(movies));
      } catch (e) {
        emit(MoviesError("Erreur lors du chargement des films"));
      }
    });

    on<SearchMovies>((event, emit) async {
      emit(MoviesLoading());

      try {
        final movies = await httpHelper.searchMovies(event.query);
        if (movies.isEmpty) {
          emit(MoviesError("Aucun film trouvé pour '${event.query}'"));
        } else {
          emit(MoviesLoaded(movies));
        }
      } catch (e) {
        emit(MoviesError("Erreur lors de la recherche des films"));
      }
    });
  }
}
