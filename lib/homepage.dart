import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:theamdata/Addtaskpage.dart';
import 'package:theamdata/Provide/ThemeService.dart';
import 'package:theamdata/Provide/notification_service.dart';
import 'package:theamdata/button.dart';
import 'package:theamdata/ui/Listtile.dart';
import 'package:theamdata/ui/Themes.dart';
import 'Model/task.dart';
import 'controller/task_controller.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  @override
  State<homepage> createState() => _homepageState();
}
class _homepageState extends State<homepage> {
  final TaskController _taskController=Get.put(TaskController());

  DateTime  _selectedDate=DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.requestIOSPermissions();
    _showTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
   backgroundColor: context.theme.backgroundColor,
   body: Column(
     children: [
       _addTask(),
       _TimeDate(),
       SizedBox(
         height: 10,
       ),
       _showTask(),
     ],
   ),
    );
  }
  _showTask()
  {
   return   Expanded(
        child: Obx(()
    {
return ListView.builder(

itemCount: _taskController.taskList.length,
    itemBuilder: (_ , index)

{
  return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 0,
      child: SlideAnimation(
        child: FadeInAnimation(
          child: Row(
            children: [
              GestureDetector(
                onTap: ()
                {
                  _showBottomSheet(context, _taskController.taskList[index]);
                  print("Tapped");
                },
                child: TaskTile(_taskController.taskList[index]),
              )
            ],
          ),
        ),
      )
  );
}
);
    }
    )

    );
  }
  _showBottomSheet(BuildContext context,Task task)
  {
    Get.bottomSheet(
        Container(
          padding: EdgeInsets.only(top: 4),
          height: task.isCompleted==1?
              MediaQuery.of(context).size.height*0.24:
              MediaQuery.of(context).size.height*0.32,
            color: Get.isDarkMode?darkGreyClr:Colors.white,
          child: Column(
            children: [
              Container(
              height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],
                ),
              ),
              Spacer(),
              task.isCompleted==1?
              Container(): _bottomSheetButton(
                  label: "Task Completed",
                  onTap: (){
                    _taskController.markTaskCompleted(task.id!);
                    //print("query runninug");
                    _taskController.getTasks();
                    Get.back();
                  },
                  clr: primaryClr,
                context:context,
              ),
             // SizedBox(height: 5,),
              _bottomSheetButton(
                label: "Delete Task ",
                onTap: (){
                  _taskController.delete(task);
                  Get.back();
                },
                clr: Colors.red[300]!,
                context:context,
              ),
              SizedBox(height: 30,),
              _bottomSheetButton(
                label: "Close",
                onTap: (){
                  Get.back();
                },
                clr: primaryClr,
                context:context,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
    );
  }
  _bottomSheetButton({
    required String  label,
    required Function()? onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context,
  })
{
return GestureDetector(
  onTap: onTap,
  child: Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    height: 55,
    width: MediaQuery.of(context).size.width*0.9,

      decoration: BoxDecoration(
      border: Border.all(
        width: 2,
        color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr
      ),
        borderRadius: BorderRadius.circular(20),
        color: isClose==true?Colors.transparent :clr,
  ),
child: Center(
  child:   Text(
    label,
    style:isClose?titlestyle:titlestyle.copyWith(color: Colors.white),

  ),
),

  ),
);
}
  _TimeDate(){
    return  Container(
      child:DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectedTextColor:Colors.white ,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(textStyle:
        TextStyle(fontSize: 20,fontWeight: FontWeight.w600,
            color: Colors.grey
        ),),
          monthTextStyle: GoogleFonts.lato(textStyle:
          TextStyle(fontSize: 14,fontWeight: FontWeight.w600,
              color: Colors.grey
          ),),
          dayTextStyle: GoogleFonts.lato(textStyle:
          TextStyle(fontSize: 16,fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
          ),
         onDateChange: (date){
          _selectedDate=date;}
      ),
    );
  }

  _addTask()
  {
    return  Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingstyle,
                ),
                Text("Today"
                  ,style:Headingstyle ,
                ),
              ],
            ),
          ),
          MyButton(label: "Add Task",
              onTap:()
              async {
               await Get.to (() => AddTaskPage());
          _taskController.getTasks();
          }
          )

        ],
      ),
    );
  }
  _appbar(){
return AppBar(
  elevation: 0,
  backgroundColor: context.theme.backgroundColor,
  leading: GestureDetector(
    onTap: (){
     ThemeService().switchTheme();
     notifyHelper.initializeNotification();
     notifyHelper. displayNotification(
       title:"Theme Change",
       body: Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme"
     );
     notifyHelper.scheduledNotification();
    },
    child: Icon(Get.isDarkMode?Icons.wb_sunny :Icons.nightlight_round,size: 20,
    color: Get.isDarkMode ?Colors.white:Colors.black,
    ),
    
  ),
  actions: [
    CircleAvatar
      (backgroundImage: AssetImage(
      'lib/images/profile.png'
    )),
    //Icon(Icons.person,size: 20,),
    SizedBox(width: 20)
  ],
);
  }
}
