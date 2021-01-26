import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/character_detail.dart';
import 'package:pokedex/detail.dart';
import 'package:pokedex/model/model.dart';

class CharactersList extends StatefulWidget {
  @override
  _CharactersListState createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  String url = "https://rickandmortyapi.com/api/character";
  RickAndMorty rickAndMorty;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getDataFromApi(),
      builder: (context, AsyncSnapshot<RickAndMorty> incomingValue) {
        if (incomingValue.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (incomingValue.connectionState == ConnectionState.done) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  var common = incomingValue.data.results[index];
                  Detail detail = Detail(common.id, common.name, common.status,
                      common.species, common.gender);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CharacterDetail(
                              image: incomingValue.data.results[index].image,
                              detail: detail)));
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 4,
                    child: Column(
                      children: [
                        Hero(
                          tag: incomingValue.data.results[index].image,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4 + 40,
                            height: MediaQuery.of(context).size.height / 4 - 36,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.contain,
                              placeholder: "lib/assets/loading.gif",
                              image: incomingValue.data.results[index].image,
                            ),
                          ),
                        ),
                        Text(incomingValue.data.results[index].name)
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: incomingValue.data.results.length,
          );
        } else {
          return Center(
            child: Text("Error"),
          );
        }
      },
    );
  }

  Future<RickAndMorty> _getDataFromApi() async {
    var response = await http.get(url);
    Map decodedValue = json.decode(response.body);
    rickAndMorty = RickAndMorty.fromJson(decodedValue);
    return rickAndMorty;
  }
}
