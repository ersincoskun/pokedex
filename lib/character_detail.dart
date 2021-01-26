import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/detail.dart';
import 'package:pokedex/model/model.dart';

class CharacterDetail extends StatefulWidget {
  CharacterDetail({this.image, this.detail});

  String image;
  Detail detail;

  @override
  _CharacterDetailState createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Hero(
        tag: widget.image,
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Image.network(
                    widget.image,
                  ),
                ),
                _singleDetailChild(widget.detail.name + " Information",
                    top: 18,
                    bottom: 10,
                    dividerHeight: 5,
                    dividerColor: Colors.black,
                    textSize: 21),
                _singleDetailChild("ID: " + widget.detail.id.toString(),
                    top: 30),
                _singleDetailChild(
                    "Gender: " + _reverseGender(widget.detail.gender)),
                _singleDetailChild(
                    "Status: " + _reverseStatus(widget.detail.status)),
                _singleDetailChild(
                    "Species: " + _reverseSpecies(widget.detail.species)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _reverseStatus(Status status) {
    statusValues.reverse;
    String incomingStatus = statusValues.reverseMap[status];
    return incomingStatus;
  }

  String _reverseSpecies(Species species) {
    speciesValues.reverse;
    String incomingSpecies = speciesValues.reverseMap[species];
    return incomingSpecies;
  }

  String _reverseGender(Gender gender) {
    genderValues.reverse;
    String incomingGender = genderValues.reverseMap[gender];
    return incomingGender;
  }

  Widget _singleDetailChild(String text,
      {double top = 15,
      double bottom = 15,
      double dividerHeight = 0.2,
      double textSize = 18,
      dividerColor = Colors.grey}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, top, 0, bottom),
          child: Text(
            text,
            style: TextStyle(fontSize: textSize, color: Colors.black),
          ),
        ),
        Divider(
          height: dividerHeight,
          color: dividerColor,
        ),
      ],
    );
  }
}
