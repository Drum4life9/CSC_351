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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Center(child: Text('Submissions for ${a.name}')),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<StudentCubit>().getSubmissions(s, a),
        child: ModalProgressHUD(
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
              submissions
                  .sort((a, b) => a.dateSubmitted.compareTo(b.dateSubmitted));
              List<Widget> list =
                  submissions.map((e) => getSubmissionCard(e)).toList();

              list.insert(0, const Divider());
              list.insert(0, const Text('Submissions: '));

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

  Future<void> getAssignments(Student s) async {
    emit(StudentGetAssignmentsLoading());
    try {
      List<Assignment> assignments = [];
      emit(StudentGetAssignmentsSuccess(assignments));
    } catch (e) {
      //todo error checking
      emit(StudentGetAssignmentsFailure(Exception(e.toString())));
    }
  }

  Future<void> getSubmissions(Student s, Assignment a) async {
    emit(StudentGetSubmissionsLoading());
    try {
      List<Submission> subs = [];
      emit(StudentGetSubmissionsSuccess(subs));
    } catch (e) {
      emit(StudentGetSubmissionsFailure(Exception(e.toString())));
    }
  }

  Future<void> submitAssignment(Student s, Assignment a, String code) async {
    emit(StudentSubmitAssignmentLoading());
    try {
      emit(StudentSubmitAssignmentSuccess());
    } catch (e) {
      emit(StudentSubmitAssignmentFailure(Exception(e.toString())));
    }
  }

  Future<void> getUnsubmittedAssignments(Student s) async {
    emit(StudentGetUnsubmittedLoading());
    try {
      List<Assignment> assigns = [];
      emit(StudentGetUnsubmittedSuccess(assigns));
    } catch (e) {
      emit(StudentGetUnsubmittedFailure(Exception(e.toString())));
    }
  }
}

abstract class StudentCubitState extends Equatable {}

class StudentInitial extends StudentCubitState {
  @override
  List<Object> get props => [];
}

//-----------------Student loading, success, and failure states -----------------------

class StudentGetAssignmentsLoading extends StudentCubitState {
  @override
  List<Object> get props => [];
}

//signifies that the user is now logged in
class StudentGetAssignmentsSuccess extends StudentCubitState {
  final List<Assignment> assignments;

  StudentGetAssignmentsSuccess(this.assignments);

  @override
  List<Object> get props => [assignments];
}

//signifies that there was an error with login
class StudentGetAssignmentsFailure extends StudentCubitState {
  final Exception e;

  StudentGetAssignmentsFailure(this.e);

  @override
  List<Object> get props => [e];
}

//-----------------Submission loading, success, and failure states -----------------------

class StudentSubmitAssignmentLoading extends StudentCubitState {
  @override
  List<Object> get props => [];
}

//signifies that the user is now logged in
class StudentSubmitAssignmentSuccess extends StudentCubitState {
  StudentSubmitAssignmentSuccess();

  @override
  List<Object> get props => [];
}

//signifies that there was an error with login
class StudentSubmitAssignmentFailure extends StudentCubitState {
  final Exception e;

  StudentSubmitAssignmentFailure(this.e);

  @override
  List<Object> get props => [e];
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

//-----------------Unsubmitted Assignments loading, success, and failure states -----------------------

class StudentGetUnsubmittedLoading extends StudentCubitState {
  @override
  List<Object> get props => [];
}

class StudentGetUnsubmittedSuccess extends StudentCubitState {
  final List<Assignment> assignments;
  StudentGetUnsubmittedSuccess(this.assignments);

  @override
  List<Object> get props => [assignments];
}

class StudentGetUnsubmittedFailure extends StudentCubitState {
  final Exception e;

  StudentGetUnsubmittedFailure(this.e);

  @override
  List<Object> get props => [e];
}
