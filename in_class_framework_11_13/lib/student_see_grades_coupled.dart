import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_class_framework_11_13/student_see_grades_independent.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class StudentSubmissionsPage extends StatefulWidget {
  const StudentSubmissionsPage({super.key, required this.s, required this.a});

  final Student s;
  final Assignment a;

  @override
  State<StudentSubmissionsPage> createState() =>
      _StudentSubmissionsPageState(s, a);
}

class _StudentSubmissionsPageState extends State<StudentSubmissionsPage> {
  _StudentSubmissionsPageState(this.s, this.a);

  final Student s;
  final Assignment a;
  bool showSpinner = false;
  List<Submission> submissions = [];

  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getSubmissions(s, a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: BlocConsumer<StudentCubit, StudentCubitState>(
          listener: (BuildContext context, StudentCubitState state) {
            if (state is StudentGetSubmissionsLoading) {
              setState(() {
                showSpinner = true;
              });
            }
            if (state is StudentGetSubmissionsFailure) {
              setState(() {
                showSpinner = false;
              });
            }
            if (state is StudentGetSubmissionsSuccess) {
              submissions = state.submissions;
            }
          },
          builder: (BuildContext context, StudentCubitState state) {
            if (state is StudentGetSubmissionsLoading) {
              return const Text('');
            }
            if (state is StudentGetSubmissionsFailure) {
              return const Center(
                child: Text('Error loading data. Refresh to try again.'),
              );
            }
            List<Widget> list =
                submissions.map((e) => getSubmissionCard(e)).toList();

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: list,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getSubmissionCard(Submission ss) {
    String percString =
        (ss.earnedPoints * 1.0 / ss.maxPoints * 100).toStringAsFixed(2);
    percString += '%';
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Score on assignment: '),
              Text(percString),
              const Spacer(),
              const Text('Date submitted  '),
              Text(DateFormat('yyyy-MM-dd @ kk:mm').format(ss.dateSubmitted))
            ],
          ),
        ),
      ),
    );
  }
}

class StudentCubit extends Cubit<StudentCubitState> {
  StudentCubit() : super(StudentInitial());

  Future<void> getSubmissions(Student s, Assignment a) async {
    emit(StudentGetSubmissionsLoading());
    try {
      List<Submission> subs = [];
      // todo get data

      // emit

      //todo get more data

      //emit success at end
      emit(StudentGetSubmissionsSuccess(subs));
    } catch (e) {
      emit(StudentGetSubmissionsFailure(Exception(e.toString())));
    }
  }
}

abstract class StudentCubitState extends Equatable {}

class StudentInitial extends StudentCubitState {
  @override
  List<Object> get props => [];
}

//-----------------Submission loading, success, and failure states -----------------------

class StudentGetSubmissionsLoading extends StudentCubitState {
  @override
  List<Object> get props => [];
}

class StudentGetSubmissionsSuccess extends StudentCubitState {
  final List<Submission> submissions;
  StudentGetSubmissionsSuccess(this.submissions);

  @override
  List<Object> get props => [submissions];
}

class StudentGetSubmissionsFailure extends StudentCubitState {
  final Exception e;

  StudentGetSubmissionsFailure(this.e);

  @override
  List<Object> get props => [e];
}
