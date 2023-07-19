import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../HalamanCreate/createCV.dart';

TextEditingController contJudulcv = TextEditingController();

class createJudul extends StatefulWidget {
  const createJudul({Key? key});

  @override
  State<createJudul> createState() => _createJudulState();
}

class _createJudulState extends State<createJudul> {
  TextEditingController judulCV = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('createCV');

  @override
  void dispose() {
    judulCV.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Create",
          style: TextStyle(color: Color(0xFF090774)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF090774),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 247, 50, 0),
            ),
            SizedBox(
              width: 277,
              height: 38,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Judul CV",
                  labelStyle: TextStyle(color: Color(0xFF090774)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF090774)),
                  ),
                ),
                controller: contJudulcv,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF090774),
                  minimumSize: Size(140, 38),
                ),
                onPressed: () {
                  ref.add({
                    'judulCV': judulCV.text,
                  }).then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CreateCV()),
                    );
                  })
                      // ignore: avoid_print, invalid_return_type_for_catch_error
                      .catchError(
                          // ignore: avoid_print, invalid_return_type_for_catch_error
                          (error) => print("Failed to add judulCV: $error"));
                },
                child: Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
