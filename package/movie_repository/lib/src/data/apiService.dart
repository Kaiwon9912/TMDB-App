import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiKey = "53baafc22d3e6a802d9872285d5e930b";
const String apiUrl = "https://api.themoviedb.org/3";

class ApiService {
  static Future<List> fetchMovies(String category) async {
    final respone = await http.get(
      Uri.parse('$apiUrl$category?api_key=$apiKey'),
    );
    if (respone.statusCode == 200) {
      return jsonDecode(respone.body)['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<Map<String, dynamic>> fetchMovieDetail(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/movie/$id?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load movies detail');
    }
  }

  static Future<Map<String, dynamic>> fetchPeopleDetail(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/person/$id?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load people detail');
    }
  }

  static Future<List<dynamic>> fetchMovieCredits(String movieID) async {
    final response = await http.get(
      Uri.parse('$apiUrl/movie/$movieID/credits?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['cast'];
    } else {
      throw Exception('Failed to load movie credits');
    }
  }

  static Future<List<dynamic>> fetchRecommendations(String movieID) async {
    final response = await http.get(
      Uri.parse('$apiUrl/movie/$movieID/recommendations?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results'];
    } else {
      throw Exception('Failed to load recommendation');
    }
  }

  static Future<Map<String, dynamic>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$apiUrl/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search movies');
    }
  }

  static Future<List> fetchPeopleCredits(int id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/person/$id/movie_credits?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['cast'];
    } else {
      throw Exception('Failed to load movie credits');
    }
  }
}
