import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';
import 'package:my_todo_list/domain/add_todo.dart';
import 'package:my_todo_list/domain/finish_todo.dart';
import 'package:my_todo_list/domain/get_todo.dart';
import 'package:my_todo_list/view/todo/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodo _addTodo;
  final FinishTodo _finishTodo;
  final GetTodo _getTodo;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodoBloc(this._addTodo, this._finishTodo, this._getTodo)
      : super(const TodoState.initial()) {
    on<TodoEvent>((event, emit) {
      event.when(onGetTodo: () {
        emit(const TodoState.loading());
        _todos = _getTodo();
        emit(const TodoState.loaded());
      }, onAddTodo: (name) {
        emit(const TodoState.loading());
        Todo todo = _addTodo(Todo(name, DateTime.now()));
        _todos.add(todo);
        emit(const TodoState.added());
      }, onFinishTodo: (todo) {
        emit(const TodoState.loading());
        _todos[_todos.indexOf(todo)] = _finishTodo(todo);
        emit(const TodoState.finished());
      });
    });
  }
}
