import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key, required this.p});

  final Student p;

  @override
  State<StudentPage> createState() => _StudentPageState(p);
}

class _StudentPageState extends State<StudentPage> {
  _StudentPageState(this.p);

  final Student p;
  List<Submission> listAssignments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Center(child: Text('Welcome ${p.toString()}')),
      ),
      body: FutureBuilder<Tuple2<StateOfRequest, List<Submission>>>(
        future: JSONPresenter.getSubmissions(p),
        builder: (BuildContext context,
            AsyncSnapshot<Tuple2<StateOfRequest, List<Submission>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var state = (snapshot.data)!.item1;
          if (state == StateOfRequest.loading) {
            return const CircularProgressIndicator();
          } else if (state == StateOfRequest.failure) {
            //TODO failure
          }
          //Else state is successful
          listAssignments = (snapshot.data)!.item2;

          List<Widget> assignmentCards = [];

          for (Submission a in listAssignments) {
            assignmentCards.add(getSubmissionCard(a, true));
          }

          return ListView(
            children: assignmentCards,
          );
        },
      ),
    );
  }

  Widget getSubmissionCard(Submission a, bool isSubmittable) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text(a.assignmentName),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: VerticalDivider(
                  color: Theme.of(context).primaryColor,
                  width: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Due Date: ${DateFormat('yyyy-MM-dd @ kk:mm').format(a.dateSubmitted)}'),
                    Text('No. of Points: ${a.earnedPoints}'),
                    Text('No. of Test Cases: ${a.maxPoints}')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getSubmissionBody(Submission ss) {
    double perc = ss.earnedPoints * 100.0 / ss.maxPoints;
    String percString = perc.toStringAsFixed(2);
    percString += '%';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Result: ${ss.result}'),
        Text('Number of Cases: ${ss.maxPoints}'),
        Text('Number of successes: ${ss.earnedPoints}'),
        const Text('Score on assignment:'),
        Text(percString),
      ],
    );
  }
}

class Submission {
  late String id;
  late String studentID;
  late String instructorID;
  late String assignmentID;
  late String assignmentName;
  late String result;
  late int submitNumber;
  late int maxPoints;
  late int earnedPoints;
  late DateTime dateSubmitted;

  Submission(
      {required this.id,
      required this.studentID,
      required this.instructorID,
      required this.assignmentID,
      required this.assignmentName,
      required this.result,
      required this.submitNumber,
      required this.maxPoints,
      required this.earnedPoints,
      required this.dateSubmitted});
}

class Assignment {
  late String id;
  late String instructorId;
  late String name;
  late String desc;
  late int points;
  late DateTime dueDate;
  late List<dynamic> inputs;
  late List<dynamic> outputs;

  Assignment(this.id, this.instructorId, this.name, this.desc, this.points,
      this.dueDate, this.inputs, this.outputs);
}

class Student {}

class JSONPresenter {
  static Future<Tuple2<StateOfRequest, List<Submission>>> getSubmissions(
      Student p) async {
    return const Tuple2(StateOfRequest.loading, []);
  }
}

enum StateOfRequest { loading, success, failure }
