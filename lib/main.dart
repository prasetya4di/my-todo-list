import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/util/constants/routes.dart';
import 'package:my_todo_list/view/todo/bloc/todo_bloc.dart';
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
    return BlocProvider(
      create: (_) => TodoBloc(di.get(), di.get(), di.get()),
      child: MaterialApp(
        title: 'My Todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {Routes.home: (_) => const TodoScreen()},
        initialRoute: Routes.home,
      ),
    );
  }
}
