import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/share/habitation_features_widget.dart';
import 'package:location/views/share/habitation_option.dart';

class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;
  const HabitationDetails(this._habitation, {super.key});

  @override
  State<HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                print('Louer habitation');
              },
              child: const Text('Louer'),
            ),
          ),
        ],
      ),
    );
  }

  _buildItems() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.options.length,
        (i) => Container(
          padding: const EdgeInsets.only(left: 15.0),
          margin: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._habitation.options[i].libelle,
              ),
              Text(
                widget._habitation.options[i].description,
                style: LocationTextStyle.regularGreyStyle,
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }

  _buildOptionsPayantes() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.optionPayantes.length,
        (i) => Container(
          padding: const EdgeInsets.only(left: 15.0),
          margin: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget._habitation.optionPayantes[i].libelle,
              ),
              Text(
                '${widget._habitation.optionPayantes[i].prix} €',
                style: LocationTextStyle.regularGreyStyle,
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'assets/images/locations/${widget._habitation.image}',
                fit: BoxFit.fitWidth,
              )),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Text(widget._habitation.adresse),
          ),
          HabitationFeaturesWidget(widget._habitation),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Text(
                  'Inclus',
                  style: LocationTextStyle.subTitleBoldTextStyle,
                ),
              ),
              Divider(
                color: LocationStyle.backgroundColorPurple,
                height: 36,
                thickness: 10,
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
          _buildItems(),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Text(
                  'Options',
                  style: LocationTextStyle.subTitleBoldTextStyle,
                ),
              ),
              Divider(
                color: LocationStyle.backgroundColorPurple,
                height: 36,
                thickness: 10,
                indent: 10,
                endIndent: 10,
              )
            ],
          ),
          _buildOptionsPayantes(),
          _buildRentButton()
        ],
      ),
    );
  }
}
