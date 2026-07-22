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
  bool _isSubmitting = false; // Empêche le double-clic

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_isSubmitting) return;

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    // Ferme le clavier proprement avant de quitter l'écran
    FocusScope.of(context).unfocus();

    setState(() => _isSubmitting = true);

    try {
      ReviewRepository.instance.add(
        Review(
          movieId: widget.movieId,
          reviewerName: _nameController.text.trim(),
          stars: _selectedRating!,
          comment: _commentController.text.trim(),
          createdAt: DateTime.now(),
        ),
      );

      // Vérifie si le widget est toujours affiché avant d'utiliser le context
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Avis ajouté !'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'envoi : $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Avis sur ${widget.movieTitle}')),
      // GestureDetector permet de fermer le clavier en cliquant n'importe où dehors
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 50, // Limite le nom pour éviter les abus
                    decoration: const InputDecoration(
                      labelText: 'Ton nom',
                      border: OutlineInputBorder(),
                      counterText: "", // Masque le compteur par défaut
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 2) {
                        return 'Nom trop court (min 2 caractères)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    initialValue:
                        _selectedRating, // Corrigé : initialValue n'existe pas
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(),
                    ),
                    items: [1, 2, 3, 4, 5].map((n) {
                      return DropdownMenuItem(value: n, child: Text('$n ⭐'));
                    }).toList(),
                    onChanged: _isSubmitting
                        ? null
                        : (value) {
                            setState(() => _selectedRating = value);
                          },
                    validator: (value) {
                      if (value == null) {
                        return 'Veuillez choisir une note';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _commentController,
                    maxLines: 4,
                    maxLength: 500, // Empêche les textes trop lourds en base
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    onPressed: _isSubmitting ? null : _submit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Envoyer mon avis'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
