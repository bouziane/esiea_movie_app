abstract class MoviesEvent {}

class FetchUpcomingMovies extends MoviesEvent {}

class SearchMovies extends MoviesEvent {
  final String query;

  SearchMovies(this.query);
}
