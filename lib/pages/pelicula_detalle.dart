

import 'package:flutter/material.dart';

import 'package:peliculas/models/pelicula_model.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

import '../models/actore_models.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    final Pelicula? pelicula =
        ModalRoute.of(context)?.settings.arguments as Pelicula?;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula!),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10.0,
              ),
              _posterTirulo(context, pelicula),
              _descripcion(pelicula),
              
              _getCasting(pelicula)
            ]),
          )
        ],
      ),
    );
    //
    // );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text('${pelicula.title}',
            style: const TextStyle(color: Colors.white, fontSize: 16.0)),
        background: FadeInImage(
          placeholder: const AssetImage('assets/img/no-image.jpg'),
          image: NetworkImage(pelicula.getBackdropImg()),
          fadeInDuration: const Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTirulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.id.toString(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pelicula.title}',
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
              Text('Estrenada en ${pelicula.releaseDate}',
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber[300],
                  ),
                  Text('${pelicula.voteAverage}')
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(
        '${pelicula.overview}',
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _getCasting(Pelicula pelicula) {
    final peliProv = PeliculasProviders();

    return FutureBuilder(
      future: peliProv.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _actoresPageView(snapshot.data);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _actoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta( actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(placeholder:const  AssetImage('assets/img/no-image.jpg'), image: NetworkImage(actor.getFoto()),height: 150.0,
          fit: BoxFit.cover,)
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
