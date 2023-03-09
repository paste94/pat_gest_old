import 'package:pat_gest/db/drift_database.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class VisitsDataSource extends CalendarDataSource {
  VisitsDataSource(List<Visit> source) {
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
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
