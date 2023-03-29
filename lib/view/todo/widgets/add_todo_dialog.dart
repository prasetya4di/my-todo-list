import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/util/constants/routes.dart';
import 'package:my_todo_list/view/todo/bloc/todo_bloc.dart';
import 'package:my_todo_list/view/todo/bloc/todo_state.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new todo item'),
      content: TextField(
        controller: _textFieldController,
        decoration: const InputDecoration(hintText: 'Type your new todo'),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            String value = _textFieldController.text;
            context.read<TodoBloc>().add(AddTodoEvent(value));
            Navigator.popUntil(context, ModalRoute.withName(Routes.home));
          },
        ),
      ],
    );
  }
}
