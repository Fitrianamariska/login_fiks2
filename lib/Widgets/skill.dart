import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SkillWidget extends StatefulWidget {
  SkillWidget({super.key});

  @override
  State<SkillWidget> createState() => _SkillWidgetState();
}

class _SkillWidgetState extends State<SkillWidget> {
  List<TextEditingController> listControllerSkill = [TextEditingController()];
  List<TextEditingController> listControllerTingkat = [TextEditingController()];

  CollectionReference ref = FirebaseFirestore.instance.collection('skill');

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
                      "Skill",
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
                        itemCount: listControllerSkill.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 140,
                                    height: 35,
                                    child: TextField(
                                      controller: listControllerSkill[index],
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          'Skill',
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
                                      controller:
                                          listControllerTingkat.length > index
                                              ? listControllerTingkat[index]
                                              : TextEditingController(),
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        label: Text(
                                          'Tingkat(%)',
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
                                            listControllerSkill[index].clear();
                                            listControllerSkill[index]
                                                .dispose();
                                            if (listControllerTingkat.length >
                                                index) {
                                              listControllerTingkat[index]
                                                  .dispose();
                                            }
                                            listControllerSkill.removeAt(index);
                                            if (listControllerTingkat.length >
                                                index) {
                                              listControllerTingkat
                                                  .removeAt(index);
                                            }
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
                              listControllerSkill.add(TextEditingController());
                              listControllerTingkat
                                  .add(TextEditingController());
                            });
                          },
                          child: Text("Tambah"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          for (int i = 0; i < listControllerSkill.length; i++) {
                            ref.add({
                              'skill': listControllerSkill[i].text,
                              'tingkat': listControllerTingkat.length > i
                                  ? listControllerTingkat[i].text
                                  : '',
                            });
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
