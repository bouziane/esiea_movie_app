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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(HttpHelper())..add(FetchUpcomingMovies()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upcoming Movies'),
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
      ),
    );
  }
}