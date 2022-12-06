import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courseinfo.dart';
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
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1000,
        // height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CoursesInfo()),
                        );
                      },
                    ),
                  ],
                ),
                Container(height: 1, width: 850, color: Colors.grey),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 800,
                        child: ExpansionTile(
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
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        //tooltip: 'Increase volume by 10',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  //width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: AlertDialog(
                                    title: Container(
                                      //width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.plus_one,
                                                color: Colors.blue,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Container(
                                                            //width: 100,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: AlertDialog(
                                                              title: Container(
                                                                //width: 100,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              30),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            80,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(40),
                                                                            color: Colors.red),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Lesson Type',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              35,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              20),
                                                                      child:
                                                                          DropdownButton(
                                                                        // Initial Value
                                                                        value:
                                                                            dropdownvalue,

                                                                        // Down Arrow Icon
                                                                        icon: const Icon(
                                                                            Icons.keyboard_arrow_down),

                                                                        // Array list of items
                                                                        items: items.map((String
                                                                            items) {
                                                                          return DropdownMenuItem(
                                                                            value:
                                                                                items,
                                                                            child:
                                                                                Text(items),
                                                                          );
                                                                        }).toList(),
                                                                        // After selecting the desired option,it will
                                                                        // change button value to selected value
                                                                        onChanged:
                                                                            (String?
                                                                                newValue) {
                                                                          setState(
                                                                              () {
                                                                            dropdownvalue =
                                                                                newValue!;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        MaterialButton(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                            Radius.circular(0.0),
                                                                          )),
                                                                          elevation:
                                                                              5.0,
                                                                          minWidth:
                                                                              100.0,
                                                                          height:
                                                                              45,
                                                                          color:
                                                                              Colors.green,
                                                                          child: new Text(
                                                                              'Create Lesson',
                                                                              style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              // _isNeedHelp = true;
                                                                            });
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        MaterialButton(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                            Radius.circular(0.0),
                                                                          )),
                                                                          elevation:
                                                                              5.0,
                                                                          minWidth:
                                                                              100.0,
                                                                          height:
                                                                              45,
                                                                          color:
                                                                              Colors.red,
                                                                          child: new Text(
                                                                              'Cancel',
                                                                              style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              // _isNeedHelp = true;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Text(
                                                    'Create new lesson',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 4, 71, 125)),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Color.fromARGB(
                                                    255, 75, 164, 237),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Container(
                                                            //width: 100,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: AlertDialog(
                                                              title: Container(
                                                                //width: 100,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          300,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Title',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 13,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          TextField(
                                                                            //obscureText: true,
                                                                            decoration:
                                                                                InputDecoration(border: OutlineInputBorder(), hintText: 'Discussion & management'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              20),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'COURSE NAME',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 13,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              height: 130,
                                                                              width: 300,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey)),
                                                                              child: TextField(
                                                                                maxLines: 6,
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          150,
                                                                      width:
                                                                          300,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 20),
                                                                            child:
                                                                                Text(
                                                                              'Publish Unit?',
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                height: 17,
                                                                                width: 17,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(color: Colors.blue, width: 3), color: Colors.white),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                'Availability',
                                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              Container(
                                                                                height: 17,
                                                                                width: 17,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), border: Border.all(color: Colors.blue, width: 3), color: Colors.white),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                'Availability',
                                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              MaterialButton(
                                                                                shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.all(
                                                                                  Radius.circular(0.0),
                                                                                )),
                                                                                elevation: 5.0,
                                                                                minWidth: 80.0,
                                                                                height: 45,
                                                                                color: Colors.green,
                                                                                child: new Text('Save', style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    // _isNeedHelp = true;
                                                                                  });
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              MaterialButton(
                                                                                shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.all(
                                                                                  Radius.circular(0.0),
                                                                                )),
                                                                                elevation: 5.0,
                                                                                minWidth: 80.0,
                                                                                height: 45,
                                                                                color: Colors.grey,
                                                                                child: new Text('Close', style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    // _isNeedHelp = true;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Text(
                                                    'Edit unit Info',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.green,
                                              ),
                                              TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Publish Unit',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.delete_forever,
                                                color: Colors.blue,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Container(
                                                            //width: 100,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: AlertDialog(
                                                              title: Container(
                                                                //width: 100,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              40),
                                                                          color:
                                                                              Colors.red),
                                                                    ),SizedBox(height: 30,),
                                                                    
                                                                    Text(
                                                                              'Are you sure?',
                                                                              style: new TextStyle(fontSize: 30.0, color: Colors.black)),
                                                                      SizedBox(height: 12,),

                                                                      Text(
                                                                              'you want to delete the following unit?',
                                                                              style: new TextStyle(fontSize: 15.0, color: Colors.black)),
                                                                            SizedBox(height: 12,),    

                                                                    Text(
                                                                              'Discussion & user Management',
                                                                              style: new TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold)),
                                                                              SizedBox(height: 20,),
                                                                      SizedBox(width: 300,
                                                                        child: Text(
                                                                                'all the lessons and resourses will be deleted along with all the student progress',
                                                                                style: new TextStyle(fontSize: 15.0, color: Colors.black),textAlign: TextAlign.center,),
                                                                      ),
                                                                    SizedBox(height: 20,),





                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        MaterialButton(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                            Radius.circular(0.0),
                                                                          )),
                                                                          elevation:
                                                                              5.0,
                                                                          minWidth:
                                                                              80.0,
                                                                          height:
                                                                              45,
                                                                          color:
                                                                              Colors.green,
                                                                          child: new Text(
                                                                              'Yes,Delete Unit',
                                                                              style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              // _isNeedHelp = true;
                                                                            });
                                                                          },
                                                                        ),
                                                                        MaterialButton(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                            Radius.circular(0.0),
                                                                          )),
                                                                          elevation:
                                                                              5.0,
                                                                          minWidth:
                                                                              80.0,
                                                                          height:
                                                                              45,
                                                                          color:
                                                                              Colors.red,
                                                                          child: new Text(
                                                                              'No',
                                                                              style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              // _isNeedHelp = true;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ]),
                Container(height: 1, width: 850, color: Colors.grey),
                expansion(context),
                Container(
                  height: 1,
                  width: 850,
                  color: Colors.grey,
                ),
                expansion(context),
                Container(
                  height: 1,
                  width: 850,
                  color: Colors.grey,
                ),
                expansion(context),
                Container(
                  height: 1,
                  width: 850,
                  color: Colors.grey,
                ),
                expansion(context),
                Container(
                  height: 1,
                  width: 850,
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

expansion(BuildContext context) {
  return Row(mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 800,
          child: ExpansionTile(
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
        ),
        IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          //tooltip: 'Increase volume by 10',
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    width: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: AlertDialog(
                      title: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.plus_one,
                                  color: Colors.blue,
                                ),
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: AlertDialog(
                                                title: Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            color: Colors.red),
                                                      ),
                                                      Text(
                                                        'Lesson Type',
                                                        style: TextStyle(
                                                            fontSize: 35,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Create new lesson',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 4, 71, 125)),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 75, 164, 237),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Edit unit Info',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.green,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Publish Unit',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.blue,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Create new lesson',
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ]);
}
