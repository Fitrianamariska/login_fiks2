import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreatePengalaman extends StatefulWidget {
  const CreatePengalaman({Key? key}) : super(key: key);

  @override
  _CreatePengalamanState createState() => _CreatePengalamanState();
}

class _CreatePengalamanState extends State<CreatePengalaman> {
  List<String> pengalamanList = [];
  List<String> selectedPengalaman = []; // Added to track selected experiences

  @override
  void initState() {
    super.initState();
    fetchPengalamanData();
  }

  Future<void> fetchPengalamanData() async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('tambahPengalaman');
    QuerySnapshot snapshot = await ref.get();
    List<String> pengalamanNames = [];
    snapshot.docs.forEach((doc) {
      pengalamanNames.add(doc['nama_pengalaman']);
    });
    setState(() {
      pengalamanList = pengalamanNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
              ),
              child: Text(
                'Pengalaman',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF090774),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pengalamanList.length,
                itemBuilder: (context, index) {
                  String pengalaman = pengalamanList[index];
                  return CheckboxListTile(
                    value: selectedPengalaman.contains(
                        pengalaman), // Use the selectedPengalaman list to determine the checkbox value
                    onChanged: (newValue) {
                      setState(() {
                        if (newValue!) {
                          selectedPengalaman.add(
                              pengalaman); // Add the experience to selectedPengalaman list if it is checked
                        } else {
                          selectedPengalaman.remove(
                              pengalaman); // Remove the experience from selectedPengalaman list if it is unchecked
                        }
                      });
                    },
                    title: Text(pengalaman),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, bottom: 100),
              child: ElevatedButton(
                onPressed: () {
                  // Save the selected experiences to Firebase Firestore
                  CollectionReference ref =
                      FirebaseFirestore.instance.collection('createCV');
                  for (String experience in selectedPengalaman) {
                    ref.add({'pengalaman': experience});
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF090774),
                ),
                child: Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
