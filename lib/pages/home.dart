import 'package:flutter/material.dart';

import 'package:peliculas/widgets/movies_horizontal.dart';
import '../widgets/card_swiper_widget.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

import 'package:peliculas/search/search_delegate.dart';



class HomePage extends StatelessWidget {
  HomePage({super.key});
  final peliProvider = PeliculasProviders();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    peliProvider.getPopular();

    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: const Text('Que mirás bobo?'),
            
            backgroundColor: Colors.indigoAccent,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: DataSerach());
                  },
                  icon: const Icon(Icons.search))
            ]),
        // ignore: prefer_const_constructors
        //fixing overflow when keyboard appear
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_swiperTarjetas(), _footerScroll(context)],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return const SizedBox(
            height: 300.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _footerScroll(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Populares',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder(
          stream: peliProvider.popularesStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(
                peliculas: snapshot.data,
                nextPage: peliProvider.getPopular,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }
}
