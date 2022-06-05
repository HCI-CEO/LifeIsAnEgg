import 'package:flutter/material.dart';

class Reflection extends StatefulWidget {
  const Reflection({Key? key}) : super(key: key);

  @override
  State<Reflection> createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection> {
  int rateDay = 3;

  String bestPart ='';
  String promises = '';

  ScrollController scrollController = ScrollController();
  TextEditingController bestPartTextController = TextEditingController();
  TextEditingController promisesTextController = TextEditingController();

  @override
  void dispose(){
    bestPartTextController.dispose();
    promisesTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: SingleChildScrollView (
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            const SizedBox(height: 8),
            const Text('How was the day?',
            style: TextStyle(
              color: Color.fromARGB(255, 46, 46, 46),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 35,),
            const Text('1. Rate Your Day',
              style: TextStyle(
                color: Color.fromARGB(255, 46, 46, 46),
                fontWeight: FontWeight.w500
              )
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget> [
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
                const SizedBox(width: 15),
                Radio(
                    value: 2,
                    groupValue: rateDay,
                    onChanged: (val) {
                      setState(() {
                        rateDay = 2;
                      });
                    }),
                const SizedBox(width: 15),
                Radio(
                    value: 3,
                    groupValue: rateDay,
                    onChanged: (val) {
                      setState(() {
                        rateDay = 3;
                      });
                    }),
                const SizedBox(width: 15),
                Radio(
                    value: 4,
                    groupValue: rateDay,
                    onChanged: (val) {
                      setState(() {
                        rateDay = 4;
                      });
                    }),
                const SizedBox(width: 15),
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
            const SizedBox(height: 30),
            const Text('2. What was the best part of your day?',
              style: TextStyle(
                  color: Color.fromARGB(255, 46, 46, 46),
                  fontWeight: FontWeight.w500
                ),
            ),
            TextField(
              controller: bestPartTextController,
              onChanged: (text) {
                bestPart = bestPartTextController.text;
              },
              onTap: () {
                scrollController.animateTo(140.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
            const SizedBox(height: 45),
            const Text('3. Promises for tomorrow',
              style: TextStyle(
                  color: Color.fromARGB(255, 46, 46, 46),
                  fontWeight: FontWeight.w500
              ),
            ),
            TextField(
              controller: promisesTextController,
              onChanged: (text) {
                promises = promisesTextController.text;
              },
              onTap: () {
                scrollController.animateTo(140.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                const SizedBox(width: 248),
                OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Reflection Result'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget> [
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
                                  child: const Text('NO',
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
                    child: const Text('Submit',
                        style: TextStyle(
                          color: Color.fromARGB(255, 46, 46, 46),
                        )
                    )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReflectionResult extends StatefulWidget {
  const ReflectionResult({Key? key}) : super(key: key);

  @override
  State<ReflectionResult> createState() => _ReflectionResultState();
}

class _ReflectionResultState extends State<ReflectionResult> {
  final List _emojiImg = <String>['images/worst.png','images/bad.png', 'images/soso.png', 'images/good.png', 'images/best.png'];

  @override
  Widget build(BuildContext context) {
    // 데베에서 가져오기
    int rateDay = 3;
    double rateValue = 43.0;
    String bestPart = '';
    String promises = '';
    bool yesMemory = true;

    if(yesMemory) {
      return Reflection();
    } else {
      return Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    "Today's Reflection",
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 46, 46),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_emojiImg[rateDay], width: 80),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                const Text(
                                  'Time Table',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 46, 46, 46),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Image.asset('images/time_table.png', width: 83)
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Column(children: [
                              const Text(
                                'Achievement Rate',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 46, 46, 46),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 83,
                                          decoration: BoxDecoration(
                                            color: const Color(0xd8FFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        Container(
                                          width: 30,
                                          height: rateValue,
                                          decoration: BoxDecoration(
                                            color: const Color(0xd88DBC65),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ]),
                                  const SizedBox(width: 12),
                                  Text(rateValue.toInt().toString() + '%',
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 46, 46, 46),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18)),
                                ],
                              )
                            ])),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Row(
                    children: const [
                      Text('✔  ️You woke up at...                   ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 46, 46, 46),
                              fontWeight: FontWeight.w500,
                              fontSize: 15)),
                      Text('08:12',
                          style: TextStyle(
                            color: Color.fromARGB(255, 46, 46, 46),
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  const SizedBox(height: 23),
                  const Text('✔  ️Your best part of the day was...',
                      style: TextStyle(
                          color: Color.fromARGB(255, 46, 46, 46),
                          fontWeight: FontWeight.w500,
                          fontSize: 15)),
                  const SizedBox(height: 10),
                  Container(
                      width: 330,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 230, 161),
                              width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.5),
                        child: Text(bestPart,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 46, 46, 46),
                            )),
                      )),
                  const SizedBox(height: 18),
                  const Text('✔  ️Promises for tomorrow are...',
                      style: TextStyle(
                          color: Color.fromARGB(255, 46, 46, 46),
                          fontWeight: FontWeight.w500,
                          fontSize: 15)),
                  const SizedBox(height: 10),
                  Container(
                      width: 330,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 230, 161),
                              width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.5),
                        child: Text(promises,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 46, 46, 46),
                            )),
                      )),
                  const SizedBox(height: 7)
                ],
              )));
    }
  }
}
