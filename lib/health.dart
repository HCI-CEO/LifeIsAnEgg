import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


// 요 투두도..
class ToDoHealth {
  bool isDone = false;
  String title;
  DateTime doingTime;

  ToDoHealth(this.title, this.doingTime);
}



class HealthList extends StatefulWidget {
  const HealthList({Key? key}) : super(key: key);

  @override
  State<HealthList> createState() => _HealthListState();
}

class _HealthListState extends State<HealthList> {
  final _focusNode = FocusNode();//포커스 노드
  final _inputTodoController = TextEditingController();

  // 나중에 이 값들 다 전역으로 어디 한 군데에서 다 관리해야하지 싶은데...
  final _healthItems = <ToDoHealth>[
    ToDoHealth('Vitamin', DateTime(1970,1,1, 8, 7)),
    ToDoHealth('dentist', DateTime(1970,1,1, 12, 7)),
    ToDoHealth('go to sleep', DateTime(1970,1,1, 12, 23)),
  ];



  bool _inputIsFixed = false;
  final _selectedDays = <DateTime>[];
  DateTime _selectedTime = DateTime(1970,1,1, 0, 0,1);
  DateTime _focusedDay = DateTime.now();



  /**** 할 일 추가 메소드 ****/
  void _addTodo(ToDoHealth todoHealth) {
    setState(() {
      _healthItems.add(todoHealth);
      _inputTodoController.text = '';

      // _selectedDays.clear();
      _inputIsFixed = false;
      _healthItems.sort((a, b) => a.doingTime.compareTo(b.doingTime));
    });
  }

  /**** 할 일 삭제 메소드 ****/
  void _deleteTodo(ToDoHealth todoHealth) {
    setState(() {
      _healthItems.remove(todoHealth);
    });
  }

  /**** 할 일 title 수정 메소드 ****/
  void _modifyTodo(ToDoHealth todoHealth){
    setState((){
      todoHealth.title = _inputTodoController.text;
      _inputTodoController.text='';
    });
  }

  /**** Todo list item 만들기 ****/
  Widget buildItemWidget(ToDoHealth todoHealth) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 4,10,4),
        child :
        GestureDetector(
          onTap: (){
            setState(() {
              todoHealth.isDone = !todoHealth.isDone;
            });
          },
          child: GestureDetector(
              onLongPress: () {
                if(!todoHealth.isDone) {
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
                                      _inputTodoController.text = todoHealth.title;
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
                                                        _modifyTodo(todoHealth);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                        padding: EdgeInsets.fromLTRB(
                                            80, 10, 80, 10),
                                        child: Text('modify')
                                    )
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      _deleteTodo(todoHealth);
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
                children: <Widget>[
                  Row(
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
                              value: todoHealth.isDone,
                              onChanged: (value) {
                                setState(() {
                                  todoHealth.isDone = value!;
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
                              todoHealth.title,
                              softWrap: true,
                              style: todoHealth.isDone?
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
                  Text(
                    todoHealth.doingTime.hour == 0? DateFormat('00:mm a').format(todoHealth.doingTime) : DateFormat('kk:mm a').format(todoHealth.doingTime),
                    style: todoHealth.isDone?
                    const TextStyle(
                      color: Color.fromARGB(255, 46, 46, 46),
                      decoration: TextDecoration.lineThrough,
                    ) : const TextStyle(
                      color: Color.fromARGB(255, 46, 46, 46),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

  // 선택된 날짜 표시
  Widget _buildEventsMarkerNum(DateTime day) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xFFFFF0C2),
      ),
      child: Center(
        child: Text(
          day.day.toString(),
          style: const TextStyle().copyWith(
            color: const Color(0xff2d2d2d),
          ),
        ),
      ),
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
    return Column(
      children: <Widget> [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\' Health...',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 46, 46)),
                ),
                Transform.translate(
                  offset: const Offset(10, 10),
                  child:Container(
                    width: 35,
                    height: 35,
                    child: Transform.translate(
                      offset: const Offset(-10, -10),
                      child: TextButton(
                          child: const Text('+', style: TextStyle(fontSize: 30)),
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
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _inputTodoController.text = '';
                                                  _selectedTime=DateTime(1970,1,1, 0, 0,1);
                                                  _selectedDays.clear();
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
                                          content: SingleChildScrollView(
                                              child: Column(
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
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: const [Text('Date', style: TextStyle(height:2),)]
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                        border: Border.all(
                                                            color:const Color(0xFFF6DE99)
                                                        ),
                                                      ),
                                                      child:SizedBox(
                                                          width: 250,
                                                          height: 245,
                                                          child: TableCalendar(
                                                            rowHeight: 30,
                                                            focusedDay: _focusedDay,
                                                            firstDay: DateTime(2020),
                                                            lastDay: DateTime(2030),
                                                            headerStyle: const HeaderStyle(
                                                              headerMargin: EdgeInsets.only(left:0, top:0, right:0, bottom:0),
                                                              headerPadding: EdgeInsets.symmetric(vertical: 0),
                                                              titleCentered: true,
                                                              formatButtonVisible: false,
                                                              titleTextStyle: TextStyle(fontSize:15.0),
                                                            ),
                                                            calendarStyle: const CalendarStyle(
                                                              cellMargin: EdgeInsets.all(0),
                                                              cellPadding: EdgeInsets.all(0),
                                                              todayDecoration: BoxDecoration(
                                                                  color: Color.fromARGB(
                                                                      153, 255,
                                                                      246, 222),
                                                                  borderRadius: BorderRadius.all(Radius.circular(300))
                                                              ),
                                                              todayTextStyle: TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                            calendarBuilders: CalendarBuilders(
                                                                markerBuilder: (context, date, events) {
                                                                  if (_selectedDays.contains(date)) {
                                                                    return _buildEventsMarkerNum(date);
                                                                  }
                                                                }
                                                            ),
                                                            daysOfWeekStyle: const DaysOfWeekStyle(
                                                              weekdayStyle: TextStyle(fontSize:10),
                                                              weekendStyle: TextStyle(fontSize:10),
                                                            ),
                                                            onDaySelected: (selectedDay, _){
                                                              setState((){
                                                                _focusedDay = selectedDay;
                                                                if(_selectedDays.contains(selectedDay)){
                                                                  _selectedDays.remove(selectedDay);
                                                                }
                                                                else {
                                                                  _selectedDays.add(selectedDay);
                                                                }
                                                              });
                                                            },
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text('Time'),
                                                      TextButton(
                                                        onPressed: () {
                                                          Future selected = showTimePicker(
                                                            context: context,
                                                            initialTime: TimeOfDay.now(),
                                                            initialEntryMode: TimePickerEntryMode.input,
                                                          );
                                                          selected.then((time) { // dateTime은 사용자가 선택한 값
                                                            setState(() {
                                                              _selectedTime = DateTime(1970, 1, 1, time.hour, time.minute);
                                                            });
                                                          });
                                                        },
                                                        style: TextButton.styleFrom(
                                                          primary: Colors.lightGreen,
                                                        ),
                                                        child: Text(_selectedTime.hour == 0? DateFormat('00:mm').format(_selectedTime) :DateFormat('kk:mm').format(_selectedTime)),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      if(_inputTodoController.text!=''){

                                                        _addTodo(ToDoHealth(_inputTodoController.text, _selectedTime));
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
                                  },
                                );
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 234, 178),
                            primary: const Color.fromARGB(255, 106, 93, 60),
                            padding: const EdgeInsets.all(0),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            )),
        ...(_healthItems.map((item) => buildItemWidget(item))),
        Container(
          height: 20,
        ),
      ],
    );
  }
}