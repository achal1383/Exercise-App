import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../models/exercise_model.dart';

class ExerciseRepository {
  final String apiUrl = '$baseUrl/workouts';

  Future<List<Exercise>> fetchExercises() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => Exercise.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}