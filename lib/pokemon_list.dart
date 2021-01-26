import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/model.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getDataFromApi(),
      builder: (context, AsyncSnapshot<Pokedex> incomingValue) {
        if (incomingValue.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (incomingValue.connectionState == ConnectionState.done) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Material(
                  elevation: 4,
                  child: Column(
                    children: [
                      Image.network(
                        incomingValue.data.pokemon[index].img,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(incomingValue.data.pokemon[index].name)
                    ],
                  ),
                ),
              );
            },
            itemCount: incomingValue.data.pokemon.length,
          );
        } else {
          return Center(
            child: Text("Error"),
          );
        }
      },
    );
  }

  Future<Pokedex> _getDataFromApi() async {
    var response = await http.get(url);
    Map decodedValue = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedValue);
    return pokedex;
  }
}
