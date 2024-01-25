import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/widget/themes.dart';

Widget notesDisplayWidget(Function()? onTap,QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Themes.cardColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc['notes_title'],style: Themes.mainTitle,),
          const SizedBox(height: 4.0,),
          Text(doc['creation_date'],style: Themes.dateTitle,),
          const SizedBox(height: 8.0,),
          Text(doc['notes_content'],style: Themes.mainContent,overflow: TextOverflow.ellipsis,),
        ],
      ),
    ),
  );
}