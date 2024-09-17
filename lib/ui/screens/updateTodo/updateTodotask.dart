import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/ui/model/taskdao.dart';
import 'package:todooapp/ui/utils/app_styles.dart';

import '../../model/Todo_DM.dart';

class  TaskEdit extends StatefulWidget{

  static const String route="EditScreen";
   TaskEdit({super.key});

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  DateTime selectedDate=DateTime.now();

  TextEditingController titleController=TextEditingController();

  TextEditingController descController=TextEditingController();
  TodoDM? item;
  @override
  Widget build(BuildContext context) {
    if(item==null) {
      item = ModalRoute
          .of(context)
          ?.settings
          .arguments as TodoDM;

      titleController.text=item?.title??"";
      descController.text=item?.description??"";
      selectedDate=DateTime.fromMillisecondsSinceEpoch(item!.date.millisecondsSinceEpoch);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Todo List',style: AppStyle.appBarStyle),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: MediaQuery.of(context).size.height*.1,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom:20),
              height: MediaQuery.of(context).size.height*.77,
              width: MediaQuery.of(context).size.width*.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24)

              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Edit Task",textAlign: TextAlign.center,
                        style: AppStyle.bottomSheetTitle),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                                hintText: "Enter task title"
                            ),
                          ),
                          SizedBox(height: 12,),
                          TextField(
                            controller: descController,
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
                          ElevatedButton(onPressed: () async{
                      item?.title=titleController.text;
                      item?.description=descController.text;
                      item?.date=selectedDate;

                      await TaskDao.updateTodo(item!);
                      Navigator.pop(context);
                          },
                              child: Text("Add"))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
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
