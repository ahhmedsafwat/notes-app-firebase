import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({
    super.key,
    required this.notes,
  });

  final notes;
  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes Details')),
      body: Container(
          child: Column(
        children: [
          Container(
            color: Colors.white70,
            child: Image.network(
              '${widget.notes['imageUrl']}',
              width: double.infinity,
              height: 300,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                widget.notes['title'],
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              widget.notes['note'],
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    );
  }
}
