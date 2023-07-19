import 'package:flutter/material.dart';

class previewkreatif extends StatefulWidget {
  const previewkreatif({Key? key});

  @override
  State<previewkreatif> createState() => _previewkreatifState();
}

class _previewkreatifState extends State<previewkreatif> {
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
              title: Text('PREVIW KREATIF'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('PREVIEW KREATIF'),
      ),
    );
  }
}
