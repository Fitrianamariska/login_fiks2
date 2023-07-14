import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'pengalaman.dart';

class tambahPengalaman extends StatefulWidget {
  const tambahPengalaman({Key? key}) : super(key: key);

  @override
  _tambahPengalamanState createState() => _tambahPengalamanState();
}

class _tambahPengalamanState extends State<tambahPengalaman> {
  TextEditingController nama_pengalaman = TextEditingController();
  TextEditingController tanggal_mulai = TextEditingController();
  TextEditingController tanggal_akhir = TextEditingController();
  TextEditingController jabatan = TextEditingController();

  CollectionReference ref =
      FirebaseFirestore.instance.collection('tambahPengalaman');

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
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Tambah Pengalaman'),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
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
                controller: nama_pengalaman,
                decoration: InputDecoration(
                  labelText: 'Nama Pengalaman',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: tanggal_mulai,
                decoration: InputDecoration(
                  labelText: 'Tanggal Mulai',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: tanggal_akhir,
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
                onPressed: () {
                  ref.add({
                    'nama_pengalaman': nama_pengalaman.text,
                    'tanggal_mulai': tanggal_mulai.text,
                    'tanggal_akhir': tanggal_akhir.text,
                    'jabatan': jabatan.text
                  }).whenComplete(() {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => halPengalaman()));
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900], // Warna latar belakang
                  onPrimary: Colors.white, // Warna teks
                ),
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
