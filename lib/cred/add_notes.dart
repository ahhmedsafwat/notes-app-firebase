import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:notes/components/alert.dart';
import 'package:notes/home/home_page.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});
  static String addNotes = 'AddNotes';

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  var title, note, imageUrl;

  File? file;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Reference? ref;

  CollectionReference noteRef = FirebaseFirestore.instance.collection('notes');

  addNotes() async {
    if (file == null) {
      return AwesomeDialog(
              context: context,
              title: 'insert phote',
              desc: 'please insert phote ')
          .show();
    }
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      showLoading(context);
      await ref!.putFile(file!);
      imageUrl = await ref!.getDownloadURL();

      await noteRef.add({
        'title': title,
        'note': note,
        'imageUrl': imageUrl,
        'userId': FirebaseAuth.instance.currentUser!.uid
      });

      Navigator.pushReplacementNamed(context, HomePage.homePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                  key: formState,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (newValue) {
                          title = newValue;
                        },
                        maxLength: 30,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('Note Title'),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.length > 255) {
                            return 'the note can\'t be bigger then 255 letter';
                          }
                          if (value.isEmpty) {
                            return 'this field is required';
                          }
                        },
                        onSaved: (newValue) {
                          note = newValue;
                        },
                        minLines: 1,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          label: Text('Note'),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showBottomSheet();
                        },
                        child: const Text('Add Image for your Note'),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await addNotes();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                          ),
                          child: Text(
                            'Add Note',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white),
                          ))
                    ],
                  ))
            ]),
      ),
    );
  }

  showBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'please choose an Image',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    XFile? image =
                        await picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      file = File(image.path);
                      int rand = Random().nextInt(1000000);
                      String imageName =
                          rand.toString() + path.basename(image.path);

                      ref = FirebaseStorage.instance
                          .ref('images')
                          .child('$imageName');
                    }

                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'From Camera',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();

                    XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      file = File(image.path);
                      int rand = Random().nextInt(1000000);
                      String imageName =
                          rand.toString() + path.basename(image.path);
                      ref = FirebaseStorage.instance
                          .ref('images')
                          .child(imageName);
                    }

                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'From Gallery',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
