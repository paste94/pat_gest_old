import 'package:flutter/material.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/views/visits/visits_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class VisitsView extends StatefulWidget {
  const VisitsView({super.key});

  @override
  State<VisitsView> createState() => _VisitsViewState();
}

class _VisitsViewState extends State<VisitsView> {
  //TODO: Cambia questo con un default selezionabile dalle opzioni
  var _calendarView = CalendarView.month;
  final _firstDayOfWeek = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        firstDayOfWeek: _firstDayOfWeek,
        showNavigationArrow: true,
        allowedViews: CalendarView.values,
        view: _calendarView,
        dataSource: VisitDataSource(_getDataSource()),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
    );
  }

  List<Visit> _getDataSource() {
    final List<Visit> visits = <Visit>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    visits.add(Visit(
      eventName: 'eventName',
      isAllDay: false,
      id: 1,
      patientId: 1,
      from: today,
      to: endTime,
      background: Colors.blue,
    ));
    return visits;
  }
}

class VisitDataSource extends CalendarDataSource {
  VisitDataSource(List<Visit> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
