import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/screens/home-page.dart';
import 'package:notes/widget/themes.dart';
class ReadNotes extends StatefulWidget {
  ReadNotes(this.doc,{super.key});
  QueryDocumentSnapshot doc;
  @override
  State<ReadNotes> createState() => _ReadNotesState();
}

class _ReadNotesState extends State<ReadNotes> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: Themes.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: Themes.cardColor[color_id],
        elevation: 0.0,
        actions: [
          IconButton(onPressed: () async {
            await FirebaseFirestore.instance.collection("notes").doc(widget.doc.id).delete();
            Navigator.pop(context);
            }, icon: const Icon(Icons.delete,color: Colors.black,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc['notes_title'],style: Themes.mainTitle,),
            const SizedBox(height: 8.0,),
            Text(widget.doc['creation_date'],style: Themes.dateTitle,),
            const SizedBox(height: 28.0,),
            Text(widget.doc['notes_content'],style: Themes.mainContent),
          ],
        ),
      ),
    );
  }
}
