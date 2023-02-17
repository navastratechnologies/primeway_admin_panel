import 'package:flutter/material.dart';
import 'package:primeway_admin_panel/view/helpers/app_constants.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  bool showAdminPanel = true;
  bool showCoursePanel = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PopupMenuButton(
        position: PopupMenuPosition.under,
        child: SizedBox(
          height: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 2,
                width: 26,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 2,
                width: 20,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 2,
                width: 26,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'logout',
            child: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
