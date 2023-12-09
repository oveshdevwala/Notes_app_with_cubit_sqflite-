// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/notescubit.dart';
import 'package:notes_database_with_cubit/database/colors.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen({super.key,  this.mindex = 0});
  var mindex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: uiColors.shade100,
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Text(''),
        leadingWidth: 0,
        backgroundColor: uiColors.shade100,
        title: Container(
          // margin: EdgeInsets.only(top: 10),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 45,
                height: 45,
                child: FloatingActionButton(
                  heroTag: 'addnoteback',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: uiColors.shade200,
                  child: Icon(CupertinoIcons.back),
                ),
              ),
              SizedBox(
                width: 65,
                height: 45,
                child: FloatingActionButton(
                  heroTag: 'save',
                  onPressed: () {
                    context.read<notescubit>().creates(mindex);
                    Navigator.pop(context);
                  },
                  backgroundColor: uiColors.shade200,
                  child: Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: context.read<notescubit>().titleController,
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Text(
            //     'Created Date :- 30/2/2003',
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold, color: uiColors.black38),
            //   ),
            // ),
            TextField(
              controller: context.read<notescubit>().discController,
              minLines: 10,
              maxLines: 100,
              style: TextStyle(
                  color: uiColors.black38, fontWeight: FontWeight.w500),
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
