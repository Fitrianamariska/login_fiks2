import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class TentangSayaPage extends StatefulWidget {
  const TentangSayaPage({Key? key}) : super(key: key);

  @override
  State<TentangSayaPage> createState() => _TentangSayaPageState();
}

class _TentangSayaPageState extends State<TentangSayaPage> {
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController ttl = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nohp = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController agamaController = TextEditingController();
  TextEditingController kewarganegaraanController = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController tambahan = TextEditingController();

  CollectionReference ref =
      FirebaseFirestore.instance.collection('TentangSaya');
  late String _selectedImagePath;

  @override
  void initState() {
    super.initState();
    namaLengkap = TextEditingController();
    ttl = TextEditingController();
    emailController = TextEditingController();
    nohp = TextEditingController();
    alamatController = TextEditingController();
    agamaController = TextEditingController();
    kewarganegaraanController = TextEditingController();
    status = TextEditingController();
    tambahan = TextEditingController();
    _selectedImagePath = '';
  }

  Future<void> _uploadFoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _selectedImagePath = result.files.single.path!;
      });
    }
  }

  void _simpanData() {
    String nama = namaLengkap.text;
    String tempatTanggalLahir = ttl.text;
    String email = emailController.text;
    String noHp = nohp.text;
    String alamat = alamatController.text;
    String agama = agamaController.text;
    String kewarganegaraan = kewarganegaraanController.text;
    String statusNikah = status.text;
    String informasiTambahan = tambahan.text;

    Map<String, dynamic> data = {
      'nama_lengkap': nama,
      'ttl': tempatTanggalLahir,
      'email': email,
      'nohp': noHp,
      'alamat': alamat,
      'agama': agama,
      'kewarganegaraan': kewarganegaraan,
      'status': statusNikah,
      'tambahan': informasiTambahan,
      'foto':
          _selectedImagePath, // Tambahkan field foto dengan nilai _selectedImagePath
    };

    ref.add(data).then((value) {
      print('Data berhasil disimpan ke Firebase');
      // Lakukan tindakan lain setelah data berhasil disimpan
    }).catchError((error) {
      print('Terjadi kesalahan: $error');
      // Lakukan penanganan kesalahan yang sesuai
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: [
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(28, 17, 0, 0),
            alignment: AlignmentDirectional.topStart,
            child: Text(
              "Tentang Saya",
              style: TextStyle(
                color: Color(0xFF090774),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: _selectedImagePath.isNotEmpty
                      ? Image.file(
                          File(_selectedImagePath),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : IconButton(
                          onPressed: _uploadFoto,
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: namaLengkap,
                  decoration: const InputDecoration(
                    labelText: "Nama Lengkap",
                    labelStyle: TextStyle(color: Color(0xFF828282)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: ttl,
              decoration: const InputDecoration(
                labelText: "Tempat Tanggal Lahir",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: nohp,
              decoration: const InputDecoration(
                labelText: "No Hp",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: alamatController,
              decoration: const InputDecoration(
                labelText: "Alamat",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: agamaController,
              decoration: const InputDecoration(
                labelText: "Agama",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: kewarganegaraanController,
              decoration: const InputDecoration(
                labelText: "Kewarganegaraan",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: status,
              decoration: const InputDecoration(
                labelText: "Status Nikah",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: tambahan,
              decoration: const InputDecoration(
                labelText: "Informasi Tambahan(Opsional)",
                labelStyle: TextStyle(color: Color(0xFF828282)),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              onPressed: _simpanData,
              child: Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}
