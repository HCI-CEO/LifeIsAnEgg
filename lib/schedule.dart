import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// 요 투두도..
class ToDo {
  bool isDone = false;
  int priority = 0; // 0, 1, 2 (높을 수록 중요)
  String title;
  bool isFixed;
  DateTime doneTime = DateTime(1970, 1, 1, 0, 0, 1);

  ToDo(this.title, this.priority, this.isFixed);
}



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

  // 나중에 이 값들 다 전역으로 어디 한 군데에서 다 관리해야하지 싶은데...
  final _fixedItems = <ToDo>[ToDo('fixed', 0, true), ToDo('fixed1' , 2, true)];
  final _items = <ToDo>[ToDo('test', 0, false), ToDo('test1', 2, false), ToDo('test2', 1, false)];

  String _inputPriority = 'high';
  bool _inputIsFixed = false;



  /**** 할 일 추가 메소드 ****/
  void _addTodo(ToDo todo, List l) {
    setState(() {
      l.add(todo);
      _inputTodoController.text = '';
      _inputPriority = 'high';
      _inputIsFixed = false;
    });
  }

  /**** 할 일 삭제 메소드 ****/
  void _deleteTodo(ToDo todo, List l) {
    setState(() {
      l.remove(todo);
    });
  }

  /**** 할 일 title 수정 메소드 ****/
  void _modifyTodo(ToDo todo){
    setState((){
      todo.title = _inputTodoController.text;
      _inputTodoController.text='';
    });
  }

  /**** 추천기능이 적용된 리스트 정렬 ****/
  List<ToDo> onRecommend(List<ToDo> item){
    List<ToDo> temp;
    temp = [...item];
    temp.sort((a,b)=>b.priority.compareTo(a.priority));
    return temp;
  }



  /**** Todo list item 만들기 ****/
  Widget buildItemWidget(ToDo todo) {
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
                                      if (todo.isFixed)
                                        _deleteTodo(todo, _fixedItems);
                                      else
                                        _deleteTodo(todo, _items);
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
    return Column(
      children: <Widget> [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Schedules...',
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
                                                      var list;

                                                      if(_inputIsFixed) list = _fixedItems;
                                                      else list = _items;

                                                      switch(_inputPriority){
                                                        case 'high': _addTodo(ToDo(_inputTodoController.text, 2, _inputIsFixed), list); break;
                                                        case 'medium': _addTodo(ToDo(_inputTodoController.text, 1, _inputIsFixed), list); break;
                                                        case 'low': _addTodo(ToDo(_inputTodoController.text, 0, _inputIsFixed), list); break;
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
                          )
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
        ...(isCommended ?
        onRecommend(_fixedItems).map((item) => buildItemWidget(item))
            :
        _fixedItems.map((item) => buildItemWidget(item))
        ),
        const Divider(
            color: Color.fromARGB(255, 79, 79, 79),
            thickness: 0.5
        ),
        ...(isCommended ?
        onRecommend(_items).map((item) => buildItemWidget(item))
            :
        _items.map((item) => buildItemWidget(item))
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