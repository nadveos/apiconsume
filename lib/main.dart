
import 'package:flutter/material.dart';
import 'package:peliculas/pages/home.dart';
import 'package:peliculas/pages/pelicula_detalle.dart';

void main() => runApp( const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes:{ 
        '/':(BuildContext context)=> HomePage(),
        '/detalle': (BuildContext context)=>   const PeliculaDetalle(),
        
        }

    );
  }
}