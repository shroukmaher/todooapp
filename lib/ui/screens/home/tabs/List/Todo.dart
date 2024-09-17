import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/ui/model/taskdao.dart';
import 'package:todooapp/ui/screens/home/tabs/List/ListTab.dart';
import 'package:todooapp/ui/screens/updateTodo/updateTodotask.dart';


import '../../../../model/Todo_DM.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todo extends StatefulWidget {
  final TodoDM item;

  Todo({super.key, required this.item});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  CrossFadeState crossFadeState =CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
          motion: BehindMotion() ,
          children: [
            SlidableAction(onPressed: (context){
              setState(() {

                TaskDao.deleteNote(widget.item?.id??"");
              });
              
            },
            foregroundColor: Colors.white,
              icon: Icons.delete,
            label: 'delete',
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24)),),

          ]),
      endActionPane: ActionPane(
          motion: BehindMotion() ,
          children: [
            SlidableAction(onPressed: (context){
              Navigator.pushNamed(context, TaskEdit.route,arguments: widget.item);
            },
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit',
              backgroundColor: Colors.teal,
              borderRadius: BorderRadius.only(topRight: Radius.circular(24),
                  bottomRight: Radius.circular(24)),),

          ]),
      child: Container(
        height: MediaQuery.of(context).size.height * .13,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 22),
        child: Row(
          children: [
            buildVerticalLine(context),
            const SizedBox(
              width: 24,
            ),
            buildTodoInfo(),
            SizedBox(
              width: 16,
            ),
            //buildTodoState()
            GestureDetector(
              onTap: (){
                setState((){
                  widget.item.isDone=!widget.item.isDone;
                  TaskDao.updateTodo(widget.item!);
                  crossFadeState=widget.item.isDone?CrossFadeState.showSecond:CrossFadeState.showFirst;

                });
             },
              child: AnimatedCrossFade(
                  firstChild: buildUnCheckedState(),
                  secondChild: const Text('Done!',
                  style: TextStyle(
                    color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),),
                  crossFadeState: crossFadeState,
                  duration: Duration(milliseconds: 500)),
            )
          ],
        ),
      ),
    );
  }

  buildVerticalLine(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height * .07,
    width: 4,
    decoration: BoxDecoration(
        color: widget.item.isDone ? Colors.green : AppColors.primary,
        borderRadius: BorderRadius.circular(10)),
  );

  buildTodoInfo() => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        Text(
          widget.item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyle.bottomSheetTitle.copyWith(
              color: widget.item.isDone ? Colors.green : AppColors.primary),
        ),
        Spacer(),
        Text(
          widget.item.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppStyle.bodyTextStyle,
        ),
        Spacer(),
      ],
    ),
  );

  buildTodoState() => InkWell(
    onTap: ()  {
      /*await TodoDM.userTodosCollection
          .doc(widget.item.id)
          .update({"isDone": !widget.item.isDone});*/
    },
    child: widget.item.isDone ? buildCheckedState() : buildUnCheckedState(),
  );

  Container buildCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.primary),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        "Done",
        style: TextStyle(
            fontSize: 30,
            color: widget.item.isDone ? Colors.green : AppColors.primary),
      ),
    );
  }

  Container buildUnCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.primary),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Icon(
        Icons.done,
        color: AppColors.white,
        size: 30,
      ),
    );
  }
}