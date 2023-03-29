import 'package:flutter/material.dart';
import 'package:my_todo_list/util/constants/routes.dart';
import 'package:my_todo_list/view/todo/todo_screen.dart';

import 'core/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {Routes.home: (context) => const TodoScreen()},
      initialRoute: Routes.home,
    );
  }
}
