// // ignore_for_file: must_be_immutable

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes_database_with_cubit/cubit/noteState.dart';
// import 'package:notes_database_with_cubit/cubit/notescubit.dart';
// import 'package:notes_database_with_cubit/database/colors.dart';
// import 'package:notes_database_with_cubit/screens/extra/addNotes.dart';

// class HomeNotes extends StatefulWidget {
//   const HomeNotes({super.key});

//   @override
//   State<HomeNotes> createState() => _HomeNotesState();
// }

// class _HomeNotesState extends State<HomeNotes> {
//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     context.read<notescubit>().facthdatas();
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.read<notescubit>().isupdate = false;
//           openBottomSheet(context);
//         },
//         child: Icon(Icons.add),
//       ),
//       backgroundColor: uiColors.shade100,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(0),
//           child: Column(children: [
//             BlocBuilder<notescubit, NotesState>(builder: (context, state) {
//               return ListView.builder(
//                   itemCount: state.data.length,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: uiColors.white, width: 2),
//                           borderRadius: BorderRadius.circular(12),
//                           color: uiColors.shade200),
//                       child: ListTile(
//                         title: Text("${state.data[index].modelTitle}"),
//                         leading: Text(
//                           '${index + 1}',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         trailing: popupbuttons(mindex: index),
//                       ),
//                     );
//                   });
//             })
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class popupbuttons extends StatelessWidget {
//   popupbuttons({super.key, required this.mindex});
//   var mindex;
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//         color: uiColors.shade100,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         itemBuilder: (context) {
//           return [
//             PopupMenuItem(
//                 onTap: () {
//                   // context.read<notescubit>().delete(mindex);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(CupertinoIcons.delete),
//                     Text('Delete'),
//                   ],
//                 )),
//             PopupMenuItem(
//                 onTap: () {
//                   context.read<notescubit>().isupdate = true;
//                   context.read<notescubit>().updatedata(mindex);
//                   openBottomSheet(context, index: mindex);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(Icons.edit_document),
//                     Text("Update"),
//                   ],
//                 ))
//           ];
//         });
//   }
// }
