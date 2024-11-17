import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/http_helper.dart';
import 'package:movies_app/movie.dart';
import 'package:movies_app/movie_bloc/movie_blocs.dart';
import 'package:movies_app/movie_bloc/movie_events.dart';
import 'package:movies_app/movie_bloc/movie_states.dart';
import 'package:movies_app/movie_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(HttpHelper())..add(FetchUpcomingMovies()),
      child: MaterialApp(
        title: 'Movies App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(),
          ),
        ),
      ),
      body: BlocBuilder<MovieBloc, MoviesState>(
        builder: (context, state) {
          // Loading
          if (state is MoviesInitial || state is MoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );

            // Movie fetch success
          } else if (state is MoviesLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                Movie movie = state.movies[index];

                return ListTile(
                  leading: Image.network(movie.posterPath),
                  title: Text(movie.title),
                  subtitle: Text("Sortie : ${movie.releaseDate}"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetail(movie: movie),
                    ),
                  ),
                );
              },
            );

            // Movie fetch error
          } else if (state is MoviesError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        if (query.isNotEmpty) {
          // Envoie de l'événement SearchMovies avec la query au bloc.
          context.read<MovieBloc>().add(SearchMovies(query));
        } else {
          // Si la barre de recherche est vide, recharge les films à venir.
          context.read<MovieBloc>().add(FetchUpcomingMovies());
        }
      },
      decoration: InputDecoration(
        hintText: 'Rechercher un film...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
