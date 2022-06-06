import 'package:flutter/cupertino.dart';

class ToDo {
  bool isDone = false;
  int priority = 0; // 0, 1, 2 (높을 수록 중요)
  String title;
  DateTime doneTime = DateTime(1970, 1, 1, 0, 0, 1);

  ToDo(this.title, this.priority );
}
class ToDoHealth {
  bool isDone = false;
  String title;
  DateTime doingTime;

  ToDoHealth(this.title, this.doingTime);
}

class SubmitExist {
  bool yesMemory = true;
  int rateDay = 3;
  String bestPart = '';
  String promises = '';
}


// ---------나의 경우...-----------
// flutter pub add provider
// flutter pub get
// import 'package:life_is_an_egg/global_data.dart' as data;
// import 'package:provider/provider.dart';
// 제일 상단에 이렇게 넣어서 사용
class CalendarData with ChangeNotifier {

  // 현재 화면에 나타낼 날짜 -> 이 값에 따라 아래 todolist 바뀜
  DateTime _selectedDay = DateTime.now();

 
  // 값 get할 때
  // context.watch<data.CalendarData>().selectedDay;
  DateTime get selectedDay => _selectedDay;
  
  //  값을 변경하고 싶을 때
  // context.read<data.CalendarData>().changeDay(변경하고 싶은 DateTime 객체);
  void changeDay(DateTime day){
    _selectedDay=day;
    notifyListeners();
  }

  // 얘는 근데 바로 변경해도 됨
  // 6월 5일 health task 항목에 접근하고 싶을 때
  // context.watch<data.CalendarData>().calendar[selectedDay.month]?[selectedDay.day]?['health']?['tasks']
  //
  // 그냥 calendar 전체를 받아오고 싶을 때
  // context.watch<data.CalendarData>().calendar
  Map<int, Map<int,Map<String,Map<String,dynamic>>>> calendar = {
    // 월
    6: {
      // 일
      1: {
        // 스케줄
        'schedule': {
          'fixed' : [],
          'unfixed' : [ToDo('AI assignment', 0), ToDo('project', 2)]
        },
        // 건강
        'health' : {
          'tasks' : [
            ToDoHealth('Vitamin', DateTime(1970,1,1, 8, 7)),
            ToDoHealth('go to sleep', DateTime(1970,1,1, 11, 30))
          ]
        },
        // reflection
        'reflection' : {
          'answer' : SubmitExist(),
        }
      },
      5: {
        // 스케줄
        'schedule': {
          'fixed' : [],
          'unfixed' : [ToDo('meet friends', 0),]
        },
        // 건강
        'health' : {
          'tasks' : [
            ToDoHealth('Vitamin', DateTime(1970,1,1, 8, 30)),

          ]
        },
        // reflection
        'reflection' : {
          'answer' : SubmitExist(),
        }
      },
      6:{
        // 스케줄
        'schedule': {
          'fixed' : [],
          'unfixed' : [ToDo('test', 2), ToDo('birthday party', 2)]
        },
        // 건강
        'health' : {
          'tasks' : [
            ToDoHealth('Vitamin', DateTime(1970,1,1, 8, 7)),
            ToDoHealth('Exercise', DateTime(1970,1,1, 20, 00)),
          ]
        },
        'reflection' : {
          'answer' : SubmitExist(),
        }
      },
      7:{
        // 스케줄
        'schedule': {
          'fixed' : [],
          'unfixed' : [
            ToDo('register for the summer semester', 0),
            ToDo('karrot market', 0), // 오타아님ㅠㅠ 당근마켓 영어이름임
            ToDo('HCI assignment', 2),
            ToDo('lunch with parents', 1)]
        },
        // 건강
        'health' : {
          'tasks' : [
            ToDoHealth('Vitamin', DateTime(1970,1,1, 8, 7)),
            ToDoHealth('dentist', DateTime(1970,1,1, 12, 7)),
            ToDoHealth('go to sleep early', DateTime(1970,1,1, 10, 23))
          ]
        },
        'reflection' : {
          'answer' : SubmitExist(),
        }
      },
      11: {
        'reflection' : {
          'answer' : SubmitExist(),
        }
      }
    }
  };
}