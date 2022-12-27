import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class ViewPdfScreen extends StatelessWidget {
  final String pdfString;
  const ViewPdfScreen({super.key, required this.pdfString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenShadeColor,
      ),
      body: HtmlWidget(pdfString),
    );
  }
}
