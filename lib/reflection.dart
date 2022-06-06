import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_is_an_egg/global_data.dart' as data;
import 'package:life_is_an_egg/main.dart';
import 'package:provider/provider.dart';

class ReflectionResult extends StatefulWidget {
  const ReflectionResult({Key? key}) : super(key: key);

  @override
  State<ReflectionResult> createState() => _ReflectionResultState();
}

class _ReflectionResultState extends State<ReflectionResult> with WidgetsBindingObserver {
  final FocusNode focusNode1 = new FocusNode();
  final FocusNode focusNode2 = new FocusNode();
  TextEditingController bestPartTextController = TextEditingController();
  TextEditingController promisesTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //focusNode.addListener(focus);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //focusNode.removeListener(focus);
    bestPartTextController.dispose();
    promisesTextController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (!mounted) return;
    if ((focusNode1.hasFocus || focusNode2.hasFocus)&&
        MediaQuery.of(context).viewInsets.bottom > 0.0) {
      textClicked = true;
    }
    else {
      textClicked = false;
    }
  }

  final List _emojiImg = <String>['images/worst.png','images/bad.png', 'images/soso.png', 'images/good.png', 'images/best.png'];
  bool textClicked = false;

  @override
  Widget build(BuildContext context) {
    var selectedDay = context.watch<data.CalendarData>().selectedDay;
    var SubmitExist = context.watch<data.CalendarData>().calendar[selectedDay.month]?[selectedDay.day]?['reflection']?['answer'];
    var fixed = context.watch<data.CalendarData>().calendar[selectedDay.month]?[selectedDay.day]?['schedule']?['fixed'];
    var unfixed = context.watch<data.CalendarData>().calendar[selectedDay.month]?[selectedDay.day]?['schedule']?['unfixed'];
    var tasks = context.watch<data.CalendarData>().calendar[selectedDay.month]?[selectedDay.day]?['health']?['tasks'];

    int inputRateDay = 3;
    String inputBestPart = '';
    String inputPromises = '';
    int fixedNum = 0;

    int rateDay = SubmitExist.rateDay;
    String bestPart = SubmitExist.bestPart;
    String promises = SubmitExist.promises;
    bool yesMemory = SubmitExist.yesMemory;

    for(int i = 0; i < fixed.length; i++) {
      if(fixed[i].isDone == true) fixedNum++;
    }

    for(int i = 0; i < unfixed.length; i++) {
      if(unfixed[i].isDone == true) fixedNum++;
    }

    for(int i = 0; i < tasks.length; i++) {
      if(tasks[i].isDone == true) fixedNum++;
    }

    double rateValue = fixedNum / (fixed.length+unfixed.length+tasks.length) * 83;

    if(yesMemory) {
      return GestureDetector (
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView (
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                const SizedBox(height: 13),
                const Text('How was the day?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 46, 46, 46),
                    fontSize: 25,
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
                    SizedBox(width: 14),
                    Text('Worst',
                        style: TextStyle(
                          color: Color.fromARGB(255, 46, 46, 46),
                        )
                    ),
                    SizedBox(width: 218),
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
                        groupValue: inputRateDay,
                        onChanged: (val) {
                          setState(() {
                            inputRateDay = 1;
                          });
                        }),
                    const SizedBox(width: 15),
                    Radio(
                        value: 2,
                        groupValue: inputRateDay,
                        onChanged: (val) {
                          setState(() {
                            inputRateDay = 2;
                          });
                        }),
                    const SizedBox(width: 15),
                    Radio(
                        value: 3,
                        groupValue: inputRateDay,
                        onChanged: (val) {
                          setState(() {
                            inputRateDay = 3;
                          });
                        }),
                    const SizedBox(width: 15),
                    Radio(
                        value: 4,
                        groupValue: inputRateDay,
                        onChanged: (val) {
                          setState(() {
                            inputRateDay = 4;
                          });
                        }),
                    const SizedBox(width: 15),
                    Radio(
                        value: 5,
                        groupValue: inputRateDay,
                        onChanged: (val) {
                          setState(() {
                            inputRateDay = 5;
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
                  focusNode: focusNode1,
                  controller: bestPartTextController,
                  onChanged: (text) {
                    inputBestPart = bestPartTextController.text;
                  },
                  onTap: () {
                    setState(() {
                      textClicked = true;
                    });
                    scrollController.animateTo(500,
                        duration: const Duration(milliseconds: 500),
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
                  focusNode: focusNode2,
                  controller: promisesTextController,
                  onChanged: (text) {
                    inputPromises = promisesTextController.text;
                  },
                  onTap: () {
                    setState(() {
                      textClicked = true;
                    });
                    scrollController.animateTo(600,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    const SizedBox(width: 238),
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
                                          setState(() {
                                            SubmitExist.yesMemory = false;
                                            SubmitExist.rateDay = inputRateDay;
                                            SubmitExist.bestPart = inputBestPart;
                                            SubmitExist.promises = inputPromises;
                                          });
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
                textClicked == false ? SizedBox() : SizedBox(height: 500)
              ],
            ),
          ));
    } else {
      return Container(
        child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 13),
                  Text(
                    (selectedDay.month == DateTime.now().month && selectedDay.day == DateTime.now().day?
                    "Today's Reflection"
                        :
                    '${DateFormat.MMMd().format(selectedDay)}${selectedDay.day==1? 'st' : selectedDay.day==2? 'nd' : selectedDay.day==3? 'rd' : 'th'} Reflection'
                    ),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 46, 46, 46),
                      fontSize: 25,
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
                      Text('10:12',
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
              )
        )
      );
    }
  }
}