import 'package:flutter/material.dart';
import 'package:location/models/habitation.dart';
import 'package:location/models/type_habitat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
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
      home: MyHomePage(title: 'Mes locations'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({required this.title, super.key});

  var _typeHabitats = [TypeHabitat(1, "Maison"), TypeHabitat(2, "Appartement")];
  var _habitations = [
    Habitation(1, "maison.png", "Maison méditerranéenne", "12 Rue du Coq qui chante", 3, 92, 600),
    Habitation(2, "appartement.png", "Appartement neuf", "Rue de la soif", 1, 50, 555),
    Habitation(3, "appartement.pgn", "Appartement 1", "Rue 1", 1, 51, 401),
    Habitation(4, "appartement.png", "Appartement 2", "Rue 2", 1, 52, 402),
    Habitation(5, "maison.png", "Maison 1", "Rue M1", 3, 101, 701),
    Habitation(6, "maison.png", "Maison 2", "Rue M2", 3, 102, 702),
  ];

  _buildTypeHabitat() {
    return Container(
      height: 100,
      child: Row(
        children: List.generate(_typeHabitats.length, (index) => _buildHabitat(_typeHabitats[index])),
      ),
    );
  }

  _buildHabitat(TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      // case 1: House
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }

    return Container(
        height: 80,
        child: Row(
          children: [Icon(icon), Text(typeHabitat.libelle)],
        ));
  }

  _buildDerniereLocation(context) {
    return Container(
        height: 240,
        child: ListView.builder(
          itemCount: _habitations.length,
          itemExtent: 220,
          itemBuilder: (context, index) => _buildRow(_habitations[index], context),
          scrollDirection: Axis.horizontal,
        ));
  }

  _buildRow(Habitation habitation, BuildContext context) {
    return Container(
      width: 240,
      child: Column(children: [
        Image.asset(
          'assets/images/locations/${habitation.image}',
          fit: BoxFit.fitWidth,
        ),
        Text(habitation.libelle),
        Row(
          children: [
            Icon(Icons.location_on_outlined),
            Text(habitation.adresse),
          ],
        ),
        Text(habitation.prixmois.toString()),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
          child: Column(
        children: [_buildTypeHabitat(), _buildDerniereLocation(context)],
      )),
    );
  }
}
