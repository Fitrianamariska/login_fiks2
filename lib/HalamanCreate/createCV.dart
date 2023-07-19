import 'package:flutter/material.dart';
import 'package:login_fiks2/halamanCreate/createEducation.dart';
import 'package:login_fiks2/halamanCreate/createLainnya.dart';
import 'package:login_fiks2/halamanCreate/createPengalaman%20(1).dart';
import 'package:login_fiks2/halamanCreate/socialmedia.dart';
import 'package:login_fiks2/halamanCreate/tentangSaya.dart';
import 'package:login_fiks2/widget/widget.dart';

class createCV extends StatefulWidget {
  final IconData icon;
  final bool isSelected;
  final Function() onTap;

  createCV({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _createCVState createState() => _createCVState();
}

class _createCVState extends State<createCV> {
  Color _iconColor = const Color.fromARGB(255, 20, 8, 8);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.icon,
        color: widget.isSelected ? Colors.grey : _iconColor,
      ),
      onPressed: () {
        setState(() {});
        widget.onTap();
      },
    );
  }
}

class CreateCV extends StatefulWidget {
  const CreateCV({Key? key}) : super(key: key);

  @override
  _CreateCVState createState() => _CreateCVState();
}

class _CreateCVState extends State<CreateCV> {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    Icons.person,
    Icons.school,
    Icons.work,
    Icons.lightbulb,
    Icons.group,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Color(0xFF090774),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                )); // Navigate back to createJudul page
          },
        ),
        centerTitle: true,
        title: Text(
          'Create',
          style:
              TextStyle(color: Color(0xFF090774), fontWeight: FontWeight.bold),
        ),
      ),
      body: Row(
        children: [
          Container(
            width: 60.0,
            //  decoration: BoxDecoration(
            //    color: Colors.amber,
            //  ),
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelType: NavigationRailLabelType.none,
              destinations: _icons.map((IconData icon) {
                return NavigationRailDestination(
                  icon: createCV(
                    icon: icon,
                    isSelected: _selectedIndex == _icons.indexOf(icon),
                    onTap: () {
                      _onItemTapped(_icons.indexOf(icon));
                    },
                  ),
                  label: SizedBox.shrink(),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 201, 194, 194),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IndexedStack(
                          index: _selectedIndex,
                          children: [
                            TentangSayaPage(),
                            EducationPage(),
                            CreatePengalaman(),
                            SkillsPage(),
                            SocialMediaPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
