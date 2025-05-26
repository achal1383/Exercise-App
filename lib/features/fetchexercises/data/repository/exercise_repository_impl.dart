import '../../domain/entities/exercise.dart';

import '../../domain/repository/exercise_repository.dart';
import '../models/exercise_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExerciseRepositoryImpl implements ExerciseRepository {
  @override
  Future<List<Exercise>> getExercises() async {
    final response = await http.get(Uri.parse('https://68252ec20f0188d7e72c394f.mockapi.io/dev/workouts'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => ExerciseModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch exercises');
    }
  }
}
