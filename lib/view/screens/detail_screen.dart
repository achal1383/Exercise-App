import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/exercise_model.dart';
import '../../viewModel/blocs/exercise_bloc/exercise_bloc.dart';
import '../../viewModel/blocs/exercise_bloc/exercise_event.dart';


class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  ExerciseDetailScreen({required this.exercise});

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> with SingleTickerProviderStateMixin {
  bool started = false;
  int remainingSeconds = 0;
  Timer? _timer;
  late AnimationController _controller;

  void startTimer() {
    setState(() {
      started = true;
      remainingSeconds = widget.exercise.duration;
    });

    _controller.forward();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        _controller.stop();
        BlocProvider.of<ExerciseBloc>(context).add(MarkExerciseCompleted(widget.exercise.id));
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Completed!'),
            content: Text('Exercise completed.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: Text('OK'),
              )
            ],
          ),
        );
      } else {
        setState(() => remainingSeconds--);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: widget.exercise.duration));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.exercise;
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(e.name, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    SizedBox(height: 12),
                    Text(e.description, style: TextStyle(fontSize: 16, color: Colors.black87)),
                    SizedBox(height: 12),
                    Text('Duration: ${e.duration}s', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.deepPurple[700])),
                    Text('Difficulty: ${e.difficulty}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.deepPurple[700])),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            if (started)
              Center(
                child: Column(
                  children: [
                    Text(
                      'Time Remaining: $remainingSeconds seconds',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: _controller.value,
                      color: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple[100],
                    ),
                  ],
                ),
              )
            else
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.play_arrow),
                  label: Text('Start Exercise'),
                  onPressed: startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
