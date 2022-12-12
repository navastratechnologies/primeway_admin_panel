import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class EditCoursePrice extends StatefulWidget {
  const EditCoursePrice({super.key});

  @override
  State<EditCoursePrice> createState() => _EditCoursePriceState();
}

class _EditCoursePriceState extends State<EditCoursePrice> 
with AutomaticKeepAliveClientMixin{
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
    super.build(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: SizedBox(
        width: double.infinity,
        child: ResponsiveGridList(
          horizontalGridSpacing: 16, 
          horizontalGridMargin: 10, 
          verticalGridMargin: 50, 
          minItemWidth:
              300, 
          minItemsPerRow:
              4, 
          maxItemsPerRow:
              4, 
          listViewBuilderOptions:
              ListViewBuilderOptions(), 
          children: [
            TextField(
              controller: baseAmmountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'BASE AMOUNT',
              ),
            ),
            TextField(
              controller: gstAmmountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'GST AMOUNT',
              ),
            ),
            TextField(
              controller: cgstAmmountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CGST AMOUNT',
              ),
            ),
            TextField(
              controller: sgstAmmountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'SGST AMOUNT',
              ),
            ),
            TextField(
              controller: gstRateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'GST RATE',
              ),
            ),
            TextField(
              controller: cgstRateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CGST RATE',
              ),
            ),
            TextField(
              controller: sgstRateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'SGST RATE',
              ),
            ),
            TextField(
              controller: netAmmountCountroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'NET AMOUNT',
              ),
            ),
          ], 
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
