import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/services/habitation_service.dart';
import 'package:location/views/habitation_details.dart';
import 'package:location/views/share/habitation_features_widget.dart';
import 'package:location/views/share/habitation_option.dart';

class HabitationList extends StatelessWidget {
  final HabitationService service = HabitationService();
  late List<Habitation> _habitations;
  final bool isHouseList;

  HabitationList(this.isHouseList, {super.key}) {
    _habitations =
        isHouseList ? service.getMaisons() : service.getAppartements();
  }

  // final _habitations = [
  //   Habitation(2, "appartement.png", "Appartement 2", "Rue 2", 3, 50, 555),
  //   Habitation(3, "appartement.png", "Appartement 3", "Rue 3", 2, 51, 401),
  //   Habitation(4, "appartement.png", "Appartement 4", "Rue 4", 2, 52, 402),
  // ];

  _buildDetails(Habitation habitation) {
    var format = NumberFormat("### €");
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(habitation.libelle),
                subtitle: Text(habitation.adresse),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                format.format(habitation.prixmois),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        HabitationFeaturesWidget(habitation),
      ],
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HabitationDetails(habitation)),
            );
          },
          child: Column(children: [
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/images/locations/${habitation.image}',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            _buildDetails(habitation),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des ${isHouseList ? 'maisons' : 'appartements'}"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _habitations.length,
          itemBuilder: (context, index) =>
              _buildRow(_habitations[index], context),
          itemExtent: 285,
        ),
      ),
    );
  }
}
