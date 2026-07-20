import 'package:flutter/material.dart';

class GenreFilterBar extends StatelessWidget {
  final List<String> genres;
  final String selectedGenre;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onGenreSelected;

  const GenreFilterBar({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onQueryChanged,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Rechercher un film...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: onQueryChanged,
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: genres.map((g) {
              final selected = g == selectedGenre;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(g),
                  selected: selected,
                  onSelected: (_) => onGenreSelected(g),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
