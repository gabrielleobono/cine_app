# 🎬 CinéScope

Application Flutter multi-écrans de découverte de films, réalisée dans le cadre d'une certification Flutter. Le projet met en pratique la navigation avec GoRouter, la gestion d'état, les formulaires validés, le thème clair/sombre, le responsive et la conception de widgets réutilisables.

## 📱 Captures d'écran

| Liste (clair) | Détail | Formulaire | Réglages (sombre) |
|---|---|---|---|
| ![Liste](Screenshot_20260720-164306.png) | ![Détail](screenschots/Screenshot_20260720-164317.png) | ![Formulaire](screenschots/Screenshot_20260720-164332.png) | ![Réglages](screenschots/Screenshot_20260720-164343.png) |


## ✨ Fonctionnalités

- **Écran Liste** : recherche en temps réel (titre/réalisateur) et filtrage par genre via des `ChoiceChip`
- **Écran Détail** : accessible via une route GoRouter paramétrée (`/movie/:id`), affiche toutes les infos du film
- **Écran Formulaire** : ajout d'un avis (nom, note, commentaire), avec validation de chaque champ (voir section dédiée)
- **Écran Réglages** : bascule thème clair/sombre appliquée à toute l'app via `provider`
- **Responsive** : bascule automatique liste ↔ grille selon la largeur d'écran (seuil 600px, standard Material Design pour mobile/tablette)

## 🧩 Diversité des widgets utilisés

Le projet utilise plus de 8 widgets Flutter différents, notamment :

`ListView`, `GridView` (via `SliverGrid`), `Card`, `TextField`, `TextFormField`, `DropdownButtonFormField`, `ChoiceChip`, `SwitchListTile`, `SliverAppBar`, `Form`, `InkWell`, `Row`/`Column`.

## ✅ Validation du formulaire d'avis

Chaque champ du formulaire (`add_review_screen.dart`) est validé individuellement via `FormState.validate()` :
- **Nom** : minimum 2 caractères, texte non vide après suppression des espaces
- **Note** : sélection obligatoire dans le menu déroulant (1 à 5)
- **Commentaire** : minimum 10 caractères, pour éviter les avis vides ou trop courts

La soumission est bloquée tant que `_formKey.currentState!.validate()` ne renvoie pas `true`.

## 🧪 Tests

```bash
flutter test
```

- **Test unitaire** (`test/movie_repository_test.dart`) : vérifie la logique de recherche/filtrage (par texte, par genre, combinaison des deux, cas vide)
- **Test de widget** (`test/widget_test.dart`) : vérifie que l'écran liste affiche bien le titre, la barre de recherche et les films

## 🧱 Architecture
