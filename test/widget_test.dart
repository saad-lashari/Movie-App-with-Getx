import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/locall_database.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_ffi.dart

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUpAll(() async {
    // Initialize the database before running any tests
    await LocalDatabase.createDatabase();
  });

  group('LocalDatabase Tests', () {
    test('Test insert and check if movie exists', () async {
      final movie = AllMovies(
        id: 1,
        genreIds: [1, 2],
        title: 'Test Movie',
        overview: 'Test overview',
        posterPath: 'poster.jpg',
        backdropPath: 'backdrop.jpg',
        releaseDate: '2024-05-06',
      );
      await LocalDatabase.insertMovie(movie);
      final exists = await LocalDatabase.movieExists(movie.id);
      expect(exists, true);
    });

    test('Test get all movies', () async {
      final movies = await LocalDatabase.getAllMovies();
      expect(movies.length,
          greaterThan(0)); // Assuming there are movies in the database
    });

    test('Test get all genres', () async {
      final genres = await LocalDatabase.getAllGenres();
      expect(genres, isList); // Assuming genres should be a list
    });

    test('Test insert genre', () async {
      final genre = Genres(1, 'Action');
      await LocalDatabase.insertGenre(genre);
      final genres = await LocalDatabase.getAllGenres();
      expect(genres.length,
          greaterThan(0)); // Assuming genre was inserted successfully
    });
  });
}
