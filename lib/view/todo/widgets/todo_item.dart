import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/view/todo/bloc/todo_bloc.dart';
import 'package:my_todo_list/view/todo/bloc/todo_state.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<TodoBloc>().add(TodoEvent.onFinishTodo(todo));
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          todo.name.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        todo.name,
        style: TextStyle(
          color: todo.finishedDate != null ? Colors.grey : Colors.black,
          decoration: todo.finishedDate != null
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
    );
  }
}
