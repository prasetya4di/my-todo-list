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
        Future.value(_getTodo()).then((value) {
          _todos = value;
          emit(const TodoState.loaded());
        }).catchError((error) {
          emit(TodoState.error(error.toString()));
        });
      }, onAddTodo: (name) {
        emit(const TodoState.loading());
        Future.value(_addTodo(Todo(name, DateTime.now()))).then((value) {
          _todos.add(value);
          emit(const TodoState.added());
        }).catchError((error) {
          emit(TodoState.error(error.toString()));
        });
      }, onFinishTodo: (todo) {
        emit(const TodoState.loading());
        Future.value(_finishTodo(todo)).then((value) {
          _todos[_todos.indexOf(todo)] = value;
          emit(const TodoState.finished());
        }).catchError((error) {
          emit(TodoState.error(error.toString()));
        });
      });
    });
  }
}
