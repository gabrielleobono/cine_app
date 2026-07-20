import 'package:flutter/material.dart';
import '../data/review_repository.dart';
import '../models/review.dart';

class AddReviewScreen extends StatefulWidget {
  final String movieId;
  final String movieTitle;

  const AddReviewScreen({
    super.key,
    required this.movieId,
    required this.movieTitle,
  });

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  int? _selectedRating;

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    ReviewRepository.instance.add(
      Review(
        movieId: widget.movieId,
        reviewerName: _nameController.text.trim(),
        stars: _selectedRating!,
        comment: _commentController.text.trim(),
        createdAt: DateTime.now(),
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Avis ajouté !')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Avis sur ${widget.movieTitle}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ton nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 2) {
                    return 'Nom trop court';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<int>(
                initialValue: _selectedRating,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
                items: [1, 2, 3, 4, 5].map((n) {
                  return DropdownMenuItem(value: n, child: Text('$n ⭐'));
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedRating = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'choisis une note';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Commentaire',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 10) {
                    return 'Commentaire trop court (min 10 caractères)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _submit,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Envoyer mon avis'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
