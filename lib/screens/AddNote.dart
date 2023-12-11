// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/noteState.dart';
import 'package:notes_database_with_cubit/cubit/notescubit.dart';
import 'package:notes_database_with_cubit/database/colors.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen({super.key, this.mindex = 0, this.state});
  var mindex;
  LoadedState? state;

  @override
  Widget build(BuildContext context) {
    var path = context.read<NoteCubit>();
    if (path.isUpdate == true) {
      path.titleController.text = state!.notesData[mindex].modelTitle;
      path.discController.text = state!.notesData[mindex].modelDiscription;
    }

    return Scaffold(
      backgroundColor: uiColors.shade100,
      // appBar: AppBar(
      //   toolbarHeight: 70,
      //   leading: Text(''),
      //   leadingWidth: 0,
      //   backgroundColor: uiColors.shade100,
      //   title:
      // ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(10),
              child: BlocBuilder<NoteCubit, NotesStates>(
                  builder: (context, state) {
                if (state is LoadedState) {
                  return Row(
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
                        ),
                      ),
                      Container(
                        width: 65,
                        height: 45,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: uiColors.black.withOpacity(0.3),
                                  blurRadius: 0.2,
                                  spreadRadius: 0.6)
                            ],
                            borderRadius: BorderRadius.circular(12),
                            color: uiColors.shade200),
                        child: TextButton(
                          child: Text(
                            "Save",
                            style:
                                TextStyle(fontSize: 16, color: uiColors.black),
                          ),
                          onPressed: () {
                            if (path.isUpdate) {
                              path.updateNotes(state.notesData[mindex].modelId);
                            } else {
                              context.read<NoteCubit>().addNotes();
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              }),
            ),
            TextField(
              controller: context.read<NoteCubit>().titleController,
              minLines: 1,
              maxLines: 4,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  hintText: 'Type Note Title',
                  enabledBorder: bordersidenone(),
                  disabledBorder: bordersidenone(),
                  focusedBorder: bordersidenone(),
                  border: bordersidenone()),
            ),
            TextField(
              controller: context.read<NoteCubit>().discController,
              minLines: 10,
              maxLines: 100,
              style:
                  TextStyle(color: uiColors.black, fontWeight: FontWeight.w500),
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                  hintText: ' Note Discription ',
                  enabledBorder: bordersidenone(),
                  disabledBorder: bordersidenone(),
                  focusedBorder: bordersidenone(),
                  border: bordersidenone()),
            )
          ],
        ),
      )),
    );
  }

  OutlineInputBorder bordersidenone() =>
      OutlineInputBorder(borderSide: BorderSide.none);
}
