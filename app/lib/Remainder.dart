import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:spryzen/notification.dart';
import 'package:timezone/timezone.dart' as tz;

class Reminder_Page extends StatefulWidget {
  @override
  State<Reminder_Page> createState() => _Reminder_PageState();
}

class _Reminder_PageState extends State<Reminder_Page> {
  Notificationservices notificationservices = Notificationservices();
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    notificationservices.initialiseNotifications();
    tz.initializeTimeZones();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Reminder")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Center(
              child: Form(
                child: Column(
                  children: [
                    Text('Enter the text to be reminded'),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: textcontroller,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(4),
                                right: Radius.circular(4)),
                          ),
                        )),
                    SizedBox(height: 20),
                    Text(" upload the voice"),
                    ElevatedButton(
                        onPressed: () {}, child: Text('Upload voice')),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(11)),
                          child: Center(
                            child: TextField(
                              controller: hourController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              
                              borderRadius: BorderRadius.circular(11)),
                          child: Center(
                            child: TextField(
                              controller: minuteController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        int hours;
                        int minutess;
                        hours = int.parse(hourController.text);
                        minutess = int.parse(minuteController.text);
                        TimeOfDay customTime = TimeOfDay(
                            hour: hours,
                            minute: minutess); // Customize this time
                        notificationservices.schedulenotificationAtTime(
                            'Notification', textcontroller.text, customTime);
                      },
                      child: Text('Schedule reminder'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        notificationservices.stopnotification();
                      },
                      child: Text('Stop notifications'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
