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
- **Responsive** : bascule automatique liste ↔ Grille multi-paliers adaptative selon la largeur d'écran (téléphone, tablette, PC) 

## 🧩 Diversité des widgets utilisés

Le projet utilise plus de 8 widgets Flutter différents, notamment :

`SliverList `, `GridView` (via `SliverGrid`), `Card`, `TextField`, `TextFormField`, `DropdownButtonFormField`, `ChoiceChip`, `SwitchListTile`, `SliverAppBar`, `Form`, `InkWell`, `Row`/`Column`.

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

- **Test unitaire** (`test/movie_repository_test.dart`) : vérifie la logique de recherche/filtrage (par texte, par genre, combinaison des deux, cas vide).
- **Tests de widgets & d'écrans** :
  - `test/home_screen_test.dart` : vérifie que l'écran d'accueil charge et affiche le titre, la barre de recherche et les cartes de films.
  - `test/movie_detail_screen_test.dart` : valide l'affichage des informations d'un film (titre, réalisateur, synopsis).


## 🧱 Architecture


lib/
├── main.dart # Point d'entrée, configuration du thème
├── models/ # Classes de données pures
│ ├── movie.dart
│ └── review.dart
├── data/ # Source des données (mock, séparée de l'UI)
│ ├── movie_repository.dart
│ └── review_repository.dart
├── providers/ # Gestion d'état partagé
│ └── theme_provider.dart
├── router/ # Configuration GoRouter (routes nommées)
│ └── app_router.dart
├── screens/ # Un écran par fichier
│ ├── home_screen.dart
│ ├── movie_detail_screen.dart
│ ├── add_review_screen.dart
│ └── settings_screen.dart
└── widgets/ # 3 composants réutilisables
├── movie_card.dart # Carte film (mode liste et grille)
├── rating_stars.dart # Affichage de note en étoiles
└── genre_filter_bar.dart # Barre de recherche + filtres genre

Séparation stricte UI / données : aucun widget n'affiche de donnée écrite en dur, tout provient des dépôts du dossier `data/`.

## 🛣️ Navigation (GoRouter)

| Route | Nom | Description |
|---|---|---|
| `/` | `home` | Liste des films avec recherche et filtres |
| `/movie/:id` | `movieDetail` | Détail d'un film (paramètre `id` dans l'URL) |
| `/movie/:id/review` | `addReview` | Formulaire d'ajout d'avis pour ce film |
| `/settings` | `settings` | Réglages, dont le thème clair/sombre |

## 🚀 Lancement du projet

### Prérequis
- Flutter SDK installé ([guide officiel](https://docs.flutter.dev/get-started/install))
- Un émulateur, un navigateur, ou un appareil physique connecté

### Installation

```bash
git clone https://github.com/gabrielleobono/cine_app.git
cd cine_app
flutter pub get
```

### Lancer l'application

```bash
flutter run
```

```bash
flutter devices        # liste les appareils disponibles
flutter run -d <id>    # lance sur un appareil précis
```

### Lancer les tests

```bash
flutter test
```

### Analyser la qualité du code

```bash
flutter analyze
```

## 🛠️ Technologies

- **Flutter** / Dart
- **go_router** — navigation déclarative avec routes nommées
- **provider** — gestion d'état (thème)

**Bonnes pratiques**
Protection contre le double-clic (anti-spam) lors de la soumission d'un avis.
Fermeture automatique du clavier virtuel au clic hors des champs.
Vérification du cycle de vie des widgets (mounted) avant l'affichage des messages pour éviter les crashs de contexte.

## 📄 Licence

Projet réalisé à des fins pédagogiques.
