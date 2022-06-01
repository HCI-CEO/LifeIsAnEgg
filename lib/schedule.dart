import 'package:flutter/material.dart';


// 요 투두도..
class ToDo {
  bool isDone = false;
  int priority = 0; // 0, 1, 2 (높을 수록 중요)
  String title;
  bool isFixed;

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

  // 나중에 이 값들 다 전역으로 어디 한 군데에서 다 관리해야하지 싶은데...
  final _fixedItems = <ToDo>[ToDo('fixed', 0, true), ToDo('fixed1' , 2, true)];
  final _items = <ToDo>[ToDo('test', 0, false), ToDo('test1', 2, false), ToDo('test2', 1, false)];

  final _inputTodoController = TextEditingController();
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
              });
            },
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,  // 바깥쪽 터치시 닫을지 말지
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
                                  onPressed: (){
                                    _inputTodoController.text = todo.title;
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,  // 바깥쪽 터치시 닫을지 말지
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
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children:[
                                                      Transform.translate(offset: const Offset(0, -3),
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
                                      child:Text('modify')
                                  )
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.redAccent,
                                  ),
                                  onPressed: (){
                                    if(todo.isFixed) _deleteTodo(todo, _fixedItems);
                                    else _deleteTodo(todo, _items);
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                      padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                                      child:Text('delete')
                                  )
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child : Row(
                children: <Widget>[
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 46, 46, 46),
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
                              todo.isDone = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(13, 0, 13, 0 ),
                    child:Text(
                      todo.title,
                      style: todo.isDone?
                      const TextStyle(
                        color: Color.fromARGB(255, 46, 46, 46),
                        decoration: TextDecoration.lineThrough,
                      ) : const TextStyle(
                        color: Color.fromARGB(255, 46, 46, 46),
                      ),
                    ),
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
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TODAY...',
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
                          child: Text('+', style: TextStyle(fontSize: 30)),
                          onPressed: () {
                            /**** popup stateful 속성을 가질 수 있도록 ****/
                            showDialog(
                              context: context,
                              barrierDismissible: false,  // 바깥쪽 터치시 닫을지 말지
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    /****** 할일 추가 popup ******/
                                    return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Text('X'),
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
                                          TextField(
                                            controller: _inputTodoController,
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
                                              Text('fixed', style: TextStyle(color: Color.fromARGB(255, 46, 46, 46))),
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
                                                  print('다시 입력해주시게');
                                                }
                                              },
                                              child: Transform.translate(offset: const Offset(0, -8),
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
                                    );
                                  },
                                );
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 234, 178),
                            primary: Color.fromARGB(255, 106, 93, 60),
                            padding: EdgeInsets.all(0),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Padding(padding : EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            children: [Text('fixed',style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 46, 46)))],
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
                  activeColor: Color.fromARGB(255, 177, 166, 139),
                  inactiveTrackColor: Color.fromARGB(255, 244, 233, 200),
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