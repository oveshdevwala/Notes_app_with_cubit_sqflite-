// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/noteState.dart';
import 'package:notes_database_with_cubit/cubit/notescubit.dart';
import 'package:notes_database_with_cubit/database/colors.dart';
import 'package:notes_database_with_cubit/screens/AddNote.dart';
import 'package:notes_database_with_cubit/screens/notesView.dart';

class HomeNotesGrid extends StatelessWidget {
  HomeNotesGrid({super.key});
  @override
  Widget build(BuildContext context) {
    print('build function called!!');
    context.read<NoteCubit>().getAllNotes();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NoteCubit>().isUpdate = false;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNotesScreen()));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: uiColors.shade100,
      appBar: AppBar(
        backgroundColor: uiColors.shade100,
        title: Text('Notes App'),
      ),
      body: BlocBuilder<NoteCubit, NotesStates>(builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState) {
          return Center(child: Text('${state.errorMsg}'));
        }
        if (state is LoadedState) {
          return state.notesData.isNotEmpty
              ? HomeGridNotes(context, state)
              : Center(
                  child: Text('Data Not Found'),
                );
        }
        return Container();
      }),
    );
  }
}

HomeGridNotes(BuildContext context, LoadedState state) {
  return SingleChildScrollView(
    child: GridView.builder(
        itemCount: state.notesData.length,
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NotesView(
                  mindex: index,
                  oldtitle: state.notesData[index].modelTitle,
                  oldDisc: state.notesData[index].modelDiscription,
                );
              }));
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                  color: uiColors.shade200,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        '${state.notesData[index].modelTitle}',
                        maxLines: 4,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '30/20/29',
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
            ),
          );
        }),
  );
}
