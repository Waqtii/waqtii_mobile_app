import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:waqtii/features/home_features/to_do/domain/models/task_model_by_id/task_model_by_id.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/cubit.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/state.dart';

class TaskDetails extends StatelessWidget {
  TaskDetails({
    Key? key,
    required this.taskModelById,
  }) : super(key: key);

  TaskModelById taskModelById;

  String convertDateString() {
    DateTime dateTime =
        DateTime.parse(taskModelById.dataItem!.createdAt.toString());
    String formattedDateTime =
        DateFormat('yyyy-MM-dd   hh:mm:ss a').format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    var descriptionController = TextEditingController(
        text: TODOCubit.get(context).taskModelById?.dataItem?.description);
    var noteController = TextEditingController(
        text: TODOCubit.get(context).taskModelById?.dataItem?.notes);
    var titleController = TextEditingController(
        text: TODOCubit.get(context).taskModelById?.dataItem?.title);
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<TODOCubit, TODOStates>(
      listener: (context, state) {
        if (state is GetTaskByIdLoadingState || state is UpdateTaskLoadingState)
          LinearProgressIndicator();
        if (state is DeleteTaskSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFFFAFAFA),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FittedBox(
                          child: Text(
                            "Created at ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        FittedBox(
                            child: FittedBox(child: Text(convertDateString()))),
                      ],
                    ),
                  ),
                ),
                FittedBox(
                  child: IconButton(
                    alignment: AlignmentDirectional.center,
                    onPressed: () {
                      TODOCubit.get(context).deleteTask(
                        id: taskModelById.dataItem!.id!,
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! GetTaskByIdLoadingState,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (state is GetTaskByIdLoadingState)
                      //   LinearProgressIndicator(),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (taskModelById.dataItem?.status ==
                                      'IN_PROGRESS') {
                                    TODOCubit.get(context).updateTask(
                                        id: taskModelById.dataItem!.id!,
                                        status: 'DONE');
                                  }
                                  if (taskModelById.dataItem?.status ==
                                      'TODO') {
                                    TODOCubit.get(context).updateTask(
                                        id: taskModelById.dataItem!.id!,
                                        status: 'DONE');
                                  }
                                  if (taskModelById.dataItem?.status ==
                                      'DONE') {
                                    TODOCubit.get(context).updateTask(
                                        id: taskModelById.dataItem!.id!,
                                        status: 'TODO');
                                  }
                                },
                                icon: Icon(
                                  TODOCubit.get(context)
                                              .taskModelById
                                              ?.dataItem
                                              ?.status ==
                                          'DONE'
                                      ? Icons.check_circle_outline
                                      : Icons.circle_outlined,
                                  color: TODOCubit.get(context)
                                              .taskModelById
                                              ?.dataItem
                                              ?.status ==
                                          'DONE'
                                      ? Colors.green
                                      : TODOCubit.get(context)
                                                  .taskModelById
                                                  ?.dataItem
                                                  ?.status ==
                                              'IN_PROGRESS'
                                          ? Colors.blue
                                          : Colors.grey,
                                ),
                              ),
                              Expanded(
                                child: Form(
                                  key: formkey,
                                  child: TextFormField(
                                    validator: ((value) {
                                      if (value!.isEmpty) {
                                        return 'Title Must not be less than 1 char';
                                      }
                                      return null;
                                    }),
                                    onChanged: (value) {
                                      if (formkey.currentState!.validate()) {
                                        TODOCubit.get(context).updateTask(
                                            id: taskModelById.dataItem!.id!,
                                            title: value);
                                      }
                                    },
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    controller: titleController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: TODOCubit.get(context)
                                                  .taskModelById
                                                  ?.dataItem
                                                  ?.status ==
                                              'TODO'
                                          ? Colors.grey
                                          : TODOCubit.get(context)
                                                      .taskModelById
                                                      ?.dataItem
                                                      ?.status ==
                                                  'IN_PROGRESS'
                                              ? Colors.blue
                                              : Colors.green.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    ),
                                  ],
                                  color: TODOCubit.get(context)
                                              .taskModelById
                                              ?.dataItem
                                              ?.status ==
                                          'TODO'
                                      ? Colors.grey.shade100
                                      : TODOCubit.get(context)
                                                  .taskModelById
                                                  ?.dataItem
                                                  ?.status ==
                                              'IN_PROGRESS'
                                          ? Colors.blue.shade100
                                          : Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: TODOCubit.get(context)
                                          .taskModelById
                                          ?.dataItem
                                          ?.status,
                                      onChanged: (newValue) {
                                        TODOCubit.get(context).changeStatus(
                                            newValue,
                                            taskModelById.dataItem,
                                            context);
                                      },
                                      items: ["TODO", "IN_PROGRESS", "DONE"]
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    e,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      icon: const SizedBox.shrink(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      isExpanded: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.priority_high_rounded,
                                color: Colors.grey,
                              ),
                              const Expanded(
                                child: Text(
                                  "Priority",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: TODOCubit.get(context)
                                          .taskModelById
                                          ?.dataItem
                                          ?.priority,
                                      onChanged: (newValue) {
                                        TODOCubit.get(context).changeStatus(
                                            newValue,
                                            taskModelById.dataItem,
                                            context);
                                      },
                                      items: ["low", "mid", "high"]
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    e,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      icon: const SizedBox.shrink(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      isExpanded: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          TODOCubit.get(context).updateTask(
                              id: taskModelById.dataItem!.id!,
                              description: value);
                        },
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Add description",
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 120,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Note:",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          TODOCubit.get(context).updateTask(
                              id: taskModelById.dataItem!.id!, notes: value);
                        },
                        controller: noteController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Add note",
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 25,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => LinearProgressIndicator(),
          ),
        );
      },
    );
  }
}
