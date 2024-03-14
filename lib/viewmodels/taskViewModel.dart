import 'package:flutter/material.dart';
import 'package:todo_app/models/taskModel.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title, String description) {
    final newTask = Task(id: DateTime.now().toString(), title: title, description: description);
    _tasks.add(newTask);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
  void updateTask(String id, String newTitle, String newDescription) {
  final taskIndex = _tasks.indexWhere((task) => task.id == id);
  if (taskIndex != -1) {
    _tasks[taskIndex] = Task(id: id, title: newTitle, description: newDescription);
    notifyListeners();
  }
}

}
