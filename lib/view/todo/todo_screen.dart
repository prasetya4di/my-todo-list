import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/view/todo/bloc/todo_bloc.dart';
import 'package:my_todo_list/view/todo/bloc/todo_state.dart';
import 'package:my_todo_list/view/todo/widgets/add_todo_dialog.dart';
import 'package:my_todo_list/view/todo/widgets/empty_todo.dart';
import 'package:my_todo_list/view/todo/widgets/list_todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var todoBloc = context.read<TodoBloc>();
    todoBloc.add(const GetTodoEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo list"),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
          builder: (context, state) {
            if (todoBloc.todos.isEmpty) {
              return const EmptyTodo();
            } else {
              return ListTodo(todos: todoBloc.todos);
            }
          },
          listener: (context, state) {}),
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
