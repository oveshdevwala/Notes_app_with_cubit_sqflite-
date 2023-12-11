// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/noteState.dart';
import 'package:notes_database_with_cubit/cubit/notescubit.dart';
import 'package:notes_database_with_cubit/database/colors.dart';
import 'package:notes_database_with_cubit/screens/AddNote.dart';

class NotesView extends StatelessWidget {
  NotesView(
      {super.key,
      required this.mindex,
      required this.oldDisc,
      required this.oldtitle});
  int mindex;
  String oldtitle;
  String oldDisc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiColors.shade100,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<NoteCubit, NotesStates>(builder: (_, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return Center(
                child: Text(
              '${state.errorMsg}',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ));
          }
          if (state is LoadedState) {
            return notesView(context, state);
          }
          return Container();
        }),
      ),
    );
  }

  Column notesView(BuildContext context, LoadedState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 45,
                  width: 45,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: uiColors.black.withOpacity(0.3),
                                  blurRadius: 0.2,
                                  spreadRadius: 0.6)
                            ],
                            borderRadius: BorderRadius.circular(12),
                            color: uiColors.shade200),
                        child: Icon(CupertinoIcons.back)),
                  )),
              SizedBox(
                  height: 45,
                  width: 45,
                  child: popupbuttons(
                    oldDisc: oldDisc,
                    oldTitle: oldtitle,
                    states: state,
                    context: context,
                    mindex: mindex,
                  )),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          "${state.notesData[mindex].modelTitle}",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        SizedBox(height: 15),
        Text(
          "${state.notesData[mindex].modelDiscription}",
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 16,
            color: uiColors.black38,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

// popup button for Update and Delete Functions
class popupbuttons extends StatelessWidget {
  popupbuttons(
      {super.key,
      required this.mindex,
      required this.context,
      required this.oldDisc,
      required this.oldTitle,
      required this.states});
  int mindex;
  BuildContext context;
  LoadedState states;
  String oldTitle;
  String oldDisc;
  @override
  Widget build(BuildContext contextp) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: uiColors.black.withOpacity(0.3),
            blurRadius: 0.2,
            spreadRadius: 0.6)
      ], borderRadius: BorderRadius.circular(12), color: uiColors.shade200),
      child: PopupMenuButton(
          enabled: true,
          elevation: 10,
          child: Icon(Icons.edit_document),
          color: uiColors.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          itemBuilder: (contextb) {
            return [
              PopupMenuItem(
                  onTap: () {
                    context
                        .read<NoteCubit>()
                        .deleteNotes(states.notesData[mindex].modelId);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(CupertinoIcons.delete),
                      Text('Delete'),
                    ],
                  )),
              PopupMenuItem(
                  onTap: () {
                    context.read<NoteCubit>().isUpdate = true;
                    // context.read<notescubit>().updatedata(mindex);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNotesScreen(
                                  mindex: mindex,
                                  state: states,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.edit_document),
                      Text("Update"),
                    ],
                  ))
            ];
          }),
    );
  }
}

// ignore
// AppBar notesViewAppBar(BuildContext context) {
//     return AppBar(
//       toolbarHeight: 70,
//       leadingWidth: 0,
//       leading: Text(''),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//               height: 45,
//               width: 45,
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                               color: uiColors.black.withOpacity(0.3),
//                               blurRadius: 0.2,
//                               spreadRadius: 0.6)
//                         ],
//                         borderRadius: BorderRadius.circular(12),
//                         color: uiColors.shade200),
//                     child: Icon(CupertinoIcons.back)),
//               )),
//           SizedBox(
//               height: 45,
//               width: 45,
//               child: popupbuttons(oldDisc: oldDisc,oldTitle: oldtitle,states: ,
//                 context: context,
//                 mindex: mindex,
//               )),
//         ],
//       ),
//       backgroundColor: uiColors.shade100,
//     );
//   }
