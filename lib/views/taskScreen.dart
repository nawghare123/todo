
// task_screen.dart
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/taskModel.dart';
import 'package:todo_app/viewmodels/taskViewModel.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ruchika");
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<TaskViewModel>(
              builder: (context, model, child) {
                var tasks = model.tasks;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var task = tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                    );
                  },
                );
              },
            ),
          ),
          TaskForm(),
        ],
      ),
    );
  }
}


class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _assignedToController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("ruchika123");
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _assignedToController,
              decoration: InputDecoration(labelText: 'Assigned To (Email)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var task = Task(
                    id: '',
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdBy: '',
                    assignedTo: _assignedToController.text,
                  );
                  Provider.of<TaskViewModel>(context, listen: false)
                      .addTask(task);
                  _titleController.clear();
                  _descriptionController.clear();
                  _assignedToController.clear();
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
