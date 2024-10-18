import 'package:flutter/material.dart';
import 'package:movies_app/http_helper.dart';
import 'package:movies_app/movie.dart';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MaterialApp(home: HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpHelper httpHelper = HttpHelper();
  String imageBaseUrl = "https://image.tmdb.org/t/p/w92/";
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    httpHelper.getUpComing().then((moviesList) {
      setState(() {
        movies = moviesList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            Movie movie = movies[index];

            return ListTile(
              leading: Image.network(movie.posterPath),
              title: Text(movie.title),
              subtitle: Text("Sortie : ${movie.releaseDate}"),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetail(movie: movie),
                  )),
            );
          },
        ),
      ),
    );
  }
}
