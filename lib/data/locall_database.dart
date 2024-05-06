import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer';

class LocalDatabase {
  static const String _tableName = 'movies_with_genres';

  static const String _movieId = 'movieId';
  static const String _title = 'title';
  static const String _overview = 'overview';
  static const String _posterPath = 'posterPath';
  static const String _backdropPath = 'backdropPath';
  static const String _releaseDate = 'releaseDate';

  static const String _genresTableName = 'genres';
  static const String _genresName = 'genresName';
  static const String _genreIds = 'genreIds';

  static Future<Database> createDatabase() async {
    return await openDatabase(
      'movies.db',
      version: 2, // Increment version if making schema changes
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_tableName ($_movieId INTEGER PRIMARY KEY,$_genreIds TEXT,$_title TEXT,$_overview TEXT,$_posterPath TEXT,$_backdropPath TEXT,$_releaseDate TEXT )''');

        await db.execute(
            '''CREATE TABLE $_genresTableName ($_genreIds INTEGER PRIMARY KEY, $_genresName TEXT)''');
      },
    );
  }

  static Future<void> insertMovie(AllMovies movie) async {
    log('here==insert');
    final db = await createDatabase();
    final genreIdsString = movie.genreIds.join(','); // Convert to CSV string
    await db.insert(
      _tableName,
      {
        _movieId: movie.id,
        _genreIds: genreIdsString,
        _title: movie.title, // Assuming a title property exists
        _overview: movie.overview, // Assuming an overview property exists
        _posterPath: movie.posterPath, // Assuming a posterPath property exists
        _backdropPath:
            movie.backdropPath, // Assuming a backdropPath property exists
        _releaseDate:
            movie.releaseDate, // Assuming a releaseDate property exists
      },
    );
  }

  static Future<bool> movieExists(int id) async {
    final db = await createDatabase();
    final maps = await db.query(
      _tableName,
      where: '$_movieId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }

  static Future<List<AllMovies>> getAllMovies() async {
    final db = await createDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    final movies = List<AllMovies>.generate(maps.length, (i) {
      return AllMovies(
        id: maps[i][_movieId] as int,
        genreIds:
            (maps[i][_genreIds] as String).split(',').map(int.parse).toList(),
        title: maps[i][_title] as String,
        overview: maps[i][_overview] as String,
        posterPath: maps[i][_posterPath] as String,
        backdropPath: maps[i][_backdropPath] as String,
        releaseDate: maps[i][_releaseDate] as String,
      );
    });
    return movies;
  }

  static Future<List<Genres>> getAllGenres() async {
    log('genres get');

    try {
      final db = await createDatabase();
      final List<Map<String, dynamic>> maps = await db.query(_genresTableName);
      final genres = List.generate(maps.length, (i) {
        return Genres(
            maps[i][_genreIds] as int, maps[i][_genresName] as String);
      });
      return genres;
    } catch (e) {
      log('Error getting genres: $e'); // Log the error for debugging
      return []; // Return an empty list on error
    }
  }

  static Future<void> insertGenre(Genres genre) async {
    log('genres add');
    final db = await createDatabase();
    await db.insert(
        _genresTableName, {_genreIds: genre.id, _genresName: genre.name});
  }
}
