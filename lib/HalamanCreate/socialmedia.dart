import 'package:flutter/material.dart';
import 'package:login_fiks2/halamanCreate/formatCV.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({Key? key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  TextEditingController instagramController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  List<TextEditingController> listController = [TextEditingController()];

  CollectionReference ref = FirebaseFirestore.instance.collection('createCV');

  @override
  void dispose() {
    instagramController.dispose();
    facebookController.dispose();
    twitterController.dispose();
    for (var controller in listController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.width * 0.16,
        width: MediaQuery.of(context).size.height * 0.16,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => formatcvPage(),
              ),
            );
          },
          child: const Text(
            "Finish",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF090774),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(28, 17, 0, 0),
                child: Text(
                  "Social Media",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFF090774),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                margin: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                child: TextField(
                  controller: instagramController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Instagram",
                      style: TextStyle(color: Color(0xFF828282)),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Color(0xFF090774))
                        ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(30, 15, 30, 0),
                height: 35,
                child: TextField(
                  controller: facebookController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Facebook",
                      style: TextStyle(color: Color(0xFF828282)),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Color(0xFF090774))
                        ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.fromSTEB(30, 15, 30, 0),
                height: 35,
                child: TextField(
                  controller: twitterController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Twitter",
                      style: TextStyle(color: Color(0xFF828282)),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Color(0xFF090774))
                        ),
                  ),
                ),
              ),
              ListView.builder(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
                //padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: listController.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 35,
                            child: TextField(
                              controller: listController[index],
                              autofocus: false,
                              decoration: const InputDecoration(
                                label: Text(
                                  "Lainya (Optional)",
                                  style: TextStyle(color: Color(0xFF828282)),
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
                                    listController[index].clear();
                                    listController[index].dispose();
                                    listController.removeAt(index);
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Color(0xFF090774),
                        side: BorderSide(width: 2, color: Color(0xFF090774)),
                      ),
                      onPressed: () {
                        setState(() {
                          listController.add(TextEditingController());
                        });
                      },
                      child: Text("Tambah"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Save social media information to Firebase Firestore
                        ref.add({
                          'instagram': instagramController.text,
                          'facebook': facebookController.text,
                          'twitter': twitterController.text,
                        });
                        for (var controller in listController) {
                          ref.add({'lainya': controller.text});
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
            ],
          ),
        ),
      ),
    );
  }
}
