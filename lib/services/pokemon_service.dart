import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
class PokemonService {
  static Future<Map<String, dynamic>> fetchPokemon(
      [String url =
          'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0']) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Pokemon> pokemonList = [];
      for (var item in data['results']) {
        final pokemon = await fetchPokemonDetail(item['url']);
        if (pokemon != null) {
          pokemonList.add(pokemon);
        }
      }

      return {
        'pokemonList': pokemonList,
        'nextUrl': data['next'], // URL for the next page
      };
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  static Future<Pokemon?> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Fetch artwork URL from sprites
      String artworkUrl =
          data['sprites']['other']['official-artwork']['front_default'];

      return Pokemon.fromJson({
        ...data,
        'artworkUrl': artworkUrl,
      });
    }
    return null;
  }
}
