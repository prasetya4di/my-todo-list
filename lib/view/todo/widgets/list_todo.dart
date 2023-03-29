import 'package:flutter/material.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/view/todo/widgets/todo_item.dart';

class ListTodo extends StatelessWidget {
  final List<Todo> todos;

  const ListTodo({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        Todo todo = todos[index];

        return TodoItem(todo: todo);
      },
    );
  }
}
