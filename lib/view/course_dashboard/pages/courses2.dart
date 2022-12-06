import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/courseinfo.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/uploadcourse.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end,
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
                child: new Text('New Unit',
                    style: new TextStyle(fontSize: 16.0, color: Colors.black)),
                onPressed: () {
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CoursesInfo()),
  );
                },
              ),
            ],
          ),
          Container(
              height: 650,
              width: 1200,
              child: ResponsiveGridList(
                horizontalGridSpacing:
                    16, // Horizontal space between grid items
                // Vertical space between grid items
                horizontalGridMargin: 10, // Horizontal space around the grid
                verticalGridMargin: 50, // Vertical space around the grid
                minItemWidth:
                    600, // The minimum item width (can be smaller, if the layout constraints are smaller)
                minItemsPerRow:
                    2, // The minimum items to show in a single row. Takes precedence over minItemWidth
                maxItemsPerRow:
                    5, // The maximum items to show in a single row. Can be useful on large screens
                listViewBuilderOptions:
                    ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                children: [
                  courses2(context),
                  courses2(context),
                  courses2(context),
                  courses2(context),
                ], // The list of widgets in the list
              )),
        ],
      ),
    );
  }
}

courses2(BuildContext context) {
  return Container(
    height: 200,
    width: 300,
    decoration: BoxDecoration(border: Border.all(color: mainColor)),
    child: Row(
      children: [
        Container(
          height: 200,
          width: 200,
          child: Image.asset(
            'assets/ee-1.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Advance Wordpress',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 360,
                child: Text(
                  'Wordpress is a free source.free to use content managment system,using which,anyone can devlop',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Daily Users',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Published',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 60,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadCoursesScreen()),
                        );
                      },
                      child: Text(
                        'Lessons',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 60,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
