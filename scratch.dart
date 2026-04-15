import 'dart:io';

void main() {
  performTask();
}

void performTask() async {
  task1();
  print(task2());
  // task3(task2Data);
}

void task1() {
  String restult = 'Task 1 data';

  print('Task 1 completed');
}

Future<String> task2() async {
  Duration threeSeconds = Duration(seconds: 3);

  // sleep(threeSeconds);
  String? result;
  await Future.delayed(threeSeconds, () {
    result = 'Task 2 data';

    print('Task 2 completed');
  });

  return result!;
}

void task3(String task2Data) {
  String restult = 'Task 3 data';

  print("Task 3 completed $task2Data");
}
