import 'package:flutter/material.dart';

class previewATS extends StatefulWidget {
  const previewATS({Key? key});

  @override
  State<previewATS> createState() => _previewATSState();
}

class _previewATSState extends State<previewATS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              title: Text('PREVIEW ATS'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('PREVIEW ATS'),
      ),
    );
  }
}
