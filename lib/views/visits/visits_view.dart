import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/views/visits/visits_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class VisitsView extends StatefulWidget {
  const VisitsView({super.key});

  @override
  State<VisitsView> createState() => _VisitsViewState();
}

class _VisitsViewState extends State<VisitsView> {
  //TODO: Cambia questo con un default selezionabile dalle opzioni
  final _calendarView = CalendarView.month;
  final _firstDayOfWeek = 1;
  final _calendarController = CalendarController();
  VisitsDataSource? _events = VisitsDataSource(<Visit>[]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Calendar'),
        leading: _calendarController.view == CalendarView.day
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() {
                  _calendarController.view = CalendarView.month;
                }),
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
                enableFeedback: false,
                onPressed: null,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addVisitTag',
        onPressed: () {
          Navigator.of(context).pushNamed(addVisitRoute);
        },
        child: const Icon(Icons.add),
      ),
      body: SfCalendar(
        firstDayOfWeek: _firstDayOfWeek,
        showNavigationArrow: true,
        view: _calendarView,
        controller: _calendarController,
        showDatePickerButton: true,
        allowViewNavigation: true,
        onLongPress: (CalendarLongPressDetails calendarLongPressDetails) {},
        onTap: (CalendarTapDetails calendarTapDetails) async {
          print(_calendarController);
          if (_calendarController.selectedDate?.hour != 0) {
            // TODO: Aggiungi la view add
          }
          setState(() {});
        },
        dataSource: _getCalendarDataSource(),
        // allowDragAndDrop: true,
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
      ),
    );
  }

  VisitsDataSource _getCalendarDataSource() {
    List<Visit> appointments = <Visit>[];
    appointments.add(Visit(
      id: 1,
      eventName: 'CIAOOOO',
      patientId: 1,
      isAllDay: false,
      from: DateTime.now(),
      to: DateTime.now().add(
        const Duration(hours: 2),
      ),
      background: Colors.blue,
      isCanceled: false,
      isDone: false,
      isInitial: false,
    ));

    return VisitsDataSource(appointments);
  }
}
