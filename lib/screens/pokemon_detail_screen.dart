import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl, width: 150, height: 150),
            const SizedBox(height: 20),
            Text(
              pokemon.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Type: ${pokemon.type}", style: const TextStyle(fontSize: 16)),
            Text("Height: ${pokemon.height}", style: const TextStyle(fontSize: 16)),
            Text("Weight: ${pokemon.weight}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
