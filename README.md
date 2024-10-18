# Movie App - Fonctionnalité de Recherche

## Objectif
Ajouter la recherche de films via l’API TMDb [The Movie Database (TMDb)](https://developer.themoviedb.org/reference/search-movie) en créant un bloc (Bloc) pour gérer la recherche et afficher les résultats.

## Étapes à Suivre

1. **Création des Blocs :**
   - Créez un bloc pour gérer la liste des films 

2. **Gestion des Événements et des États :**
   - Définissez les événements à utiliser, par exemple :
     - `FetchUpcomingMovies` pour récupérer la liste des films à venir.
     - `SearchMovies` pour gérer la recherche.
   - Définissez les états appropriés, par exemple :
     - `MoviesLoading`, `MoviesLoaded`, `MoviesError` pour gérer les différentes étapes de chargement des films.

3. **Mise à Jour de l’Interface :**
   - Modifiez les widgets existants pour écouter les blocs correspondants.
   - Vous avez carte blanche pour modifier l'interface de l'application comme bon vous semble. Profitez-en pour rendre l'application visuellement plus attrayante. 
   - N'hésitez pas à vous inspirer des applications déjà existantes.

## Ressources Utiles
- [API de Recherche de Films - The Movie Database](https://developer.themoviedb.org/reference/search-movie)
- [Documentation complète de The Movie Database API](https://developer.themoviedb.org/reference/intro/getting-started)
