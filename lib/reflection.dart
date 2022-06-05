import 'package:flutter/material.dart';

class Reflection extends StatefulWidget {
  const Reflection({Key? key}) : super(key: key);

  @override
  State<Reflection> createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection> {
  int rateDay = 3;

  TextEditingController BestPartTextController = TextEditingController();
  TextEditingController PromisesTextController = TextEditingController();

  @override
  void dispose(){
    BestPartTextController.dispose();
    PromisesTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text('How was the day?',
          style: TextStyle(
            color: Color.fromARGB(255, 46, 46, 46),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 35,),
          Text('1. Rate Your Day',
            style: TextStyle(
              color: Color.fromARGB(255, 46, 46, 46),
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              SizedBox(width: 18),
              Text('Worst',
                  style: TextStyle(
                    color: Color.fromARGB(255, 46, 46, 46),
                  )
              ),
              SizedBox(width: 220),
              Text('Best',
                  style: TextStyle(
                    color: Color.fromARGB(255, 46, 46, 46),
                  )
              ),
            ],//다시 수정
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Radio(
                  value: 1,
                  groupValue: rateDay,
                  onChanged: (val) {
                    setState(() {
                      rateDay = 1;
                    });
                  }),
              SizedBox(width: 15),
              Radio(
                  value: 2,
                  groupValue: rateDay,
                  onChanged: (val) {
                    setState(() {
                      rateDay = 2;
                    });
                  }),
              SizedBox(width: 15),
              Radio(
                  value: 3,
                  groupValue: rateDay,
                  onChanged: (val) {
                    setState(() {
                      rateDay = 3;
                    });
                  }),
              SizedBox(width: 15),
              Radio(
                  value: 4,
                  groupValue: rateDay,
                  onChanged: (val) {
                    setState(() {
                      rateDay = 4;
                    });
                  }),
              SizedBox(width: 15),
              Radio(
                  value: 5,
                  groupValue: rateDay,
                  onChanged: (val) {
                    setState(() {
                      rateDay = 5;
                    });
                  }),
            ],
          ),
          SizedBox(height: 30),
          Text('2. What was the best part of your day?',
            style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.w500
              ),
          ),
          TextField(
            controller: BestPartTextController,
          ),
          SizedBox(height: 45),
          Text('3. Promises for tomorrow',
            style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.w500
            ),
          ),
          TextField(
            controller: PromisesTextController,
          ),
          SizedBox(height: 50),
          Row(
            children: [
              SizedBox(width: 248),
              OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Reflection Result'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget> [
                                Text('Once submitted, you cannot edit the answers again.',
                                    style: TextStyle (
                                        color: Color.fromARGB(255, 46, 46, 46)
                                    )),
                                Text('Are you sure you want to submit?',
                                    style: TextStyle (
                                        color: Color.fromARGB(255, 46, 46, 46)
                                    ))
                              ],
                            ),
                          ),
                          actions: <Widget> [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('NO',
                                style: TextStyle (
                                  color: Color.fromARGB(255, 46, 46, 46)
                                ),)
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'YES');
                                },
                                child: Text('YES',
                                style: TextStyle (
                                  color: Colors.blue[400],
                                ),)
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: Text('Submit',
                      style: TextStyle(
                        color: Color.fromARGB(255, 46, 46, 46),
                      )
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ReflectionResult extends StatelessWidget {
  ReflectionResult({Key? key}) : super(key: key);

  int rateDay = 2; // 데베에서 가져오기

  List _emojiImg = <String>['images/worst.png','images/bad.png', 'images/soso.png', 'images/good.png', 'images/best.png'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Today was...',
              style: TextStyle (
                color: Color.fromARGB(255, 46, 46, 46),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_emojiImg[rateDay], width: 80),
              ],
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text('Time Table',
                          style: TextStyle (
                            color: Color.fromARGB(255, 46, 46, 46),
                            fontWeight: FontWeight.w500,
                          ),),
                        SizedBox(height: 10),
                        Image.asset('images/time_table.png', width: 83)
                      ],
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text('Achievement Rate',
                            style: TextStyle (
                              color: Color.fromARGB(255, 46, 46, 46),
                              fontWeight: FontWeight.w500,
                            ),),
                          SizedBox(height: 10),
                        ],
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Row(
              children: [
                Text('✔  ️You woke up at...                   ',
                    style: TextStyle (
                        color: Color.fromARGB(255, 46, 46, 46),
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                    )
                ),
                Text('08:12',
                    style: TextStyle (
                        color: Color.fromARGB(255, 46, 46, 46),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                    )
                ),
              ],
            ),
            SizedBox(height: 23),
            Text('✔  ️Your best part of the day was...',
                style: TextStyle (
                    color: Color.fromARGB(255, 46, 46, 46),
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                )),
            SizedBox(height: 10),
            Container(
                width: 330,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Color.fromARGB(255, 255, 230, 161),
                        width: 2
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.5),
                  child: Text('happyhappy',
                      style: TextStyle (
                        color: Color.fromARGB(255, 46, 46, 46),
                      )),
                )
            ),
            SizedBox(height: 18),
            Text('✔  ️Promises for tomorrow are...',
                style: TextStyle (
                    color: Color.fromARGB(255, 46, 46, 46),
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                )),
            SizedBox(height: 10),
            Container(
                width: 330,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Color.fromARGB(255, 255, 230, 161),
                        width: 2
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.5),
                  child: Text('happyhappy',
                      style: TextStyle (
                          color: Color.fromARGB(255, 46, 46, 46),
                      )),
                )
            ),
            SizedBox(height: 7)
          ],
        )
    );
  }
}
