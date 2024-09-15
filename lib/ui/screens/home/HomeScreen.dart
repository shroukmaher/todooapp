import 'package:flutter/material.dart';
import 'package:todooapp/ui/screens/home/tabs/List/ListTab.dart';
import 'package:todooapp/ui/screens/home/tabs/Settings/SettingsTab.dart';
import 'package:todooapp/ui/utils/app_colors.dart';

import '../add_bottom_sheet/add_bottom_sheet.dart';

class Home extends StatefulWidget {
  static const String RouteName="/Home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex=0;
  List<Widget> tabs=[ListTab(),SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: buildBottomNavigations(),
      floatingActionButton: buildfab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBottomNavigations() =>
      BottomAppBar(
        clipBehavior: Clip.hardEdge,
        notchMargin: 12,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            currentIndex: currentIndex,
        onTap:(tappedIndex){
              currentIndex=tappedIndex;
              setState(() {});
        } ,
        showSelectedLabels: false,
            showUnselectedLabels: false
            ,items:  [
          BottomNavigationBarItem(icon: Row(
            children: [
              Container(
              margin: EdgeInsets.only(right: 22)
              ,child: Icon(Icons.list)),
            ],
          ),label: "List"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings")
        ]),
      );

  buildfab()=>FloatingActionButton(
    onPressed: (){
     AddBottomSheet.show(context);
    },
    child: Icon(Icons.add),
    backgroundColor: AppColors.primary,
    shape: StadiumBorder(side: BorderSide(color:Colors.white,width: 3)),
    );
}
