import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/widget/themes.dart';

class NotesInsertScreen extends StatefulWidget {
  const NotesInsertScreen({super.key});

  @override
  State<NotesInsertScreen> createState() => _NotesInsertScreenState();
}

class _NotesInsertScreenState extends State<NotesInsertScreen> {
  int color_id = Random().nextInt(Themes.cardColor.length);
  TextEditingController notesTitle = TextEditingController();
  TextEditingController notesContent = TextEditingController();
  String date1 = DateTime.now().toString().substring(0,11);
  String date2 = DateTime.now().toString().substring(11,19);
  @override
  Widget build(BuildContext context) {
    String date = date1+date2;
    return Scaffold(
      backgroundColor: Themes.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: Themes.cardColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Add a new note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: notesTitle,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Title",
                ),
                style: Themes.mainTitle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                date1,
                style: Themes.dateTitle,
              ),
              const SizedBox(
                height: 3.0,
              ),
              Text(
                date2,
                style: Themes.dateTitle,
              ),
              const SizedBox(
                height: 28.0,
              ),
              TextField(
                controller: notesContent,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Content",
                ),
                style: Themes.mainTitle,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email!.toString()).collection("notes").add({
            "notes_title": notesTitle.text,
            "creation_date": date,
            "notes_content": notesContent.text,
            "color_id": color_id,
          }).then((value) {
            Navigator.pop(context);
          }).catchError((error) => print("failed to insert data"));
        },
        backgroundColor: Themes.accentColor,
        child: const Icon(Icons.save),
      ),
    );
  }
}
