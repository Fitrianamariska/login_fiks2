import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../report.dart';
import 'pengalaman.dart';

class editPengalaman extends StatefulWidget {
  final DocumentSnapshot docid;
  editPengalaman({required this.docid});

  @override
  _editPengalamanState createState() => _editPengalamanState();
}

class _editPengalamanState extends State<editPengalaman> {
  late TextEditingController namaPengalaman;
  late TextEditingController tanggalMulai;
  late TextEditingController tanggalAkhir;
  late TextEditingController jabatan;

  @override
  void initState() {
    super.initState();

    namaPengalaman =
        TextEditingController(text: widget.docid.get('nama_pengalaman'));
    tanggalMulai =
        TextEditingController(text: widget.docid.get('tanggal_mulai'));
    tanggalAkhir =
        TextEditingController(text: widget.docid.get('tanggal_akhir'));
    jabatan = TextEditingController(text: widget.docid.get('jabatan'));
  }

  @override
  void dispose() {
    namaPengalaman.dispose();
    tanggalMulai.dispose();
    tanggalAkhir.dispose();
    jabatan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => halPengalaman()),
              );
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.docid.reference.update({
                'nama_pengalaman': namaPengalaman.text,
                'tanggal_mulai': tanggalMulai.text,
                'tanggal_akhir': tanggalAkhir.text,
                'jabatan': jabatan.text,
              }).then((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => halPengalaman()),
                );
              });
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.docid.reference.delete().then((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => halPengalaman()),
                );
              });
            },
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: namaPengalaman,
                decoration: InputDecoration(
                  labelText: 'Nama Pengalaman',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: tanggalMulai,
                decoration: InputDecoration(
                  labelText: 'Tanggal Mulai',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: tanggalAkhir,
                decoration: InputDecoration(
                  labelText: 'Tanggal Akhir',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: jabatan,
                decoration: InputDecoration(
                  labelText: 'Jabatan',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 11, 133),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Report(docid: widget.docid),
                    ),
                  );
                },
                child: Text(
                  "Make Report",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
