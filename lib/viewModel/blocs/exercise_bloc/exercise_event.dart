abstract class ExerciseEvent {}
class LoadExercises extends ExerciseEvent {}
class MarkExerciseCompleted extends ExerciseEvent {
  final String id;
  MarkExerciseCompleted(this.id);
}
