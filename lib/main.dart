import 'package:flutter/material.dart';
import 'dart:async';
import 'pokemon_model.dart';
import 'pokemon_list.dart';
import 'new_pokemon_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LLISTAT DE POKÉMONS',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(
        title: 'LLISTAT DE POKÉMONS',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> initialPokemon = [
    Pokemon('ditto'),
    Pokemon('charmander'),
    Pokemon('eevee')
  ];

  void _deletePokemon(int index) {
    setState(() {
      initialPokemon.removeAt(index);
    });
  }

  Future _showNewPokemonForm() async {
    Pokemon? newPokemon = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddPokemonFormPage();
    }));

    if (newPokemon != null) {
      setState(() {
        initialPokemon.add(newPokemon);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 110, 252, 242),
        actions: <Widget>[
          IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(right: 50.0),
              child: Icon(Icons.catching_pokemon,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            onPressed: _showNewPokemonForm,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://w.forfun.com/fetch/7b/7b18be1395d99e3035b310dfc109cb40.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Container(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              ),
              PokemonList(
                  pokemonList: initialPokemon, onDelete: _deletePokemon),
            ],
          ),
        ),
      ),
    );
  }
}
