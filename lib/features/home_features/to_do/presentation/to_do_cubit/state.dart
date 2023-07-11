abstract class TODOStates {}

class TODOInitialState extends TODOStates {}

//Change Priority

class ChangePriorityState extends TODOStates {}

// Create Task

class CreateTaskLoadingState extends TODOStates {}

class CreateTaskSuccessState extends TODOStates {}

class CreateTaskErrorState extends TODOStates {}

// Get Task

class GetTaskLoadingState extends TODOStates {}

class GetTaskSuccessState extends TODOStates {}

class GetTaskErrorState extends TODOStates {}

// Delete Task

class DeleteTaskSuccessState extends TODOStates {}

class DeleteTaskErrorState extends TODOStates {}

// Update Task

class UpdateTaskLoadingState extends TODOStates {}

class UpdateTaskSuccessState extends TODOStates {}

class UpdateTaskErrorState extends TODOStates {}

//

class ChangeBottomSheetState extends TODOStates {}
