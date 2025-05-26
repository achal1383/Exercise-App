import '../entities/exercise.dart';

import '../repository/exercise_repository.dart';

class GetExercises {
  final ExerciseRepository repository;

  GetExercises(this.repository);

  Future<List<Exercise>> call() => repository.getExercises();
}
