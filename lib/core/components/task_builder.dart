import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:waqtii/features/home_features/to_do/domain/models/tasks_model.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/cubit.dart';
import 'package:waqtii/features/home_features/to_do/presentation/views/task_details.dart';

Widget tasksBuilder({
  required List<TasksModel> tasks,
}) =>
    ConditionalBuilder(
      condition: true,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget buildTaskItem(TasksModel model, context) => Dismissible(
      key: Key(model.id.toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                // if (model['status'] == 'IN_PROGRESS') {
                //   TODOCubit.get(context).updateData(
                //     status: 'DONE',
                //     id: model['id'],
                //   );
                // }
                // if (model['status'] == 'TODO') {
                //   TODOCubit.get(context).updateData(
                //     status: 'DONE',
                //     id: model['id'],
                //   );
                // }
                // if (model['status'] == 'DONE') {
                //   TODOCubit.get(context).updateData(
                //     status: 'TODO',
                //     id: model['id'],
                //   );
                // }
              },
              icon: Icon(
                model.status == 'DONE'
                    ? Icons.check_circle_outline
                    : Icons.circle_outlined,
                color: model.status == 'DONE'
                    ? Colors.green
                    : model.status == 'IN_PROGRESS'
                        ? Colors.blue
                        : Colors.grey,
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetails(tasksModel: model),
                      ));
                },
                child: Text(
                  '${model.title}',
                  style: TextStyle(
                      decoration: model.status == 'DONE'
                          ? TextDecoration.lineThrough
                          : null,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: model.status == 'DONE' ? Colors.grey[600] : null),
                ),
              ),
            ),
            Container(
              height: 35,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: model.status == 'TODO'
                        ? Colors.grey
                        : model.status == 'IN_PROGRESS'
                            ? Colors.blue
                            : Colors.green.shade400,
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ],
                color: model.status == 'TODO'
                    ? Colors.grey.shade100
                    : model.status == 'IN_PROGRESS'
                        ? Colors.blue.shade100
                        : Colors.green.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.25,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: model.status,
                    onChanged: (newValue) {
                      TODOCubit.get(context).changeStatus(newValue, model);
                    },
                    items: ["TODO", "IN_PROGRESS", "DONE"]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Center(
                              child: Text(
                                e,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
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
      onDismissed: (direction) {
        TODOCubit.get(context).deleteTask(
          id: model.id!,
        );
      },
    );
