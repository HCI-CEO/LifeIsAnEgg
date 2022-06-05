import 'package:flutter/material.dart';
import 'package:life_is_an_egg/health.dart';
import 'package:life_is_an_egg/reflection.dart';
import 'package:life_is_an_egg/schedule.dart';

class FileBox extends StatefulWidget {
  const FileBox({Key? key}) : super(key: key);

  @override
  State<FileBox> createState() => _FileBoxState();
}

class _FileBoxState extends State<FileBox> {
  List _navPageImg = <String>['images/nav_on.png','images/nav_off.png', 'images/nav_off.png'];
  int curPage = 0;

  void navigate(int p){
    setState(() {
      List _temp = [..._navPageImg];
      for(int i=0;i<3;i++){
        if(i==p) {
          _temp[i] = 'images/nav_on.png';
          curPage = i;
        }
        else {
          _temp[i] = 'images/nav_off.png';
        }
      }
      _navPageImg = _temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Transform.translate(offset: const Offset(0, 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap: (){
                    navigate(0);
                  },
                  child:  Stack(
                      children: [
                        Image.asset(_navPageImg[0], width: 122),
                        Padding(padding: EdgeInsets.fromLTRB(33, 8, 10, 6),
                            child: Text('schedule')),
                      ]
                  )
              ),
              GestureDetector(
                  onTap: (){
                    navigate(1);
                  },
                  child:  Stack(
                      children: [
                        Image.asset(_navPageImg[1], width: 122),
                        Padding(padding: EdgeInsets.fromLTRB(43, 8, 10, 6),
                            child: Text('health')),
                      ]
                  )
              ),
              GestureDetector(
                  onTap: (){
                    navigate(2);
                  },
                  child:  Stack(
                      children: [
                        Image.asset(_navPageImg[2], width: 122),
                        Padding(padding: EdgeInsets.fromLTRB(33, 8, 10, 6),
                            child: Text('reflection')),
                      ]
                  )
              ),
            ],
          ),
        ),
        Container(
          width: 355,
          color: Color.fromARGB(255, 255, 246, 222),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child:(
                curPage==0?
                ScheduleList() :(
                    curPage==1?
                    HealthList()  : (
                        curPage==2?
                            ReflectionResult()
                            :null
                    )
                )
            ),
          ),
        ),
      ],
    );
  }
}