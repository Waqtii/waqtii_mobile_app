import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/core/utils/api_service.dart';
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

  void changeStatus(value, model) {
    if (value == "TODO") {
      // add function to update status
    }
    if (value == "IN_PROGRESS") {
      // add function to update status
    }
    if (value == "DONE") {
      // add function to update status
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
    emit(GetTaskLoadingState());
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

      emit(GetTaskSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetTaskErrorState());
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
