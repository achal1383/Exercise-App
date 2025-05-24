import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewModel/blocs/exercise_bloc/exercise_bloc.dart';
import '../../viewModel/blocs/exercise_bloc/exercise_state.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Your Workout Plan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          } else if (state is ExerciseError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (state is ExerciseLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '🔥 Current Streak: ${state.streak} days',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[800],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: state.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = state.exercises[index];
                      final completed = state.completedIds.contains(
                        exercise.id,
                      );
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: completed
                              ? Colors.green[100]
                              : Colors.deepPurple[50],
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            title: Text(
                              exercise.name.capitalize(exercise.name),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple[900],
                              ),
                            ),
                            subtitle: Text(
                              '⏱ Duration: ${exercise.duration}s\n🏋️ Difficulty: ${exercise.difficulty}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            trailing: Icon(
                              completed
                                  ? Icons.check_circle_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              color: completed
                                  ? Colors.green
                                  : Colors.deepPurple,
                              size: 28,
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ExerciseDetailScreen(
                                  exercise: exercise,
                                  onComplete: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

extension on String {
  String capitalize(String text) =>
      text.isNotEmpty ? '${text[0].toUpperCase()}${text.substring(1)}' : '';
}
