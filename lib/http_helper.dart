import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/movie.dart';

class HttpHelper {
  final String urlBase = "https://api.themoviedb.org/3/movie";
  final String urlUpComing = "/upcoming?";
  final String apiKey = "api_key=bf6726965abb1371175e4fe3de923c5b";
  final String urlLanguage = "&language=fr-FR";

  Future<List<Movie>> getUpComing() async {
    final String url = "$urlBase$urlUpComing$apiKey$urlLanguage";
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(result.body);
      final List moviesMap = jsonResponse["results"];
      List<Movie> movies =
          moviesMap.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      return [];
    }
  }
}
