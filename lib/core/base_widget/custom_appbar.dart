import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentation/screens/medicineScreens/medicineSearchScreen.dart';

class CutsomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final  String title   ;

  const CutsomAppBar({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MedicineSearchScreen()));
          },
          icon: const Icon(Icons.search),
        ),
      ],
    )
    ;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40.h);
}
