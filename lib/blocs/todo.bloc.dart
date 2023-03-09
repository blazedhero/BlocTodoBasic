import 'dart:developer';

import 'package:b/blocs/todo.state.dart';
import 'package:b/repositories/todorepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todomodels.dart';

class TodoBloc extends Cubit<TodoState> {
  final _todoRepo = TodoRepository();
  final Database database;
  TodoBloc({required this.database}) : super(InitTodoState(0));

  int _counter = 1;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> getTodos() async {
    try {
      _todos = await _todoRepo.getTodos(database: database);
      emit(InitTodoState(_counter++));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addTodos(String text) async {
    try {
      await _todoRepo.addTodo(database: database, text: text);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeTodo(int id) async {
    try {
      await _todoRepo.removeTodo(database: database, id: id);
      emit(InitTodoState(_counter++));
      getTodos();
    } catch (e) {
      log(e.toString());
    }
  }
}
