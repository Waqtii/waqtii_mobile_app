import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:waqtii/features/home/presentation/views/home_screen.dart';
import 'package:waqtii/features/home_features/to_do/domain/models/tasks_model.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/cubit.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/state.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({Key? key, required this.tasksModel}) : super(key: key);

  final TasksModel tasksModel;

  String convertDateString() {
    DateTime dateTime = DateTime.parse(tasksModel.createdAt.toString());
    String formattedDateTime =
        DateFormat('yyyy-MM-dd   hh:mm:ss a').format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    var descriptionController =
        TextEditingController(text: tasksModel.description);
    var noteController = TextEditingController(text: tasksModel.notes);

    return BlocConsumer<TODOCubit, TODOStates>(
      listener: (context, state) {
        if (state is GetTaskSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFFFAFAFA),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    // Handle button press
                                  },
                                  icon: Icon(
                                    tasksModel.status == 'DONE'
                                        ? Icons.check_circle_outline
                                        : Icons.circle_outlined,
                                    color: tasksModel.status == 'DONE'
                                        ? Colors.green
                                        : tasksModel.status == 'IN_PROGRESS'
                                            ? Colors.blue
                                            : Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${tasksModel.title}',
                                    style: TextStyle(
                                      decoration: tasksModel.status == 'DONE'
                                          ? TextDecoration.lineThrough
                                          : null,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: tasksModel.status == 'DONE'
                                          ? Colors.grey[600]
                                          : null,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: tasksModel.status == 'TODO'
                                            ? Colors.grey
                                            : tasksModel.status == 'IN_PROGRESS'
                                                ? Colors.blue
                                                : Colors.green.shade400,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                      ),
                                    ],
                                    color: tasksModel.status == 'TODO'
                                        ? Colors.grey.shade100
                                        : tasksModel.status == 'IN_PROGRESS'
                                            ? Colors.blue.shade100
                                            : Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: tasksModel.status,
                                        onChanged: (newValue) {
                                          TODOCubit.get(context).changeStatus(
                                              newValue, tasksModel);
                                        },
                                        items: ["TODO", "IN_PROGRESS", "DONE"]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Center(
                                                  child: Text(
                                                    e,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        icon: const SizedBox.shrink(),
                                        // Remove the arrow icon
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
                                    boxShadow: [
                                      BoxShadow(
                                        color: tasksModel.status == 'TODO'
                                            ? Colors.grey
                                            : tasksModel.status == 'IN_PROGRESS'
                                                ? Colors.blue
                                                : Colors.green.shade400,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                      ),
                                    ],
                                    color: tasksModel.status == 'TODO'
                                        ? Colors.grey.shade100
                                        : tasksModel.status == 'IN_PROGRESS'
                                            ? Colors.blue.shade100
                                            : Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: tasksModel.priority,
                                        onChanged: (newValue) {
                                          TODOCubit.get(context).changeStatus(
                                            newValue,
                                            tasksModel,
                                          );
                                        },
                                        items: ["low", "mid", "high"]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Center(
                                                  child: Text(
                                                    e,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        icon: const SizedBox.shrink(),
                                        // Remove the arrow icon
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
                          controller: descriptionController,
                          decoration: InputDecoration(
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
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Created at ",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(convertDateString()),
                        ],
                      ),
                    ),
                    IconButton(
                      alignment: AlignmentDirectional.center,
                      onPressed: () {
                        TODOCubit.get(context).deleteTask(
                          id: tasksModel.id!,
                        );
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
