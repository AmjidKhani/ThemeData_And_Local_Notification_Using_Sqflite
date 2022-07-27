import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:theamdata/Model/task.dart';
import 'package:theamdata/controller/task_controller.dart';
import 'package:theamdata/ui/Themes.dart';
import 'Provide/ThemeService.dart';
import 'button.dart';
import 'input_fields.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}
class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController=Get.put(TaskController());
  TextEditingController _titleController=TextEditingController();
  TextEditingController _noteController=TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endtime = "9:30 Pm";
  String _StartTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', "Weekly", "Monthly"];
int _selectedcolor=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Add Task",
                style: titlestyle,
              ),
              MyInputField(title: "Title", hint: "Enter Your Title",controller: _titleController,),
              MyInputField(title: "Note", hint: "Enter Your Note",controller: _noteController,),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    //print("hello");
                    _getDataFromUser();
                    print(_selectedDate);
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Date",
                      hint: _StartTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimefromUser(isStartTime: true);
                        },
                        icon: Icon(Icons.access_time_rounded),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "End Date",
                      hint: _endtime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimefromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(

                      title: "Remind",
                      hint: "$_selectedRemind minutes early",
                      widget: DropdownButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(height: 0,),
                        items: remindList
                            .map<DropdownMenuItem<String>>((int value) {
                          return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()));
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            _selectedRemind = int.parse(newvalue!);
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              ,
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Repeat",
                      hint: "$_selectedRepeat",
                      widget: DropdownButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(height: 0,),
                        items: repeatList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.grey),
                              ));
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            _selectedRepeat = newvalue!;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 18,
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   _getcolor(),
                   MyButton(label: "Create Task",onTap: ()=>_validateData(),)

                 ],
               ),
               //


            ],
          ),
        ),
      ),
    );
  }
  _getcolor()
  {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  "Color",
  style: subTitleStyle,
  ),
  SizedBox(height: 8,),
  Wrap(
  children: List<Widget>.generate(3, (int index) {
  return GestureDetector(
  onTap: ()
  {
  setState(() {

    _selectedcolor=index;
  });
  },
  child: Padding(
  padding: const EdgeInsets.all(5.0),
  child: CircleAvatar(
  radius: 14,
  backgroundColor: index==0?primaryClr:
  index==1?pinkClr:yellowClr,

  child:_selectedcolor==index?Icon(Icons.done,
  ):Container(),

  ),
  ),

  );
  }
  ),
  )
  ],
    );
}

  _getTimefromUser({required bool isStartTime}) async {
    var pickedTime = await _showtimePicker();

    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time cancel");
    } else if (isStartTime == true) {
      setState(() {
        _StartTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endtime = _formatedTime;
      });
    }
  }

  _showtimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_StartTime.split(":")[0]),
            minute: int.parse(_StartTime.split(":")[1].split("")[0])));
  }

  _getDataFromUser() async {
    DateTime? _pickerdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2323),
    );
    if (_pickerdate != null) {
      setState(() {
        _selectedDate = _pickerdate;
      });
    } else {
      print("Date Picker take null");
    }
  }

  _appbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(backgroundImage: AssetImage('lib/images/profile.png')),
        //Icon(Icons.person,size: 20,),
        SizedBox(width: 20)
      ],
    );
  }
  _validateData(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty)
    {
      _addTasktoDb();
Get.back();
    }
    else if(_titleController.text.isEmpty||_noteController.text.isEmpty)
    {
      Get.snackbar("Required", "All Fields are Required !",
      snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(Icons.warning)
      );
    }
  }
  _addTasktoDb()async{
   int value =await _taskController.addTask(
    task: Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _StartTime,
      endTime: _endtime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedcolor,
      isCompleted: 0,
    )
    );
   print("My Id  is  +${value}");
  }
}
