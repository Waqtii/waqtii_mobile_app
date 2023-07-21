import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/utils/api_service.dart';
import 'package:waqtii/features/home_features/to_do/domain/models/task_model_by_id/task_model_by_id.dart';
import 'package:waqtii/features/home_features/to_do/domain/models/tasks_model.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/state.dart';

class TODOCubit extends Cubit<TODOStates> {
  TODOCubit() : super(TODOInitialState());

  static TODOCubit get(context) => BlocProvider.of(context);

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(ChangeBottomSheetState());
  }

  var selectedPriority;

  void changePriority(value) {
    selectedPriority = value;
    emit(ChangePriorityState());
  }

  void changeStatus(value, model, context) {
    if (value == "TODO") {
      TODOCubit.get(context).updateTask(id: model.id!, status: 'TODO');
    }
    if (value == "IN_PROGRESS") {
      TODOCubit.get(context).updateTask(id: model.id!, status: 'IN_PROGRESS');
    }
    if (value == "DONE") {
      TODOCubit.get(context).updateTask(id: model.id!, status: 'DONE');
    }
    if (value == "low") {
      TODOCubit.get(context).updateTask(id: model.id!, priority: 'low');
    }
    if (value == "mid") {
      TODOCubit.get(context).updateTask(id: model.id!, priority: 'mid');
    }
    if (value == "high") {
      TODOCubit.get(context).updateTask(id: model.id!, priority: 'high');
    }

    emit(UpdateTaskSuccessState());
  }

  createTask({required String title, required String priority}) {
    emit(CreateTaskLoadingState());
    ApiService.postData(
        token: '8a5c235aa21b477c3fe119d0dc12e05fdb615d0f',
        url: 'tasks/create/',
        data: {'title': title, 'priority': priority}).then((value) {
      getTasks();
      emit(CreateTaskSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(CreateTaskErrorState());
    });
  }

  TasksModel? tasksModel;
  List<TasksModel> tasksList = [];

  getTasks() {
    emit(GetTasksLoadingState());
    ApiService.getData(
      token: '8a5c235aa21b477c3fe119d0dc12e05fdb615d0f',
      url: 'tasks/',
    ).then((value) {
      List<dynamic> jsonData = value.data;
      tasksList.clear();
      for (var json in jsonData) {
        TasksModel task = TasksModel.fromJson(json);
        tasksList.add(task);
      }

      emit(GetTasksSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetTasksErrorState());
    });
  }

  TaskModelById? taskModelById;
  // DataItem? dataItem;
  Future getTaskById({required int id}) {
    emit(GetTaskByIdLoadingState());
    return ApiService.getData(
      token: '8a5c235aa21b477c3fe119d0dc12e05fdb615d0f',
      url: 'tasks/$id/',
    ).then((value) {
      taskModelById = TaskModelById.fromJson(value.data);
      // print(taskModelById?.dataItem);
      // dataItem = DataItem.fromJson(taskModelById!.dataItem);

      emit(GetTaskByIdSuccessState(taskModelById!));
    }).catchError((e) {
      print("Error from getTaskById ${e.toString()}");
      emit(GetTaskByIdErrorState());
    });
  }

  updateTask({
    String? title,
    String? status,
    String? priority,
    String? description,
    String? notes,
    required int id,
  }) {
    emit(UpdateTaskLoadingState());
    ApiService.postData(
        token: '8a5c235aa21b477c3fe119d0dc12e05fdb615d0f',
        url: 'tasks/update/$id/',
        data: {
          'title': title,
          'status': status,
          'priority': priority,
          'description': description,
          'notes': notes,
        }).then((value) {
      getTasks();
      getTaskById(id: id);
      emit(UpdateTaskSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

  deleteTask({required int id}) {
    ApiService.deleteData(
            url: 'tasks/delete/$id/',
            token: '8a5c235aa21b477c3fe119d0dc12e05fdb615d0f')
        .then((value) {
      getTasks();
      emit(DeleteTaskSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }
}
