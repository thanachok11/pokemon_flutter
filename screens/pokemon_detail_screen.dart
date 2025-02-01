import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen(
      {super.key, required this.pokemon, required String pokemonName});

  @override
  Widget build(BuildContext context) {
    // Get the first Pokémon type to determine the primary color for the screen
    Color typeColor = _getTypeColor(
        pokemon.types.isNotEmpty ? pokemon.types.first : 'Unknown');

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: typeColor,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [typeColor.withOpacity(0.6), typeColor.withOpacity(1.0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border.all(color: typeColor, width: 6),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      pokemon.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Type: ${pokemon.types.join(", ")}",
                        style: const TextStyle(fontSize: 18)),
                    Text("Height: ${pokemon.height} m",
                        style: const TextStyle(fontSize: 18)),
                    Text("Weight: ${pokemon.weight} kg",
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    // แสดงค่าของ stat แยกจากกัน
                    const Text("Stats:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    ...pokemon.stats.entries.map(
                      (entry) {
                        return Text(
                          "${entry.key}: ${entry.value}",
                          style: const TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${pokemon.name} ถูกเลือก!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: typeColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                "เลือก Pokémon",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // กำหนดสีของประเภท Pokémon
  Color _getTypeColor(String type) {
    switch (type) {
      case "Fire":
        return Colors.redAccent;
      case "Water":
        return Colors.blueAccent;
      case "Grass":
        return Colors.green;
      case "Electric":
        return Colors.yellow[700]!;
      case "Psychic":
        return Colors.purple;
      case "Bug":
        return Colors.greenAccent;
      case "Normal":
        return Colors.brown;
      case "Fighting":
        return Colors.orange;
      case "Flying":
        return Colors.blue[400]!;
      case "Poison":
        return Colors.purple[300]!;
      case "Ghost":
        return Colors.indigo;
      case "Steel":
        return Colors.grey;
      case "Fairy":
        return Colors.pinkAccent;
      case "Ice":
        return Colors.cyan[100]!;
      case "Dragon":
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }
}
