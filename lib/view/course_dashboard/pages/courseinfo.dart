import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:primeway_admin_panel/view/course_dashboard/pages/coursesprice.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class CoursesInfo extends StatefulWidget {
  const CoursesInfo({super.key});

  @override
  State<CoursesInfo> createState() => _CoursesInfoState();
}

class _CoursesInfoState extends State<CoursesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(backgroundColor: mainColor,
         title: const Text('New Course Details',style: TextStyle(color: Colors.black),),
         actions: [  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                    elevation: 5.0,
                    minWidth: 200.0,
                    height: 45,
                    color: whiteColor,
                    hoverColor:mainColor,
                    child: new Text('Save',
                        style: new TextStyle(
                            fontSize: 16.0, color: Colors.black)),
                    onPressed: () {
                      setState(() {
                        // _isNeedHelp = true;
                      });
                    },
                  ),],

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        //color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                          ),
                          elevation: 5.0,
                          minWidth: 200.0,
                          height: 45,
                          color: Colors.grey,
                          hoverColor: Colors.blue,
                          child: new Text('Course Detail',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                          onPressed: () {},
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CoursesPrice()),
                              );
                            }),
                      ],
                    ),
                    Container(
                      width: 1000,
                      height: 2,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: SizedBox(
                          width: 1000,
                          height: 550,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:500,
                                width: 300,
                                child: ListView(
                                  children: [
                                    course2('COURSE NAME', 'name of courses'),
                                    course2('AUTHOR NAME', 'name of course author'),
                                    course2('COURSE NAME', 'name of courses'),
                                    course2('REQUIRED POINTS', 'points required to access course'),
                                    available()
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  course2('COURSE NAME', 'name of courses'),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'COURSE NAME',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Container(
                                            height: 130,
                                            width: 300,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: TextField(
                                              maxLines: 6,
                                            )),
                                      ],
                                    ),
                                  ),
                                  courses2('validity', 'validity'),
                                  Container(
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 220,
                                          child: TextField(
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Validity'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          width: 60,
                                          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey)),
                                          child: Text(
                                            'DAYS',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  // available()
                                ],
                              ),
                              Column(
                                children: [
                                  courses2('validity', 'validity'),
                                  courses2('validity', 'validity'),
                                  courses2('validity', 'validity'),
                                  courses2('validity', 'validity'),
                                  // available()
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                )),
            Container(
              height: 800,
              width: 2,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: 220,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Image.asset('assets/capture.png'),
                  ),SizedBox(height: 30,),
                  Text(
                    'UPLOAD PHOTO HERE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

course2(name, name1) {
  return SizedBox(
    height: 100,
    width: 300,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        TextField(
          //obscureText: true,
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: name1),
        ),
      ],
    ),
  );
}

courses2(name3, name4) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name3,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        Container(
            height: 80,
            width: 300,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(6),
            //     border: Border.all(color: Colors.grey)),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: name4),
            )),
      ],
    ),
  );
}

available() {
  return SizedBox(
    height: 300,
    width: 300,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Availability',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
          ),
        ),
        Row(
          children: [
            Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.blue, width: 3),
                  color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Availability',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.blue, width: 3),
                  color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Availability',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Availability',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
          ),
        ),
        Row(
          children: [
            Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.blue, width: 3),
                  color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Availability',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 17,
              width: 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.blue, width: 3),
                  color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Availability',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Availability',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

// 
  