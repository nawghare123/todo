import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodels/taskViewModel.dart';
import 'package:todo_app/views/taskScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: MaterialApp(
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskScreen(),
      ),
    ),
  );
}
