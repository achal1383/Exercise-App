

import '../../../data/models/exercise_model.dart';
import '../../../domain/entities/exercise.dart';

abstract class ExerciseState {}
class ExerciseInitial extends ExerciseState {}
class ExerciseLoading extends ExerciseState {}
class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;
  final Set<String> completedIds;
  final int streak;
  ExerciseLoaded(this.exercises, this.completedIds, this.streak);
}
class ExerciseError extends ExerciseState {
  final String message;
  ExerciseError(this.message);
}
