import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});
  static String addNotes = 'AddNotes';

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                  child: Column(
                children: [
                  TextFormField(
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
                    child: Text('Add Image for your Note'),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10)),
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
            padding: EdgeInsets.all(20),
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'please choose an Image',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.leftSlide,
                            title: 'give me a photo',
                            desc:
                                'open your camera and take a photo of this beatuiful face',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                            btnCancelColor: Colors.teal)
                        .show();
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
                  onTap: () {},
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
