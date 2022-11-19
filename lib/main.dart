import 'package:flutter/material.dart';
import 'package:flutterlevel2task2/QuizQuestion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterLevel2Task2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('FlutterLevel2Task2'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitleSection(),
              Expanded(child: DismissableQuizSection())
            ],
          )),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Quiz instructions', style: Theme.of(context).textTheme.headline1),
        Text('Swipe right for true, swipe left for false.',
            style: Theme.of(context).textTheme.headline2),
      ]),
    );
  }
}

class DismissableQuizSection extends StatefulWidget {
  const DismissableQuizSection({Key? key}) : super(key: key);

  @override
  State<DismissableQuizSection> createState() => _DismissableQuizSectionState();
}

class _DismissableQuizSectionState extends State<DismissableQuizSection> {
  final items = generateQuiz();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: UniqueKey(),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                var currentSwipedItem = items[index];

                if (direction == DismissDirection.startToEnd &&
                        currentSwipedItem.trueOrFalse ||
                    direction == DismissDirection.endToStart &&
                        !currentSwipedItem.trueOrFalse) {
                  items.removeAt(index);
                } else {
                  // Then show a snackbar.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Wrong!')));
                }
              });
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.transparent),
            child: ListTile(
              title: Text(item.question),
            ),
          );
        });
  }
}

List<QuizQuestion> generateQuiz() {
  return [
    QuizQuestion(
        question: 'Marrakesh is the capital of Morocco', trueOrFalse: false),
    QuizQuestion(
        question: 'The black box in a plane is black', trueOrFalse: false),
    QuizQuestion(
        question: 'Walt Disney holds the record for the most Oscars',
        trueOrFalse: true),
    QuizQuestion(
        question: 'Dolphins are actually very smart.', trueOrFalse: true),
  ];
}
