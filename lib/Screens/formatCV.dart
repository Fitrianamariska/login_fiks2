import 'package:flutter/material.dart';
import 'package:login_fiks2/preview/previewKreatif.dart';

class formatcvPage extends StatefulWidget {
  const formatcvPage({super.key});

  @override
  State<formatcvPage> createState() => _formatcvPageState();
}

class _formatcvPageState extends State<formatcvPage> {
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
              Navigator.of(context).pop();
            });
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 75, 0, 0),
              child: Text(
                "Format CV",
                style: TextStyle(
                    color: Color(0xFF090774),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF090774),
                    minimumSize: Size(140, 38)),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => previewkreatif(),
                  //     ));
                },
                child: const Text("ATS Friendly"),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF090774),
                    minimumSize: Size(140, 38)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => previewkreatif(),
                      ));
                },
                child: const Text("CV Kreatif"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
