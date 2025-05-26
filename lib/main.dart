import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme.dart';
import 'features/fetchexercises/data/repository/exercise_repository_impl.dart';
import 'features/fetchexercises/presentation/blocs/exercise_bloc/exercise_bloc.dart';
import 'features/fetchexercises/presentation/blocs/exercise_bloc/exercise_event.dart';
import 'features/fetchexercises/presentation/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercise App',
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (_) =>
            ExerciseBloc(ExerciseRepositoryImpl())..add(LoadExercises()),
        child: HomeScreen(),
      ),
    );
  }
}
