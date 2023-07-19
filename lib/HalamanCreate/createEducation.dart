import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  List<Widget> educationTiles = [];

  Future<void> openDialog({int? index}) async {
    String? university;
    String? department;
    String? gpa;
    String? startDate;
    String? endDate;

    if (index != null) {
      final ListTile? tile = educationTiles[index] as ListTile?;
      if (tile != null) {
        final Text? title = tile.title as Text?;
        final Text? subtitle = tile.subtitle as Text?;
        if (title != null) {
          university = title.data.toString();
        }
        if (subtitle != null) {
          department = subtitle.data.toString();
        }
      }
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 293,
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: TextField(
                  onChanged: (value) {
                    university = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF828282)),
                    ),
                    isDense: true,
                    labelText: "Universitas/Institut/Sekolah",
                    labelStyle: TextStyle(color: Color(0xFF828282)),
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: university),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 35,
                child: TextField(
                  onChanged: (value) {
                    department = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF828282)),
                    ),
                    isDense: true,
                    labelText: "Jurusan/Fakultas",
                    labelStyle: TextStyle(color: Color(0xFF828282)),
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: department),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 35,
                child: TextField(
                  onChanged: (value) {
                    gpa = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF828282)),
                    ),
                    isDense: true,
                    labelText: "IPK/Nilai",
                    labelStyle: TextStyle(color: Color(0xFF828282)),
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: gpa),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 35,
                child: TextField(
                  onChanged: (value) {
                    startDate = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF828282)),
                    ),
                    isDense: true,
                    labelText: "Waktu Mulai",
                    labelStyle: TextStyle(color: Color(0xFF828282)),
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: startDate),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 35,
                child: TextField(
                  onChanged: (value) {
                    endDate = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF828282)),
                    ),
                    isDense: true,
                    labelText: "Waktu Selesai",
                    labelStyle: TextStyle(color: Color(0xFF828282)),
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: endDate),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 12, 0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(110, 30),
                        primary: Color(0xFF828282),
                        side: const BorderSide(
                            width: 2, color: Color(0xFF828282)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Batal"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 30),
                        primary: Color(0xFF090774),
                      ),
                      onPressed: () {
                        // Simpan data pendidikan ke Firebase
                        FirebaseFirestore.instance.collection('createCV').add({
                          'universitas': university,
                          'jurusan': department,
                          'ipk': gpa,
                          'waktu_mulai': startDate,
                          'waktu_selesai': endDate,
                        }).then((value) {
                          print('Data pendidikan berhasil disimpan');
                        }).catchError((error) {
                          print('Terjadi kesalahan: $error');
                        });

                        // Update data pendidikan dalam educationTiles
                        setState(() {
                          if (index != null) {
                            educationTiles[index] = ListTile(
                              title: Text(university ?? ''),
                              subtitle: Text(department ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      // Aksi edit
                                      openDialog(index: index);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      // Aksi delete
                                      setState(() {
                                        educationTiles.removeAt(index);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            educationTiles.add(
                              ListTile(
                                title: Text(university ?? ''),
                                subtitle: Text(department ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        // Aksi edit
                                        openDialog(
                                            index: educationTiles.length - 1);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        // Aksi delete
                                        setState(() {
                                          educationTiles.removeAt(index!);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 17, 0, 0),
                    child: Text(
                      "Pendidikan",
                      style: TextStyle(
                        color: const Color(0xFF090774),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(95, 17, 0, 0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(10, 30),
                        primary: const Color(0xFF090774),
                        side: const BorderSide(
                            width: 2, color: Color(0xFF090774)),
                      ),
                      child: const Text("Tambah"),
                      onPressed: () {
                        openDialog();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: educationTiles,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
