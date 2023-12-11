// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes_database_with_cubit/cubit/notescubit.dart';
// import 'package:notes_database_with_cubit/database/colors.dart';

// Future<dynamic> openBottomSheet(BuildContext context, {int index = 0}) =>
//     showModalBottomSheet(
//         context: context,
//         builder: (context) => Container(
//               decoration: BoxDecoration(
//                   color: uiColors.shade100,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12))),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 15),
//                     TextField(
//                       controller: context.read<notescubit>().titleController,
//                       decoration: textFiledDecoration(),
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           context.read<notescubit>().creates(index);
//                           Navigator.pop(context);
//                         },
//                         style: ElevatedButton.styleFrom(
//                             foregroundColor: uiColors.white,
//                             backgroundColor: uiColors.shade200,
//                             shape: RoundedRectangleBorder(
//                                 side:
//                                     BorderSide(color: uiColors.white, width: 2),
//                                 borderRadius: BorderRadius.circular(12))),
//                         child: Text('Save'))
//                   ],
//                 ),
//               ),
//             ));

// InputDecoration textFiledDecoration() {
//   return InputDecoration(
//       hintText: 'Type Notes',
//       fillColor: uiColors.shade200,
//       filled: true,
//       disabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: uiColors.white, width: 2),
//           borderRadius: BorderRadius.circular(12)),
//       enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: uiColors.white, width: 2),
//           borderRadius: BorderRadius.circular(12)),
//       focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: uiColors.white, width: 2),
//           borderRadius: BorderRadius.circular(12)),
//       border: OutlineInputBorder(
//           borderSide: BorderSide(color: uiColors.white, width: 2),
//           borderRadius: BorderRadius.circular(12)));
// }
