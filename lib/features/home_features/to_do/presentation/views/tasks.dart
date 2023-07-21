import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waqtii/constants.dart';
import 'package:waqtii/core/components/dropdown.dart';
import 'package:waqtii/core/components/task_builder.dart';
import 'package:waqtii/core/components/toast.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/cubit.dart';
import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/state.dart';

class TODOHome extends StatelessWidget {
  TODOHome({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TODOCubit, TODOStates>(
      listener: (context, state) {
        if (state is CreateTaskSuccessState) {
          Navigator.pop(context);
          titleController.text = '';
          timeController.text = '';
          dateController.text = '';

          toastt(message: 'Add Successfuly', state: ToastStates.SUCCESS);
        }
        if (state is CreateTaskErrorState) {
          toastt(message: 'Error', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        TODOCubit cubit = TODOCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetTasksLoadingState,
          builder: (context) => Scaffold(
              key: scaffoldKey,
              body: tasksBuilder(
                tasks: TODOCubit.get(context).tasksList,
              ),
              floatingActionButton: cubit.isBottomSheetShown == false
                  ? FloatingActionButton(
                      child: Icon(Icons.edit),
                      onPressed: () {
                        scaffoldKey.currentState!
                            .showBottomSheet(
                                backgroundColor: Colors.transparent,
                                (context) => Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 30,
                                            bottom: 10,
                                            right: 20,
                                            left: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: titleController,
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Title Must not be Empty';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  label: Text('Task Title'),
                                                  prefixIcon: Icon(Icons.title),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              defaultDropDown(
                                                context: context,
                                                hint: 'Priority',
                                                items: ['low', 'mid', 'high'],
                                                onChanged: (value) {
                                                  cubit.changePriority(value);
                                                },
                                                validationText:
                                                    'please select Priority',
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                      style: const ButtonStyle(
                                                          elevation:
                                                              MaterialStatePropertyAll(
                                                                  0),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Colors
                                                                      .transparent)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel')),
                                                  InkWell(
                                                      onTap: () {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          cubit.createTask(
                                                              title:
                                                                  titleController
                                                                      .text,
                                                              priority: cubit
                                                                  .selectedPriority);
                                                        }
                                                      },
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 12),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: ColorManager
                                                                  .secendLightColor),
                                                          child: const Text(
                                                            'Add',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                            .closed
                            .then((value) {
                          cubit.changeBottomSheetState(
                              isShow: false, icon: Icons.edit);
                        });
                        cubit.changeBottomSheetState(
                            isShow: true, icon: Icons.add);
                      })
                  : null),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
