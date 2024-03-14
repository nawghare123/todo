import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/taskModel.dart';

class TaskViewModel extends ChangeNotifier {
  late DatabaseReference _tasksRef;
  late User _user;

  List<Task> _tasks = [];

  TaskViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp();
    _user = FirebaseAuth.instance.currentUser!;
    _tasksRef = FirebaseDatabase.instance.reference().child('tasks');

    _tasksRef.onChildAdded.listen((event) {
      var data = event.snapshot.value;
      if (data != null) {
        var task = Task(
          id: event.snapshot.key!,
          title: (data['title'] ?? ''),
          description: (data['description'] ?? '') ,
          createdBy: (data['createdBy'] ?? '') ,
          assignedTo: (data['assignedTo'] ?? ''),
        );
        _tasks.add(task);
        notifyListeners();
      }
    });

    _tasksRef.onChildChanged.listen((event) {
      var index = _tasks.indexWhere((element) => element.id == event.snapshot.key);
      var data = event.snapshot.value;
      if (index != -1 && data != null) {
        _tasks[index] = Task(
          id: event.snapshot.key!,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          createdBy: data['createdBy'] ?? '',
          assignedTo: data['assignedTo'] ?? '',
        );
        notifyListeners();
      }
    });
  }



  List<Task> get tasks => _tasks;

  Future<void> addTask(Task task) async {
    await _tasksRef.push().set({
      'title': task.title,
      'description': task.description,
      'createdBy': _user.email,
      'assignedTo': task.assignedTo,
    });
  }

  Future<void> updateTask(Task task) async {
    await _tasksRef.child(task.id).update({
      'title': task.title,
      'description': task.description,
      'createdBy': task.createdBy,
      'assignedTo': task.assignedTo,
    });
  }
}
