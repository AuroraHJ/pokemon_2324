// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Pokemon {
  final String name;
  String? imageUrl;
  String? apiname;
  int? numPokedex;

  int rating = 10;

  Pokemon(this.name);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      apiname = name.toLowerCase();
      var uri = Uri.https('pokeapi.co', '/api/v2/pokemon/$apiname');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      Map<String, dynamic> data = json.decode(responseBody);
      imageUrl = data["sprites"]["front_default"];
      numPokedex = data["id"];
    } catch (exception) {
      print(exception);
    }
  }
}
