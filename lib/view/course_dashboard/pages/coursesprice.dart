import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'courseinfo.dart';

class CoursesPrice extends StatefulWidget {
  const CoursesPrice({super.key});

  @override
  State<CoursesPrice> createState() => _CoursesPriceState();
}

class _CoursesPriceState extends State<CoursesPrice> {
  TextEditingController baseAmmountController = TextEditingController();
  TextEditingController gstAmmountController = TextEditingController();
  TextEditingController cgstAmmountController = TextEditingController();
  TextEditingController sgstAmmountController = TextEditingController();
  TextEditingController gstRateController = TextEditingController();
  TextEditingController cgstRateController = TextEditingController();
  TextEditingController sgstRateController = TextEditingController();
  TextEditingController netAmmountCountroller = TextEditingController();

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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
            elevation: 5.0,
            minWidth: 200.0,
            height: 45,
            color: whiteColor,
            hoverColor: mainColor,
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            onPressed: () {
              setState(() {
                // _isNeedHelp = true;
              });
            },
          ),
        ],
      ),
      body: SizedBox(
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
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0.0),
                      ),
                    ),
                    elevation: 5.0,
                    minWidth: 200.0,
                    height: 45,
                    color: Colors.grey,
                    hoverColor: Colors.blue,
                    child: const Text(
                      'Course Detail',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoursesInfo(
                            baseAmmount: baseAmmountController.text,
                            cgstAmmount: cgstAmmountController.text,
                            cgstRate: cgstRateController.text,
                            gstAmmount: gstAmmountController.text,
                            gstRate: gstRateController.text,
                            netAmmount: netAmmountCountroller.text,
                            sgstAmmount: sgstAmmountController.text,
                            sgstRate: sgstRateController.text,
                          ),
                        ),
                      );
                    },
                  ),
                  MaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0.0),
                      ),
                    ),
                    elevation: 5.0,
                    minWidth: 200.0,
                    height: 45,
                    color: Colors.grey,
                    hoverColor: Colors.blue,
                    child: const Text(
                      'Course Price',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
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
                  horizontalGridMargin: 10, // Horizontal space around the grid
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
                    TextField(
                      controller: baseAmmountController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'BASE AMOUNT',
                      ),
                    ),
                    TextField(
                      controller: gstAmmountController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'GST AMOUNT',
                      ),
                    ),
                    TextField(
                      controller: cgstAmmountController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CGST AMOUNT',
                      ),
                    ),
                    TextField(
                      controller: sgstAmmountController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'SGST AMOUNT',
                      ),
                    ),
                    TextField(
                      controller: gstRateController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'GST RATE',
                      ),
                    ),
                    TextField(
                      controller: cgstRateController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CGST RATE',
                      ),
                    ),
                    TextField(
                      controller: sgstRateController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'SGST RATE',
                      ),
                    ),
                    TextField(
                      controller: netAmmountCountroller,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'NET AMOUNT',
                      ),
                    ),
                  ], // The list of widgets in the list
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
