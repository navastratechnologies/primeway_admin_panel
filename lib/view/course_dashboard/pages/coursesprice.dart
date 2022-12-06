import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'courseinfo.dart';

class CoursesPrice extends StatefulWidget {
  const CoursesPrice({super.key});

  @override
  State<CoursesPrice> createState() => _CoursesPriceState();
}

class _CoursesPriceState extends State<CoursesPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'New Course Details',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            elevation: 5.0,
            minWidth: 200.0,
            height: 45,
            color: whiteColor,
            hoverColor: mainColor,
            child: new Text('Save',
                style: new TextStyle(fontSize: 16.0, color: Colors.black)),
            onPressed: () {
              setState(() {
                // _isNeedHelp = true;
              });
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        //color: Colors.amber,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      ),
                      elevation: 5.0,
                      minWidth: 200.0,
                      height: 45,
                      color: Colors.grey,
                      hoverColor: Colors.blue,
                      child: new Text('Course Detail',
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.black)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CoursesInfo()),
                        );
                      },
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(0.0),
                      )),
                      elevation: 5.0,
                      minWidth: 200.0,
                      height: 45,
                      color: Colors.grey,
                      hoverColor: Colors.blue,
                      child: new Text('Course Price',
                          style: new TextStyle(
                              fontSize: 16.0, color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          // _isNeedHelp = true;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.black,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: ResponsiveGridList(
                    horizontalGridSpacing:
                        16, // Horizontal space between grid items
                    // Vertical space between grid items
                    horizontalGridMargin:
                        10, // Horizontal space around the grid
                    verticalGridMargin: 50, // Vertical space around the grid
                    minItemWidth:
                        300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                    minItemsPerRow:
                        4, // The minimum items to show in a single row. Takes precedence over minItemWidth
                    maxItemsPerRow:
                        4, // The maximum items to show in a single row. Can be useful on large screens
                    listViewBuilderOptions:
                        ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                    children: [
                      course2('BASE AMOUNT', 'BASE AMOUNT'),
                      course2('GST amount', 'GST AMOUNT'),
                      course2('CGST AMOUNT', 'CGST AMOUNT'),
                      course2('SGST AMOUNT', 'SGST AMOUNT'),
                      course2('GST RATE', 'GST RATE'),
                      course2('CGST RATE', 'CGST RATE'),
                      course2('SGST RATE', 'SGST RATE'),
                      course2('NET AMOUNT', 'NET AMOUNT'),
                      // course2('Course Name', 'Name Of the Course'),
                      // course2('Course Name', 'Name Of the Course'),
                      // course2('Course Name', 'Name Of the Course'),
                      // course2('Course Name', 'Name Of the Course'),
                      // course2('Course Name','Name Of the Course'),
                    ], // The list of widgets in the list
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

course2(name, name1) {
  return TextField(
    //obscureText: true,
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: name, hintText: name1),
  );
}
