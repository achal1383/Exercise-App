import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/entities/exercise.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onComplete;

  const ExerciseDetailScreen({
    required this.exercise,
    required this.onComplete,
    super.key,
  });

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen>
    with SingleTickerProviderStateMixin {
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isRunning = false;
  bool _isCompleted = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.exercise.duration;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.exercise.duration),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isCompleted = false;
      _isRunning = true;
      _remainingSeconds = widget.exercise.duration;
    });

    _animationController.reset();
    _animationController.forward();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          timer.cancel();
          _isRunning = false;
          _isCompleted = true;
          widget.onComplete();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: Text(widget.exercise.name),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.exercise.description.capitalize(
                  widget.exercise.description,
                ),
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '⏱ Duration:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${widget.exercise.duration} seconds',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '💪 Difficulty:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.exercise.difficulty,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: CircularProgressIndicator(
                          value: _animationController.value,
                          strokeWidth: 12,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepPurple,
                          ),
                        ),
                      ),
                      Text(
                        'Time Left: $_remainingSeconds s',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isRunning ? 'Running...' : 'Start',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (_isCompleted)
                Center(
                  child: Text(
                    '🎉 Exercise Completed!',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on String {
  String capitalize(String text) =>
      text.isNotEmpty ? '${text[0].toUpperCase()}${text.substring(1)}' : '';
}
