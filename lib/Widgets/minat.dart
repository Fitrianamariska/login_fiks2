import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MinatWidget extends StatefulWidget {
  MinatWidget({Key? key});

  @override
  State<MinatWidget> createState() => _MinatWidgetState();
}

class _MinatWidgetState extends State<MinatWidget> {
  List<TextEditingController> listControllerMinat = [TextEditingController()];

  CollectionReference ref = FirebaseFirestore.instance.collection('minat');

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
                      "Minat (Opsional)",
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
                        itemCount: listControllerMinat.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 35,
                                    child: TextField(
                                      controller: listControllerMinat[index],
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          'Minat',
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
                                            listControllerMinat[index].clear();
                                            listControllerMinat[index]
                                                .dispose();
                                            listControllerMinat.removeAt(index);
                                          });
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Color(0xFF090774),
                                          size: 28,
                                        ),
                                      )
                                    : const SizedBox(),
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
                              listControllerMinat.add(TextEditingController());
                            });
                          },
                          child: Text("Tambah"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          for (var controller in listControllerMinat) {
                            ref.add({'minat': controller.text});
                          }
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
