import 'package:flutter/material.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, Object>> questions = [
    {
      "question": "What is the capital of France?",
      "answers": ["Paris", "London", "Berlin", "Rome"],
      "correct": "Paris"
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "answers": ["Earth", "Mars", "Jupiter", "Venus"],
      "correct": "Mars"
    },
    {
      "question": "Who developed Flutter?",
      "answers": ["Microsoft", "Google", "Apple", "Amazon"],
      "correct": "Google"
    },
  ];

  int currentIndex = 0;
  int score = 0;

  void checkAnswer(String answer) {
    if (answer == questions[currentIndex]["correct"]) {
      score++;
    }
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentIndex];
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion["question"] as String,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...(currentQuestion["answers"] as List<String>).map((answer) {
              return ElevatedButton(
                onPressed: () => checkAnswer(answer),
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Score: $score / $total",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => QuizScreen()),
                );
              },
              child: const Text("Restart Quiz"),
            )
          ],
        ),
      ),
    );
  }
}
