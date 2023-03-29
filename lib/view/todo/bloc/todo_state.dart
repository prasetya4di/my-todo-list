import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_todo_list/data/model/entity/todo.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.onGetTodo() = GetTodoEvent;

  const factory TodoEvent.onAddTodo(String name) = AddTodoEvent;

  const factory TodoEvent.onFinishTodo(Todo todo) = FinishTodoEvent;
}

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = TodoInitialState;

  const factory TodoState.loading() = TodoLoadingState;

  const factory TodoState.error(String message) = TodoErrorState;

  const factory TodoState.loaded() = TodoLoadedState;

  const factory TodoState.added() = TodoAddedState;

  const factory TodoState.finished() = TodoFinishedState;
}
