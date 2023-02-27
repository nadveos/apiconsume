import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

import '../models/pelicula_model.dart';

class DataSerach extends SearchDelegate {
  final peliculasProvider = PeliculasProviders();
  String seleccion = '';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions las acciones
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.SearchPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final pelis = snapshot.data;
          return ListView(
            //adding shrinkWrap true to block overflow when kb appears
            shrinkWrap: true,
            children: pelis!.map((peli) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: const AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(peli.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text('${peli.title}'),
                onTap: () {
                  close(context, null);
                  peli.uniqueID = '';
                  Navigator.of(context)
                      .pushNamed('/detalle', arguments: peli);
                },
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
