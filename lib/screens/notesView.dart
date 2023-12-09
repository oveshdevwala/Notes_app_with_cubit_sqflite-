// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/noteState.dart';
import 'package:notes_database_with_cubit/cubit/notescubit.dart';
import 'package:notes_database_with_cubit/database/colors.dart';
import 'package:notes_database_with_cubit/screens/AddNote.dart';

class NotesView extends StatelessWidget {
  NotesView({
    super.key,
    required this.mindex,
  });
  int mindex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiColors.shade100,
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 0,
        leading: Text(''),
        title: Row(
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
                  mindex: mindex,
                )),
          ],
        ),
        backgroundColor: uiColors.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<notescubit, NotesState>(
            builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state.data[mindex].modelTitle}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "${state.data[mindex].modelDiscription}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}

class popupbuttons extends StatelessWidget {
  popupbuttons({super.key, required this.mindex});
  int mindex;
  @override
  Widget build(BuildContext context) {
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
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  onTap: () {
                    context.read<notescubit>().delete(mindex);
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
                    context.read<notescubit>().isupdate = true;
                    context.read<notescubit>().updatedata(mindex);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNotesScreen(
                                  mindex: mindex,
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
