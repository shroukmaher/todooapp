import 'package:flutter/material.dart';
import 'package:todooapp/ui/utils/app_colors.dart';

import '../../utils/app_styles.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static void show(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, builder:
        (context)=>Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddBottomSheet(),

        ));  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return
    Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height*.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Add new task",textAlign: TextAlign.center,
          style: AppStyle.bottomSheetTitle,),
          const TextField(
            decoration: InputDecoration(
              hintText: "Enter task title"
            ),
          ),
          SizedBox(height: 12,),
          const TextField(
            decoration: InputDecoration(
                hintText: "Enter task description"
            ),
          ),
          SizedBox(height: 12,),
          Text("Select date",style: AppStyle.bottomSheetTitle.copyWith(fontSize: 16),),
          InkWell(
          onTap:(){
            showMyDatePicker();
          },
              child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",style: AppStyle.normalGreyTextStyle,textAlign: TextAlign.center,)),
          Spacer(),
          ElevatedButton(onPressed: (){},
              child: Text("Add"))
        ],
      ),
    );
  }

  void showMyDatePicker() async{

   selectedDate= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)))??selectedDate;

  }
}
