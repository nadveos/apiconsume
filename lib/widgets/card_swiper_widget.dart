// ignore_for_file: use_key_in_widget_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/pelicula_model.dart';


class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  const CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: screenSize.width * 0.6,
        itemHeight: screenSize.height * 0.5,
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueID = '${peliculas[index].id}-tarjeta';
          return Hero(
            tag: peliculas[index].uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/detalle',
                      arguments: peliculas[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: const AssetImage('assets/img/loading.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        // autoplay: true,
        // pagination: const SwiperPagination(),
        // control: const SwiperControl(),
      ),
    );
  }
}
