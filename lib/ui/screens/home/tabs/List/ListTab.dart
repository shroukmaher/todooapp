import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todooapp/ui/utils/app_colors.dart';
import 'package:todooapp/ui/utils/app_styles.dart';
import 'package:todooapp/ui/utils/day_time_extension.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedCalenderDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCalender(),Spacer(flex: 75,)
      ],
    );
  }

  buildCalender() {
    return Expanded(
      flex: 25,
      child: Stack(
        children: [
      
            Column(
              children: [
                Expanded(child: Container(color: AppColors.primary,)),
                Expanded(child: Container(color: AppColors.bgColor))
      ],
            ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            focusDate: selectedCalenderDate,
            lastDate:DateTime.now().add(Duration(days: 365)),
            onDateChange: (selectedDate) {
              setState(() {
                selectedCalenderDate=selectedDate;
              });
            },
            itemBuilder: (context,date,isSelected,onDateTapped){
              return InkWell(
                onTap:  (){  setState(() {
                  selectedCalenderDate=date;
                });},
                child: Container(
      
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [Spacer(),
                      Text(date.dayName,
                        style: isSelected? AppStyle.selectedCalendarDayStyle: AppStyle.unSelectedCalendarDayStyle,),
                      Spacer(),Text(date.day.toString(),
                        style: isSelected? AppStyle.selectedCalendarDayStyle: AppStyle.unSelectedCalendarDayStyle,),
                      Spacer()
                    ],
                  ),
                ),
              );
            },
          ),
          ],
      

      ),
    );

  }

  void onDateTapped(){}
}
