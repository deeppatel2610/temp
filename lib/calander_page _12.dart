import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class AttendanceLogScreen extends StatefulWidget {
  @override
  _AttendanceLogScreenState createState() => _AttendanceLogScreenState();
}

class _AttendanceLogScreenState extends State<AttendanceLogScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, Color> _attendanceData = {
    DateTime(2025, 3, 1): Colors.green,
    DateTime(2025, 3, 3): Colors.red,
    DateTime(2025, 3, 4): Colors.pinkAccent,
    DateTime(2025, 3, 5): Colors.blue,
    DateTime(2025, 3, 6): Colors.purple,
    DateTime(2025, 2, 28): Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Attendance Log"),
        leading: Icon(Icons.arrow_back),
        actions: [Icon(Icons.menu)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: [
                _buildLegend("Present", Colors.green),
                _buildLegend("Absent", Colors.red),
                _buildLegend("Leave", Colors.blue),
                _buildLegend("Week Off", Colors.grey),
                _buildLegend("Late", Colors.pinkAccent),
                _buildLegend("Early", Colors.purple),
                _buildLegend("Late & Early", Colors.red),
              ],
            ),
          ),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  Color? color = _attendanceData[day];
                  return Container(
                    margin: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color ?? Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(
                        color: color != null ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
