import 'package:get/get.dart';
import 'package:theamdata/Db/DBHelper.dart';
import 'package:theamdata/Model/task.dart';

class TaskController extends GetxController{
  @override
  void onReady()
  {
    super.onReady();
  }
  var taskList=<Task>[].obs;
  Future<int> addTask({Task? task })async
{
  return await DBHelper.insert(task);
}
void getTasks()async{
    List<Map<String,dynamic>>tasks =await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromjson(data)).toList());
}
void delete(Task task)
{
   DBHelper.delete(task);
   getTasks();
}
void markTaskCompleted(int id)async
{
  await DBHelper.update(id);
   //getTasks();
}
}