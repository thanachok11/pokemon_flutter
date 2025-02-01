import 'package:flutter/material.dart';
import '../services/pokemon_service.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_screen.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  PokemonScreenState createState() => PokemonScreenState();
}

class PokemonScreenState extends State<PokemonScreen> {
  late Future<List<Pokemon>> futurePokemon;
  List<Pokemon> pokemonList = [];
  bool isInitialLoading = true; // Flag for the initial loading state
  bool isLoadingMore = false; // Flag for loading more Pokémon
  String nextUrl =
      'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0'; // URL for the next set of Pokémon

  @override
  void initState() {
    super.initState();
    _fetchPokemon(); // Load the initial set of Pokémon
  }

  // Function to fetch Pokémon data
  void _fetchPokemon() async {
    if (isLoadingMore) return; // Prevent multiple fetches at the same time

    setState(() {
      if (isInitialLoading) {
        isInitialLoading = true; // Loading for the first set of Pokémon
      } else {
        isLoadingMore = true; // Loading for additional Pokémon
      }
    });

    final response = await PokemonService.fetchPokemon(nextUrl);
    setState(() {
      if (isInitialLoading) {
        isInitialLoading = false; // Finished initial loading
      } else {
        isLoadingMore = false; // Finished loading more Pokémon
      }
      pokemonList.addAll(response['pokemonList']);
      nextUrl = response['nextUrl']; // Store URL for the next page of Pokémon
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Pokédex",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily:
                  'Poppins', // Use a custom font (ensure it's added in pubspec.yaml)
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(3.0, 3.0),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 4.0,
      ),
      body: Stack(
        children: [
          // GridView with Pokémon Cards
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Show 3 columns
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8, // Adjust the aspect ratio
                    ),
                    itemCount: pokemonList.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == pokemonList.length && isLoadingMore) {
                        // Display the loading indicator at the bottom
                        return const Center(child: CircularProgressIndicator());
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailScreen(
                                pokemon: pokemonList[index],
                                pokemonName: pokemonList[index].name,
                              ),
                            ),
                          );
                        },
                        child: PokemonCard(pokemon: pokemonList[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Initial Loading Indicator - Positioned at the center of the screen
          if (isInitialLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPokemon, // Icon for the button
        backgroundColor:
            Colors.orangeAccent, // Load more Pokémon when the button is clicked
        child: const Icon(Icons.add),
      ),
    );
  }
}
