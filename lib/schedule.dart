import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_is_an_egg/global_data.dart' as data;
import 'package:provider/provider.dart';


class ScheduleList extends StatefulWidget {
  const ScheduleList({Key? key}) : super(key: key);

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  final _priorityList = <String>['high','medium','low'];
  bool isCommended = false;
  final _focusNode = FocusNode();//포커스 노드
  final _inputTodoController = TextEditingController();

  String _inputPriority = 'high';
  bool _inputIsFixed = false;


  /**** 할 일 추가 메소드 ****/
  void _addTodo(data.ToDo todo, List l) {
    setState(() {
      l.add(todo);
      _inputTodoController.text = '';
      _inputPriority = 'high';
      _inputIsFixed = false;
    });
  }

  /**** 할 일 삭제 메소드 ****/
  void _deleteTodo(data.ToDo todo, List l) {
    setState(() {
      l.remove(todo);
    });
  }

  /**** 할 일 title 수정 메소드 ****/
  void _modifyTodo(data.ToDo todo){
    setState((){
      todo.title = _inputTodoController.text;
      _inputTodoController.text='';
    });
  }

  /**** 추천기능이 적용된 리스트 정렬 ****/
  List<data.ToDo> onRecommend(List<dynamic> item){
    List<data.ToDo> temp;
    temp = [...item];
    temp.sort((a,b)=>b.priority.compareTo(a.priority));
    return temp;
  }

  /**** Todo list item 만들기 ****/
  Widget buildItemWidget(data.ToDo todo, List<dynamic> list) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 4,10,4),
        child :
        GestureDetector(
          onTap: (){
            setState(() {
              todo.isDone = !todo.isDone;
              todo.doneTime = DateTime.now();
            });
          },
          child: GestureDetector(
              onLongPress: () {
                if(!todo.isDone) {
                  showDialog(
                    context: context,
                    barrierDismissible: true, // 바깥쪽 터치시 닫을지 말지
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                      primary: const Color.fromARGB(255, 46, 46, 46),
                                    ),
                                    onPressed: () {
                                      _inputTodoController.text = todo.title;
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        // 바깥쪽 터치시 닫을지 말지
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context, StateSetter setState) {
                                              return AlertDialog(
                                                content: TextField(
                                                  controller: _inputTodoController,
                                                ),
                                                actions: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        _modifyTodo(todo);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                          mainAxisAlignment:MainAxisAlignment.center,
                                                          children: [
                                                            Transform.translate(
                                                              offset: const Offset(0, -10),
                                                              child: Container(
                                                                width: 240,
                                                                decoration: const BoxDecoration(
                                                                  color: Color.fromARGB(255, 255, 246, 222),
                                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                ),
                                                                child: const Padding(
                                                                  padding: EdgeInsets.all(10),
                                                                  child: Text(
                                                                      'modify',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        color: Color.fromARGB(255, 46, 46, 46),
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ]
                                                      )
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: const Padding(
                                        padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                                        child: Text('modify'))),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      _deleteTodo(todo, list);
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                        padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                                        child: Text('delete')
                                    )
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
              child : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 46, 46, 46),
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Transform.translate(
                          offset: const Offset(1, -3),
                          child: Transform.scale(
                            scale: 1.7,
                            child:Checkbox(
                              splashRadius: 0,
                              checkColor: Colors.lightGreen,
                              fillColor: MaterialStateProperty.all(Colors.transparent),
                              value: todo.isDone,
                              onChanged: (value) {
                                setState(() {
                                  todo.doneTime = DateTime.now();
                                  todo.isDone = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: 220,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0 ),
                            child:Text(
                              todo.title,
                              softWrap: true,
                              style: todo.isDone?
                              const TextStyle(
                                color: Color.fromARGB(255, 46, 46, 46),
                                decoration: TextDecoration.lineThrough,
                              ) : const TextStyle(
                                color: Color.fromARGB(255, 46, 46, 46),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  Text( todo.isDone?
                        (todo.doneTime.hour == 0? DateFormat('00:mm a').format(todo.doneTime) : DateFormat('kk:mm a').format(todo.doneTime))
                      :
                        ' '
                  )
                ],
              )
          ),
        )
    );
  }

  @override
  void dispose() {
    _inputTodoController.dispose(); // 컨트롤러는 종료시 반드시 해제해줘야 함
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedDay = context.watch<data.CalendarData>().selectedDay;

    var fixedItems = context.watch<data.CalendarData>().calendar[selectedDay.month]?[selectedDay.day]?['schedule']?['fixed'];
    var items = context.watch<data.CalendarData>().calendar[selectedDay.month]?[selectedDay.day]?['schedule']?['unfixed'];

    var calendarAll = context.watch<data.CalendarData>().calendar;

    return Column(
      children: <Widget> [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (selectedDay.month == DateTime.now().month && selectedDay.day == DateTime.now().day?
                    'Today\'s Schedules...'
                  :
                      '${DateFormat.MMMd().format(selectedDay)}${selectedDay.day==1? 'st' : selectedDay.day==2? 'nd' : selectedDay.day==3? 'rd' : 'th'} Schedules...'
                  ),
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 46, 46)),
                ),
                Transform.translate(
                  offset: const Offset(10, 10),
                  child:Container(
                    width: 35,
                    height: 35,
                    child: Transform.translate(
                      offset: const Offset(-10, -10),
                      child:
                      TextButton(
                        onPressed: () {
                          /**** popup stateful 속성을 가질 수 있도록 ****/
                          showDialog(
                            context: context,
                            barrierDismissible: false,  // 바깥쪽 터치시 닫을지 말지
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    /****** 할일 추가 popup ******/
                                    return GestureDetector(
                                        onTap: (){
                                          _focusNode.unfocus();
                                        },
                                        child: AlertDialog(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _inputTodoController.text = '';
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('X'),
                                              ),
                                              const Text("ADD ITEM" ,
                                                  style: TextStyle(
                                                    color: Color.fromARGB(255, 46, 46, 46),
                                                  )),
                                              Container(width: 10,)
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:250,
                                                child: TextField(
                                                    focusNode: _focusNode,
                                                    autofocus: true,
                                                    controller: _inputTodoController,
                                                    decoration: const InputDecoration(
                                                      labelText: 'title',
                                                      hintText: 'Enter your task',
                                                      labelStyle: TextStyle(color: Color.fromARGB(255, 106, 93, 60)),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 106, 93, 60)),
                                                      ),
                                                      contentPadding:EdgeInsets.symmetric(vertical: -10.0, horizontal: 15.0),
                                                    )
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('priority', style: TextStyle(color: Color.fromARGB(255, 46, 46, 46))),
                                                  DropdownButton(
                                                    value: _inputPriority,
                                                    items: _priorityList.map(
                                                          (priority) {
                                                        return DropdownMenuItem (
                                                          value: priority,
                                                          child: Text(priority),
                                                        );
                                                      },
                                                    ).toList(),
                                                    onChanged: (priority) {
                                                      setState(() {
                                                        _inputPriority = priority.toString();
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text('fixed', style: TextStyle(color: Color.fromARGB(255, 46, 46, 46))),
                                                  Checkbox(
                                                      fillColor: MaterialStateProperty.all(Colors.lightGreen),
                                                      value: _inputIsFixed,
                                                      onChanged: (value){
                                                        setState((){_inputIsFixed=value!;});
                                                      }
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      if(_inputTodoController.text!=''){
                                                        var temp;

                                                        if(_inputIsFixed) temp = 'fixed';
                                                        else temp = 'unfixed';

                                                        if(calendarAll[selectedDay.month] == null){
                                                          calendarAll[selectedDay.month]={};
                                                        }

                                                        if(calendarAll[selectedDay.month]?[selectedDay.day] == null){
                                                          calendarAll[selectedDay.month]?[selectedDay.day]={};
                                                        }

                                                        if(calendarAll[selectedDay.month]?[selectedDay.day]?['schedule'] == null) {
                                                          calendarAll[selectedDay.month]?[selectedDay.day]?['schedule'] = {};
                                                          calendarAll[selectedDay.month]?[selectedDay.day]?['schedule']?[temp] = [];
                                                        }

                                                        var list = calendarAll[selectedDay.month]?[selectedDay.day]?['schedule']?[temp];

                                                        switch(_inputPriority){
                                                          case 'high': _addTodo(data.ToDo(_inputTodoController.text, 2), list); break;
                                                          case 'medium': _addTodo(data.ToDo(_inputTodoController.text, 1), list); break;
                                                          case 'low': _addTodo(data.ToDo(_inputTodoController.text, 0), list); break;
                                                        }
                                                        Navigator.pop(context);
                                                      }
                                                      else {
                                                        _focusNode.requestFocus();
                                                      }
                                                    },
                                                    child: Transform.translate(offset: const Offset(0, -20),
                                                      child: Container(
                                                        width: 240,
                                                        decoration: const BoxDecoration(
                                                          color: Color.fromARGB(255, 255, 246, 222),
                                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        ),
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(12),
                                                          child: Text(
                                                              'add',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Color.fromARGB(255, 46, 46, 46),
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                    );
                                  }
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 234, 178),
                          primary: const Color.fromARGB(255, 106, 93, 60),
                          padding: const EdgeInsets.all(0),
                        ),
                        child: const Text('+', style: TextStyle(fontSize: 30)),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Padding(padding : const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            children: const [Text('fixed',style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 46, 46)))],
          ),
        ),
        ...(fixedItems==null? [] : isCommended ?
        onRecommend(fixedItems).map((item) => buildItemWidget(item, fixedItems))
            :
        fixedItems.map((item) => buildItemWidget(item, fixedItems))
        ),
        const Divider(
            color: Color.fromARGB(255, 79, 79, 79),
            thickness: 0.5
        ),

        ...(items==null? [] : isCommended ?
        onRecommend(items).map((item) => buildItemWidget(item, items))
            :
        items.map((item) => buildItemWidget(item, items))
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Column(
            children: <Widget>[
              Transform.scale(
                scale: 1.2,
                child: Switch(
                  activeColor: const Color.fromARGB(255, 177, 166, 139),
                  inactiveTrackColor: const Color.fromARGB(255, 244, 233, 200),
                  value: isCommended,
                  onChanged: (value) {
                    setState(() {
                      isCommended = value;
                    });
                  },
                ),
              ),
              Transform.translate(offset: const Offset(0, -8),
                  child: const Text(
                      'recommended',
                      style: TextStyle(
                        color: Color.fromARGB(255, 177, 166, 139),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      )
                  )
              ),
            ],
          ),
        )
      ],
    );
  }
}