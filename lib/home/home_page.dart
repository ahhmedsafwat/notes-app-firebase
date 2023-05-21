import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/components/alert.dart';
import '../cred/add_notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String homePage = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference noteRef = FirebaseFirestore.instance.collection('notes');
  getUser() async {
    var user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return ListNotes(
                    notes: data,
                  );
                },
                itemCount: snapshot.data?.docs.length,
              );
            }
            return showLoading(context);
          },
        ));
  }
}

class ListNotes extends StatelessWidget {
  const ListNotes({required this.notes});
  final Map notes;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
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
          title: const Text(
            'Title',
          ),
          subtitle: Text('${notes['note']}'),
          trailing: const Icon(Icons.edit),
        ),
      ),
    ]);
  }
}
