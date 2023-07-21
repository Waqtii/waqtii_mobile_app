import 'package:waqtii/features/home_features/to_do/domain/models/task_model_by_id/task_model_by_id.dart';

abstract class TODOStates {}

class TODOInitialState extends TODOStates {}

//Change Priority

class ChangePriorityState extends TODOStates {}

// Create Task

class CreateTaskLoadingState extends TODOStates {}

class CreateTaskSuccessState extends TODOStates {}

class CreateTaskErrorState extends TODOStates {}

// Get Tasks

class GetTasksLoadingState extends TODOStates {}

class GetTasksSuccessState extends TODOStates {}

class GetTasksErrorState extends TODOStates {}

// Get Task By Id

class GetTaskByIdLoadingState extends TODOStates {}

class GetTaskByIdSuccessState extends TODOStates {
  TaskModelById taskModelById;
  GetTaskByIdSuccessState(this.taskModelById);
}

class GetTaskByIdErrorState extends TODOStates {}

// Delete Task

class DeleteTaskSuccessState extends TODOStates {}

class DeleteTaskErrorState extends TODOStates {}

// Update Task

class UpdateTaskLoadingState extends TODOStates {}

class UpdateTaskSuccessState extends TODOStates {}

class UpdateTaskErrorState extends TODOStates {}

//

class ChangeBottomSheetState extends TODOStates {}
