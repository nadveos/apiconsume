import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/models/pelicula_model.dart';

import '../models/actore_models.dart';

class PeliculasProviders {
  final String _url = 'api.themoviedb.org';
  final String _apiKey = 'YOUR_API_KEY';
  final String _lang = 'es-ES';
  // final String _region = 'AR';

  int _popularesPage = 0;
  bool _loading = false;

  final List<Pelicula> _populares = [];
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarData(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final pelis = Peliculas.fromJsonList(decodedData['results']);

    return pelis.items;
  }

  Future<List<Pelicula>> getNowPlaying() async {
    final url = Uri.https(
        _url, '3/movie/now_playing', {'api_key': _apiKey, 'lenguage': _lang, });

    return await _procesarData(url);
  }

  Future<List<Pelicula>> getPopular() async {
    if (_loading) return [];
    _loading = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'lenguage': _lang,
      'page': _popularesPage.toString()
    });

    final respuesta = await _procesarData(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);
    _loading = false;
    return respuesta;
  }

  Future<List<Actor>> getCast(String peliculaID) async {
    final url = Uri.https(_url, '3/movie/$peliculaID/credits', {
      'api_key': _apiKey,
      'lenguage': _lang,
    });
    final resp = await http.get(url);
    final decodedData = await json.decode(resp.body);
    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> SearchPelicula(query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'lenguage': _lang, 'query': query});

    return await _procesarData(url);
  }
}
