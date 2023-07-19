import 'package:flutter/material.dart';

class previewkreatif extends StatefulWidget {
  const previewkreatif({Key? key});

  @override
  State<previewkreatif> createState() => _previewkreatifState();
}

class _previewkreatifState extends State<previewkreatif> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("PREVIEW KREATIF"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      
     
    );
  }
}
