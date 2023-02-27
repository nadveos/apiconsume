import 'package:flutter/material.dart';

import '../models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function nextPage;
  MovieHorizontal({super.key, required this.peliculas, required this.nextPage});
  final _pageController = PageController(
    keepPage: true,
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
        },
        // children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueID = '${pelicula.id}-poster';
    final tarjetaPeli = Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueID,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/loading.gif'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            '${pelicula.title}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
    return GestureDetector(
        child: tarjetaPeli,
        onTap: () {
          Navigator.of(context).pushNamed('/detalle',arguments: pelicula);
        });
  }

  // List<Widget> _tarjetas(BuildContext context) {
  //   return peliculas.map((pelicula) {
  //     return Container(
  //       margin: const EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  //             child: FadeInImage(
  //               placeholder: const AssetImage('assets/img/loading.gif'),
  //               image: NetworkImage(pelicula.getPosterImg()),
  //               fit: BoxFit.cover,
  //               height: 160.0,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 5.0,
  //           ),
  //           Text(
  //             '${pelicula.title}',
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.labelLarge,
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
