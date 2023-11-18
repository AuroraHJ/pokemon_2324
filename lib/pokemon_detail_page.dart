import 'package:flutter/material.dart';
import 'pokemon_model.dart';
import 'dart:async';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetailPage(this.pokemon, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  final double pokemonAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color.fromARGB(255, 110, 252, 242),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.pokemon.rating = _sliderValue.toInt();
      });
      Navigator.of(context).pop(widget.pokemon);
    }
  }

  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.redAccent,
            title: const Text(
              'Error!',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            content: const Text(
              "Que dius!? Aquest Pokémon no esta tan malament! :(",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Torna a intentar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 110, 252, 242)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      child: const Text('Puntua'),
    );
  }

  Widget get pokemonImage {
    return Hero(
      tag: widget.pokemon,
      child: Container(
        height: pokemonAvarterSize,
        width: pokemonAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(1.0, 2.0),
                  blurRadius: 2.0,
                  spreadRadius: -1.0,
                  color: Color.fromARGB(255, 110, 252, 242)),
              BoxShadow(
                  offset: Offset(2.0, 1.0),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  color: Color.fromARGB(255, 110, 252, 242)),
              BoxShadow(
                  offset: Offset(3.0, 1.0),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  color: Color.fromARGB(255, 110, 252, 242))
            ],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.pokemon.imageUrl ?? ""))),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.favorite,
          size: 40.0,
          color: Color.fromARGB(255, 110, 252, 242),
        ),
        Text('${widget.pokemon.rating}/10',
            style: const TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  Widget get pokemonProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          pokemonImage,
          Text(widget.pokemon.name,
              style: const TextStyle(color: Colors.black, fontSize: 32.0)),
          Text('${widget.pokemon.numPokedex}',
              style: const TextStyle(color: Colors.black, fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 252, 242),
        title: Text('Coneix al Pokémon: ${widget.pokemon.name}'),
        titleTextStyle:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://wallpapercave.com/wp/ykV5YUr.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
              ),
              child: ListView(
                children: <Widget>[pokemonProfile, addYourRating],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
