import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/widget/notes_display_widget.dart';
import 'package:notes/widget/themes.dart';
import 'read-notes.dart';
import 'notes-editor-screens.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Notes"),
        centerTitle: true,
        backgroundColor: Themes.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Notes",
              style: GoogleFonts.roboto(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection("notes").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((note) => notesDisplayWidget(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReadNotes(note),
                                      ));
                                }, note))
                            .toList(),
                      );
                    }
                    return Text(
                      "There is no Notes",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesEditorScreen()));
        },
        backgroundColor: Themes.accentColor,
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
