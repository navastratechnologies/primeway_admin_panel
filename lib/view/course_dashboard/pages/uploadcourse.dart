import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UploadCoursesScreen extends StatefulWidget {
  const UploadCoursesScreen({super.key});

  @override
  State<UploadCoursesScreen> createState() => _UploadCoursesScreenState();
}

class _UploadCoursesScreenState extends State<UploadCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 810,
        // height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Container(
                            height: 50,
                            width: 500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey),
                                color: greenLightShadeColor),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: TextField(
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                      //border: OutlineInputBorder(),
                                      hintText: 'Search Unit',
                                      prefixIcon: Icon(Icons.search)),
                                )))),
                    SizedBox(
                      width: 120,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      elevation: 5.0,
                      minWidth: 150.0,
                      height: 50,
                      color: mainColor,
                      child: new Text('+ New Unit',
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          // _isNeedHelp = true;
                        });
                      },
                    ),
                  ],
                ),

                Container(height: 1, width: 800, color: Colors.grey),
                const ExpansionTile(
                  title: Text('Discussion & User Management'),
                  textColor: Colors.blue,
                  //backgroundColor: Colors.green,
                  //subtitle: Text('Leading expansion arrow icon'),
                  controlAffinity: ListTileControlAffinity.leading,
                  trailing: Icon(Icons.delete),
                  children: <Widget>[
                    ListTile(title: Text('This is tile number 3')),
                  ],
                ),
                // Icon(Icons.arrow_downward),
                // Icon(Icons.edit_attributes,color: Colors.blue,),
                Container(height: 1, width: 800, color: Colors.grey),
                const ExpansionTile(
                  title: Text('Posts'),
                  //subtitle: Text('Leading expansion arrow icon'),
                  controlAffinity: ListTileControlAffinity.leading,
                  trailing: Icon(Icons.delete),
                  children: <Widget>[
                    ListTile(title: Text('This is tile number 3')),
                  ],
                ),
                Container(
                  height: 1,
                  width: 800,
                  color: Colors.grey,
                ),
                const ExpansionTile(
                  title: Text('Media & General Settings'),
                  //subtitle: Text('Leading expansion arrow icon'),
                  controlAffinity: ListTileControlAffinity.leading,
                  trailing: Icon(Icons.delete),
                  children: <Widget>[
                    ListTile(title: Text('This is tile number 3')),
                  ],
                ),
                Container(
                  height: 1,
                  width: 800,
                  color: Colors.grey,
                ),
                const ExpansionTile(
                  title: Text('Contact Functionalities'),
                  //subtitle: Text('Leading expansion arrow icon'),
                  controlAffinity: ListTileControlAffinity.leading,
                  trailing: Icon(Icons.delete),
                  children: <Widget>[
                    ListTile(title: Text('This is tile number 3')),
                  ],
                ),
                Container(
                  height: 1,
                  width: 800,
                  color: Colors.grey,
                ),
                const ExpansionTile(
                  title: Text('Analyticks & Security'),
                  // subtitle: Text('Leading expansion arrow icon'),
                  controlAffinity: ListTileControlAffinity.leading,
                  trailing: Icon(Icons.delete),
                  children: <Widget>[
                    ListTile(title: Text('This is tile number 3')),
                  ],
                ),
                Container(
                  height: 1,
                  width: 800,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
