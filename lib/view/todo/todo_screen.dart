import 'package:flutter/material.dart';
import 'package:my_todo_list/view/todo/widgets/add_todo_dialog.dart';
import 'package:my_todo_list/view/todo/widgets/empty_todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo list"),
      ),
      body: const SingleChildScrollView(child: EmptyTodo()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTodoDialog();
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
