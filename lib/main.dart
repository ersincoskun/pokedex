import 'package:flutter/material.dart';
import 'package:pokedex/characters_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: "rick and morty",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
        ),
        body: CharactersList(),
      ),
    );
  }
}
//
