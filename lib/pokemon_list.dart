import 'package:pokemon_2324/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'pokemon_model.dart';

class PokemonList extends StatefulWidget {
  final List<Pokemon> pokemonList;
  final Function(int) onDelete;

  const PokemonList(
      {Key? key, required this.pokemonList, required this.onDelete})
      : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: widget.pokemonList.length,
      itemBuilder: (context, int index) {
        return Dismissible(
          key: Key(widget.pokemonList[index].name),
          onDismissed: (direction) {
            widget.onDelete(index);
          },
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20.0),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: PokemonCard(widget.pokemonList[index]),
        );
      },
    );
  }
}
