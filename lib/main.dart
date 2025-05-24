import 'package:exerciseapp/view/screens/home_screen.dart';
import 'package:exerciseapp/viewModel/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:exerciseapp/viewModel/blocs/exercise_bloc/exercise_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/exercise_repository.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider(
        create: (_) => ExerciseBloc(ExerciseRepository())..add(LoadExercises()),
        child: HomeScreen(),
      ),
    );
  }
}
