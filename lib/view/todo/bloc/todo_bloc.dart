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
      : super(const TodoInitialState()) {
    on<AddTodoEvent>((event, emit) {
      emit(const TodoState.loading());
      Todo todo = _addTodo(Todo(event.name, DateTime.now()));
      _todos.add(todo);
      emit(const TodoState.added());
    });

    on<FinishTodoEvent>((event, emit) {
      emit(const TodoState.loading());
      Todo todo = _finishTodo(event.todo);
      _todos[_todos.indexOf(todo)] = todo;
      emit(const TodoState.finished());
    });

    on<GetTodoEvent>((event, emit) {
      emit(const TodoState.loading());
      List<Todo> todos = _getTodo();
      _todos = todos;
      emit(const TodoState.loaded());
    });
  }
}
