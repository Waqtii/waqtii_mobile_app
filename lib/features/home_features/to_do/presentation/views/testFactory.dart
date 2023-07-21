// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:waqtii/features/home_features/to_do/domain/models/tasks_model.dart';
// import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/cubit.dart';
// import 'package:waqtii/features/home_features/to_do/presentation/to_do_cubit/state.dart';

// // ignore: must_be_immutable
// class TestFactory extends StatelessWidget {
//   TestFactory({
//     required this.id,
//     required this.audioFile,
//     required this.createdAt,
//     required this.date,
//     required this.description,
//     required this.notes,
//     required this.priority,
//     required this.status,
//     required this.title,
//     this.user,
//   });

//   factory TestFactory.fromjson(
//     TasksModel curentModel,
//   ) {
//     return TestFactory(
//       id: curentModel.id,
//       audioFile: curentModel.audioFile,
//       createdAt: curentModel.createdAt,
//       date: curentModel.date,
//       description: curentModel.description,
//       notes: curentModel.notes,
//       priority: curentModel.priority,
//       status: curentModel.status,
//       title: curentModel.title,
//     );
//   }
//   int? id;
//   String? title;
//   String? status;
//   String? priority;
//   String? description;
//   String? notes;
//   String? audioFile;
//   String? date;
//   String? createdAt;
//   int? user;
//   @override
//   Widget build(BuildContext context) {
//     var descriptionController = TextEditingController(text: description);
//     var noteController = TextEditingController(text: notes);

//     return BlocConsumer<TODOCubit, TODOStates>(
//       listener: (context, state) {
//         if (state is GetTaskByIdSuccessState) {}
//         if (state is DeleteTaskSuccessState) {
//           Navigator.pop(context);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Color(0xFFFAFAFA),
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             // title: Row(
//             //   children: [
//             //     Expanded(
//             //       child: FittedBox(
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.center,
//             //           children: [
//             //             const FittedBox(
//             //               child: Text(
//             //                 "Created at ",
//             //                 style: TextStyle(
//             //                   fontWeight: FontWeight.bold,
//             //                 ),
//             //               ),
//             //             ),
//             //             FittedBox(
//             //                 child: FittedBox(child: Text(convertDateString()))),
//             //           ],
//             //         ),
//             //       ),
//             //     ),
//             //     FittedBox(
//             //       child: IconButton(
//             //         alignment: AlignmentDirectional.center,
//             //         onPressed: () {
//             //           TODOCubit.get(context).deleteTask(
//             //             id: tasksModel.id!,
//             //           );
//             //         },
//             //         icon: const Icon(
//             //           Icons.delete_outline,
//             //           color: Colors.red,
//             //           size: 30,
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           ),
//           body: ConditionalBuilder(
//             condition: state is! GetTaskByIdLoadingState,
//             builder: (context) {
//               return Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   if (status == 'IN_PROGRESS') {
//                                     TODOCubit.get(context)
//                                         .updateTask(id: id!, status: 'DONE');
//                                   }
//                                   if (status == 'TODO') {
//                                     TODOCubit.get(context)
//                                         .updateTask(id: id!, status: 'DONE');
//                                   }
//                                   if (status == 'DONE') {
//                                     TODOCubit.get(context)
//                                         .updateTask(id: id!, status: 'TODO');
//                                   }
//                                 },
//                                 icon: Icon(
//                                   status == 'DONE'
//                                       ? Icons.check_circle_outline
//                                       : Icons.circle_outlined,
//                                   color: status == 'DONE'
//                                       ? Colors.green
//                                       : status == 'IN_PROGRESS'
//                                           ? Colors.blue
//                                           : Colors.grey,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   '$title',
//                                   style: TextStyle(
//                                     decoration: status == 'DONE'
//                                         ? TextDecoration.lineThrough
//                                         : null,
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: status == 'DONE'
//                                         ? Colors.grey[600]
//                                         : null,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: status == 'TODO'
//                                           ? Colors.grey
//                                           : status == 'IN_PROGRESS'
//                                               ? Colors.blue
//                                               : Colors.green.shade400,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                     ),
//                                   ],
//                                   color: status == 'TODO'
//                                       ? Colors.grey.shade100
//                                       : status == 'IN_PROGRESS'
//                                           ? Colors.blue.shade100
//                                           : Colors.green.shade100,
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.25,
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton<String>(
//                                       value: status,
//                                       onChanged: (newValue) {
//                                         TODOCubit.get(context).changeStatusById(
//                                             newValue, id, context);
//                                       },
//                                       items: ["TODO", "IN_PROGRESS", "DONE"]
//                                           .map(
//                                             (e) => DropdownMenuItem(
//                                               value: e,
//                                               child: Center(
//                                                 child: FittedBox(
//                                                   child: Text(
//                                                     e,
//                                                     style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                           .toList(),
//                                       icon: const SizedBox.shrink(),
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       isExpanded: true,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Container(
//                         height: 70,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.priority_high_rounded,
//                                 color: Colors.grey,
//                               ),
//                               const Expanded(
//                                 child: Text(
//                                   "Priority",
//                                   style: TextStyle(
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                   boxShadow: const [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                     ),
//                                   ],
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.25,
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton<String>(
//                                       value: priority,
//                                       onChanged: (newValue) {
//                                         TODOCubit.get(context).changeStatusById(
//                                             newValue, id, context);
//                                       },
//                                       items: ["low", "mid", "high"]
//                                           .map(
//                                             (e) => DropdownMenuItem(
//                                               value: e,
//                                               child: Center(
//                                                 child: FittedBox(
//                                                   child: Text(
//                                                     e,
//                                                     style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                           .toList(),
//                                       icon: const SizedBox.shrink(),
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                       ),
//                                       isExpanded: true,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         "Description:",
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextFormField(
//                         onChanged: (value) {
//                           TODOCubit.get(context).updateTask(
//                               id: id!, description: descriptionController.text);
//                         },
//                         controller: descriptionController,
//                         decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: "Add description",
//                           border: OutlineInputBorder(),
//                         ),
//                         maxLength: 120,
//                         maxLines: 5,
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         "Note:",
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       TextFormField(
//                         onChanged: (value) {
//                           TODOCubit.get(context)
//                               .updateTask(id: id!, notes: noteController.text);
//                         },
//                         controller: noteController,
//                         decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: "Add note",
//                           border: OutlineInputBorder(),
//                         ),
//                         maxLength: 25,
//                         maxLines: 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//             fallback: (context) => LinearProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }
