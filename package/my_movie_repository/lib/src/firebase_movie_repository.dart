import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

class FirebaseMovieRepository implements MyMovieRepository {
  final movieCollection = FirebaseFirestore.instance.collection('movies');
  @override
  Future<MyMovie> addFavoriteMovie(String userId, MyMovie myMovie) async {
    try {
      final userTaskCollection = movieCollection
          .doc(userId)
          .collection('user_favorites');

      await userTaskCollection
          .doc(myMovie.id.toString())
          .set(myMovie.toModel().toDocument());

      return myMovie;
    } catch (e) {
      log('Error creating task: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isFavorite(String userId, String movieId) async {
    try {
      final docSnapshot = await movieCollection
          .doc(userId)
          .collection('user_favorites')
          .doc(movieId)
          .get();

      return docSnapshot.exists;
    } catch (e) {
      log('Error checking favorite: $e');
      return false;
    }
  }

  @override
  Future<void> deleteFavoriteMovie(String userId, String movieId) async {
    try {
      final userMovieDoc = movieCollection
          .doc(userId)
          .collection('user_movies')
          .doc(movieId);

      await userMovieDoc.delete();
    } catch (e) {
      log('Error deleting task: $e');
      rethrow;
    }
  }

  @override
  Future<MyMovie> addHistory(String userId, MyMovie myMovie) async {
    try {
      final userMovieCollection = movieCollection
          .doc(userId)
          .collection('user_history');

      await userMovieCollection
          .doc(myMovie.id.toString())
          .set(myMovie.toModel().toDocument());

      return myMovie;
    } catch (e) {
      log('Error creating task: $e');
      rethrow;
    }
  }

  @override
  Future<List<MyMovie>> getFavorites(String userId) async {
    try {
      final favoritesSnapshot = await FirebaseFirestore.instance
          .collection('movies')
          .doc(userId)
          .collection('user_favorites')
          .orderBy('date_time', descending: true)
          .get();

      final movies = favoritesSnapshot.docs
          .map((doc) => MyMovieModel.fromDocument(doc.data()).toEntity())
          .toList();

      return movies;
    } catch (e) {
      log('Error getFavorites: $e');
      rethrow;
    }
  }

  @override
  Future<List<MyMovie>> getHistory(String userId) async {
    try {
      final userHistorySnapshot = await movieCollection
          .doc(userId)
          .collection('user_history')
          .orderBy('date_time', descending: true)
          .get();

      return userHistorySnapshot.docs
          .map((doc) => MyMovieModel.fromDocument(doc.data()).toEntity())
          .toList();
    } catch (e) {
      log('Error getHistory: $e');
      rethrow;
    }
  }
}
