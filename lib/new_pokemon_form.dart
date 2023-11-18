import 'package:pokemon_2324/pokemon_model.dart';
import 'package:flutter/material.dart';

class AddPokemonFormPage extends StatefulWidget {
  const AddPokemonFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddPokemonFormPageState createState() => _AddPokemonFormPageState();
}

class _AddPokemonFormPageState extends State<AddPokemonFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Escriu un nom de un Pokémon!'),
            backgroundColor: Colors.redAccent,
            contentTextStyle: const TextStyle(color: Colors.white),
            titleTextStyle: const TextStyle(fontSize: 22, color: Colors.white),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: const Text('ACCEPTAR'),
              ),
            ],
          );
        },
      );
    } else {
      var newPokemon = Pokemon(nameController.text);
      Navigator.of(context).pop(newPokemon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Afegeix un nou Pokémon'),
        titleTextStyle:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        backgroundColor: const Color.fromARGB(255, 110, 252, 242),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://wallpapercave.com/wp/wp8695692.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(decoration: TextDecoration.none),
                onChanged: (v) => nameController.text = v,
                decoration: const InputDecoration(
                  labelText: 'Nom del Pokémon',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 110, 252, 242)),
                  ),
                ),
                cursorWidth: 2.0,
                cursorHeight: 20.0,
                cursorColor: const Color.fromARGB(255, 110, 252, 242),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => submitPup(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 110, 252, 242)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Crear Pokémon'),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
