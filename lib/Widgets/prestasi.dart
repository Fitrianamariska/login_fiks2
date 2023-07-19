import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrestasiWidget extends StatefulWidget {
  const PrestasiWidget({Key? key});

  @override
  State<PrestasiWidget> createState() => _PrestasiWidgetState();
}

class _PrestasiWidgetState extends State<PrestasiWidget> {
  List<TextEditingController> listControllerPrestasi = [
    TextEditingController()
  ];
  List<TextEditingController> listControllerTahun = [TextEditingController()];

  CollectionReference ref = FirebaseFirestore.instance.collection('prestasi');

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Column(
            children: [
              ScrollOnExpand(
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    tapBodyToCollapse: true,
                    tapBodyToExpand: true,
                  ),
                  header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Prestasi dan Penghargaan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF090774),
                      ),
                    ),
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listControllerPrestasi.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 35,
                                    child: TextField(
                                      controller: listControllerPrestasi[index],
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          'Prestasi',
                                          style: TextStyle(
                                              color: Color(0xFF828282)),
                                        ),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 5),
                                    width: 10,
                                    height: 35,
                                    child: TextField(
                                      controller: listControllerTahun[index],
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          'Tahun',
                                          style: TextStyle(
                                              color: Color(0xFF828282)),
                                        ),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                index != 0
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            listControllerPrestasi[index]
                                                .clear();
                                            listControllerTahun[index].clear();
                                            listControllerPrestasi[index]
                                                .dispose();
                                            listControllerTahun[index]
                                                .dispose();
                                            listControllerPrestasi
                                                .removeAt(index);
                                            listControllerTahun.removeAt(index);
                                          });
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Color(0xFF090774),
                                          size: 28,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 242,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Color(0xFF090774),
                            side:
                                BorderSide(width: 2, color: Color(0xFF090774)),
                          ),
                          onPressed: () {
                            setState(() {
                              listControllerPrestasi
                                  .add(TextEditingController());
                              listControllerTahun.add(TextEditingController());
                            });
                          },
                          child: Text("Tambah"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          for (int i = 0; i < listControllerPrestasi.length; i++) {
                            ref.add({
                              'prestasi': listControllerPrestasi[i].text,
                              'tahun': listControllerTahun.length > i
                                  ? listControllerTahun[i].text
                                  : '',
                            });
                          }
                          // for (var i = 0;
                          //     i < listControllerPrestasi.length;
                          //     i++) {
                          //   ref.add({
                          //     'prestasi': listControllerPrestasi[i].text,
                          //     'tahun': listControllerTahun[i].text,
                          //   });
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900], // Background color
                          onPrimary: Colors.white, // Text color
                        ),
                        child: Text("Simpan"),
                      ),
                    ],
                  ),
                  collapsed: Text(
                    "",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
