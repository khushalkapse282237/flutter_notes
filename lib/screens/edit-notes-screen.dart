import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/widget/themes.dart';

class EditNotes extends StatefulWidget {
  EditNotes(this.doc, {super.key});
  QueryDocumentSnapshot doc;

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController etitle = TextEditingController();
  TextEditingController econtent = TextEditingController();
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: etitle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.doc['notes_title'],
                  hintStyle: Themes.mainTitle,
                ),
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
              TextField(
                controller: econtent,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.doc['notes_content'],
                  hintStyle: Themes.mainContent,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.email!.toString())
              .collection("notes")
              .doc(widget.doc.id.toString())
              .update({
            "notes_title": etitle.text,
            'notes_content': econtent.text,
          }).then((value) {
            Navigator.pop(context);
          }).catchError((e) => print(e));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
