import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:notes/auth/login.dart';
import 'package:notes/cred/edit_note.dart';
import 'package:notes/cred/view_details.dart';
import '../cred/add_notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String homePage = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference noteRef = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, Login.login);
                },
                icon: Icon(Icons.exit_to_app))
          ],
          title: const Text("Home Page"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddNotes.addNotes);
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: noteRef
              .where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'There is no Notes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return Dismissible(
                  key: Key('$index'),
                  onDismissed: (direction) async {
                    await noteRef.doc(snapshot.data!.docs[index].id).delete();
                    FirebaseStorage.instance
                        .refFromURL(snapshot.data!.docs[index]['imageUrl'])
                        .delete()
                        .then((value) => print('delete'));
                  },
                  child: ListNotes(
                    notes: data,
                    docId: snapshot.data!.docs[index].id,
                  ),
                );
              },
              itemCount: snapshot.data?.docs.length,
            );
          },
        ));
  }
}

class ListNotes extends StatelessWidget {
  const ListNotes({required this.notes, required this.docId});
  final Map notes;
  final docId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ViewDetails(notes: notes);
          },
        ));
      },
      child: Card(
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Image.network(
                notes['imageUrl'],
                fit: BoxFit.contain,
                height: 100,
              )),
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text(
                notes['title'],
                style: const TextStyle(
                  fontSize: 20,
                ),
                maxLines: 1,
              ),
              subtitle: Text(
                '${notes['note']}',
                style: const TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditNotes(
                        docId: docId,
                        list: notes,
                      );
                    },
                  ));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
