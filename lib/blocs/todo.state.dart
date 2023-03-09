abstract class TodoState {}

class AddTodoState extends TodoState {}

class RemoveTodoState extends TodoState {}

class InitTodoState extends TodoState {
  InitTodoState(int i);
}
