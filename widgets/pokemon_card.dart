import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Set the border radius
        side: const BorderSide(
            color: Colors.orangeAccent,
            width: 2), // Set the border color and width
      ),
      elevation: 8, // Increased elevation for better shadow effect
      margin: const EdgeInsets.symmetric(
          vertical: 8), // Add margin for spacing between cards
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Ensure text is centered
        children: [
          // Pokémon image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              pokemon.imageUrl,
              width: 100, // Slightly bigger image
              height: 100,
              fit: BoxFit
                  .contain, // Ensures the whole image fits within the bounds
            ),
          ),
          const SizedBox(height: 8), // Spacing between image and name
          // Pokémon name
          Text(
            pokemon.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87, // A dark color for better contrast
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
