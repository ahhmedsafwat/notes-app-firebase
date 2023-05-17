import 'package:flutter/material.dart';

import '../cred/add_notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String homePage = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [
    {
      'note': 'Read a book for 10 minute without any rests',
      'img': 'assets/images/pexels-rikka-ameboshi-3358707.jpg'
    },
    {
      'note': 'Read a book for 10 minute without any rests',
      'img': 'assets/images/pexels-rikka-ameboshi-3358707.jpg'
    },
    {
      'note': 'Read a book for 10 minute without any rests',
      'img': 'assets/images/pexels-john-ray-ebora-4581325.jpg'
    },
    {
      'note': 'Read a book for 10 minute without any rests',
      'img': 'assets/images/pexels-john-ray-ebora-4581325.jpg'
    },
  ];
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
      body: Container(
          child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key('$index'),
            child: ListNotes(
              notes: notes[index],
            ),
          );
        },
      )),
    );
  }
}

class ListNotes extends StatelessWidget {
  ListNotes({required this.notes});
  final Map notes;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Image.asset(
            notes['img'],
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
