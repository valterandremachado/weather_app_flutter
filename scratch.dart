// import 'dart:io';

void main() {
  performTask();
}

void performTask() async {
  task1();
  String task2Result = await task2();
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print('task 1 completed');
}

Future task2() async {
  Duration duration = Duration(seconds: 3);
  // sleep(duration);
  String result = 'null';
  Future.delayed(duration, () {
    result = 'task 2 data';
    print('task 2 completed');
  });

  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('task 3 completed... $task2Data');
}
