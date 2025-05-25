import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/exercise_repository.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository repository;
  final Set<String> completedIds = {};
  int streak = 0;

  ExerciseBloc(this.repository) : super(ExerciseInitial()) {
    on<LoadExercises>((event, emit) async {
      emit(ExerciseLoading());
      try {
        final exercises = await repository.fetchExercises();
        await _loadStreak();
        emit(ExerciseLoaded(exercises, completedIds, streak));
      } catch (e) {
        emit(ExerciseError(e.toString()));
      }
    });

    on<MarkExerciseCompleted>((event, emit) async {
      completedIds.add(event.id);
      await _updateStreak();
      if (state is ExerciseLoaded) {
        final exercises = (state as ExerciseLoaded).exercises;
        emit(ExerciseLoaded(exercises, completedIds, streak));
      }
    });
  }

  Future<void> _loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString('lastDate') ?? '';
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (lastDate == today) {
      streak = prefs.getInt('streak') ?? 0;
    } else {
      final yesterday = DateTime.now()
          .subtract(Duration(days: 1))
          .toIso8601String()
          .substring(0, 10);
      if (lastDate == yesterday) {
        streak = (prefs.getInt('streak') ?? 0) + 1;
      } else {
        streak = 1;
      }
      await prefs.setString('lastDate', today);
      await prefs.setInt('streak', streak);
    }
  }

  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    prefs.setString('lastDate', today);
    prefs.setInt('streak', streak);
  }
}
