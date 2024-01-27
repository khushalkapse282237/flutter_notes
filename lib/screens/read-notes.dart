import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'edit-notes-screen.dart';
import 'package:notes/widget/themes.dart';

class ReadNotes extends StatefulWidget {
  ReadNotes(this.doc, {super.key});
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
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Themes.cardColor[color_id],
        elevation: 2.0,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.email!.toString())
                    .collection("notes")
                    .doc(widget.doc.id)
                    .delete();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Deleted Successfully',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(
                        seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNotes(widget.doc)));
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doc['notes_title'],
                style: Themes.mainTitle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.doc['creation_date'].toString().substring(0, 11),
                style: Themes.dateTitle,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.doc['creation_date'].toString().substring(11, 19),
                style: Themes.dateTitle,
              ),
              const SizedBox(
                height: 28.0,
              ),
              Text(widget.doc['notes_content'], style: Themes.mainContent),
            ],
          ),
        ),
      ),
    );
  }
}
