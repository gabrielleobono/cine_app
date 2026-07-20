# 🎬 CinéScope

Application Flutter multi-écrans de découverte de films, réalisée dans le cadre d'une certification Flutter. Le projet met en pratique la navigation avec GoRouter, la gestion d'état, les formulaires validés, le thème clair/sombre et la conception de widgets réutilisables.

##  Fonctionnalités

- **Écran Liste** : parcours de tous les films, recherche par titre/réalisateur en temps réel, filtrage par genre via des chips
- **Écran Détail** : affichage complet d'un film (affiche, réalisateur, durée, note, synopsis), accessible via une route GoRouter paramétrée (`/movie/:id`)
- **Écran Formulaire** : ajout d'un avis sur un film (nom, note, commentaire) avec validation de chaque champ
- **Écran Réglages** : bascule entre thème clair et thème sombre, appliquée à toute l'application
- **Responsive** : bascule automatique entre affichage en liste (mobile) et en grille 3 colonnes (tablette, largeur > 600px)
- **Barre d'application rétractable** (SliverAppBar) au scroll

##  Architecture
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
├── screens/ # Un fichier par écran
│ ├── home_screen.dart
│ ├── movie_detail_screen.dart
│ ├── add_review_screen.dart
│ └── settings_screen.dart
└── widgets/ # Composants réutilisables
├── movie_card.dart
├── rating_stars.dart
└── genre_filter_bar.dart

Séparation stricte UI / données : aucun widget ne contient de donnée écrite en dur, tout provient des dépôts du dossier `data/`.

## Navigation (GoRouter)

| Route | Nom | Description |
|---|---|---|
| `/` | `home` | Liste des films avec recherche et filtres |
| `/movie/:id` | `movieDetail` | Détail d'un film (paramètre `id` dans l'URL) |
| `/movie/:id/review` | `addReview` | Formulaire d'ajout d'avis pour ce film |
| `/settings` | `settings` | Réglages, dont le thème clair/sombre |


### Installation

```bash
git clone https://github.com/gabrielleobono/cine_list_app.git
cd cine_list_app
flutter pub get
```

### Lancer l'application

bash
flutter run

Flutter détecte automatiquement les appareils disponibles. Pour cibler un appareil précis :
bash
flutter devices        # liste les appareils disponibles
flutter run -d <id>    # lance sur l'appareil choisi



##  Technologies

- **Flutter** / Dart
- **go_router** — navigation déclarative avec routes nommées
- **provider** — gestion d'état (thème)

##  Licence

Projet réalisé à des fins pédagogiques.
