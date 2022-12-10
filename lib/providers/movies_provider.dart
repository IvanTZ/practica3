import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final  String _apiKey = 'db6e8e03a0180d0a9a316ed631bbb75f';
  final String _language = 'es-Es';
  final String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Movies Provider inicializat');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});
    var response = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.movies;

    notifyListeners();
  }

  getPopularMovies() async {
    print('getPopulars');
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});
    var response = await http.get(url);

    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies = popularResponse.moviePops;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    print('getCast');
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final creditsResponse = CreditResponse.fromJson(result.body);
    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
