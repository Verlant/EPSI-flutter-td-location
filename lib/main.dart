import 'package:flutter/material.dart';
import 'package:location/models/habitation.dart';
import 'package:location/models/type_habitat.dart';
import 'package:location/services/habitation_service.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/habitation_list.dart';

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
  final HabitationService service = HabitationService();
  final String title;
  late List<TypeHabitat> _typehabitats;
  late List<Habitation> _habitations;

  MyHomePage({required this.title, super.key}) {
    _habitations = service.getHabitationsTop10();
    _typehabitats = service.getTypeHabitat();
  }

  // final _typehabitats = [
  //   TypeHabitat(1, "Maison"),
  //   TypeHabitat(2, "Appartement")
  // ];
  // final _habitations = [
  //   Habitation(1, "maison.png", "Maison méditerranéenne",
  //       "12 Rue du Coq qui chante", 3, 92, 600),
  //   Habitation(
  //       2, "appartement.png", "Appartement neuf", "Rue de la soif", 1, 50, 555),
  //   Habitation(3, "appartement.png", "Appartement 1", "Rue 1", 1, 51, 401),
  //   Habitation(4, "appartement.png", "Appartement 2", "Rue 2", 1, 52, 402),
  //   Habitation(5, "maison.png", "Maison 1", "Rue M1", 3, 101, 701),
  //   Habitation(6, "maison.png", "Maison 2", "Rue M2", 3, 102, 702),
  // ];

  _buildTypeHabitat(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_typehabitats.length,
            (index) => _buildHabitat(context, _typehabitats[index])),
      ),
    );
  }

  _buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      // case 1: House
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }

    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HabitationList(typeHabitat.id == 1),
                  ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white70,
                ),
                const SizedBox(width: 5),
                Text(
                  typeHabitat.libelle,
                  style: LocationTextStyle.regularWhiteTextStyle,
                )
              ],
            )),
      ),
    );
  }

  _buildDerniereLocation(context) {
    return SizedBox(
        height: 240,
        child: ListView.builder(
          itemCount: _habitations.length,
          itemExtent: 220,
          itemBuilder: (context, index) =>
              _buildRow(_habitations[index], context),
          scrollDirection: Axis.horizontal,
        ));
  }

  _buildRow(Habitation habitation, BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.all(4.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            'assets/images/locations/${habitation.image}',
            fit: BoxFit.fitWidth,
          ),
        ),
        Text(
          habitation.libelle,
          style: LocationTextStyle.regularTextStyle,
        ),
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            Text(
              habitation.adresse,
              style: LocationTextStyle.regularTextStyle,
            ),
          ],
        ),
        Text(
          habitation.prixmois.toString(),
          style: LocationTextStyle.boldTextStyle,
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 30),
          _buildTypeHabitat(context),
          const SizedBox(height: 20),
          _buildDerniereLocation(context)
        ],
      )),
    );
  }
}
