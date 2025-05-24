import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/exercise_model.dart';
import '../../viewModel/blocs/exercise_bloc/exercise_bloc.dart';
import '../../viewModel/blocs/exercise_bloc/exercise_event.dart';


class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  ExerciseDetailScreen({required this.exercise});

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _remaining = 0;
  bool _isCompleted = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  void _startTimer() {
    setState(() {
      _remaining = widget.exercise.duration;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remaining == 0) {
        timer.cancel();
        setState(() {
          _isCompleted = true;
        });
        BlocProvider.of<ExerciseBloc>(context).add(MarkExerciseCompleted(widget.exercise.id));
        Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
      } else {
        setState(() {
          _remaining--;
        });
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.exercise.name, style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.exercise.description, style: TextStyle(fontSize: 18, color: Colors.grey[800])),
            SizedBox(height: 20),
            Text('⏱ Duration: ${widget.exercise.duration}s', style: TextStyle(fontSize: 18)),
            Text('🏋️ Difficulty: ${widget.exercise.difficulty}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            if (_remaining > 0)
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: _animation.value,
                            strokeWidth: 8,
                            backgroundColor: Colors.deepPurple[200],
                            valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                          ),
                        ),
                        Text('$_remaining s', style: TextStyle(fontSize: 24, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            if (_isCompleted)
              Center(
                child: Text('✅ Exercise Completed!', style: TextStyle(fontSize: 24, color: Colors.green[800], fontWeight: FontWeight.bold)),
              ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _remaining == 0 ? _startTimer : null,
                child: Text('Start', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
