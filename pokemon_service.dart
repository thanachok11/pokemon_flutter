import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon/models/pokemon.dart';

class PokemonService {
  static Future<List<Pokemon>> fetchPokemon() async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=20"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      List<Pokemon> pokemonList = [];

      for (var item in results) {
        final pokemonResponse = await http.get(Uri.parse(item['url']));
        if (pokemonResponse.statusCode == 200) {
          final pokemonData = jsonDecode(pokemonResponse.body);
          pokemonList.add(Pokemon.fromJson(pokemonData));
        }
      }

      return pokemonList;
    } else {
      throw Exception("Failed to load Pokémon");
    }
  }
}
