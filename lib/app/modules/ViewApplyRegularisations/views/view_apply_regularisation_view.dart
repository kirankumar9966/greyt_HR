import 'package:flutter/material.dart';
import 'package:greyt_hr/app/modules/ViewApplyRegularisations/controllers/view_apply_regularisation_controller.dart';
import 'package:greyt_hr/app/modules/applyRegularisationScreen/views/apply_regularisation_screen_view.dart';
import 'package:greyt_hr/app/modules/applyRegularization/controllers/apply_regularization_controller.dart';
import 'package:greyt_hr/app/modules/showLegends/views/show_legends_view.dart';
import 'package:table_calendar/table_calendar.dart';

class ApplyRegularisationView extends StatefulWidget {
  @override
  _ApplyRegularisationViewState createState() => _ApplyRegularisationViewState();
}

class _ApplyRegularisationViewState extends State<ApplyRegularisationView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _buttonLabel = 'Regularize - 01 Day';

  final Set<DateTime> _selectedDates = {};
  @override
  Widget build(BuildContext context) {
    final ViewApplyRegularisationController controller = ViewApplyRegularisationController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Regularisation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // navigate to home
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  controller.buildTabButton(context, 'Apply', true, 'apply'),
                  controller.buildTabButton(context, 'Pending', false, 'pending'),
                  controller.buildTabButton(context, 'History', false, 'history'),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 226,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.orangeAccent[100], // Light blue background
                borderRadius: BorderRadius.circular(8),
              ),

              child:

              Row(

               children: [
                 Icon(
                   Icons.info_outline,
                   color: Colors.yellow[900],
                 ),
                 SizedBox(width: 8),
                 Text(
                   'Tap on date to select',
                   style: TextStyle(
                     fontSize: 16,
                     color: Colors.yellow[900], // Dark yellow text
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ]

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowLegendsView()),
                    );
                  },

                  label: Text("Show Legend"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),


                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => _selectedDates.contains(day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (selectedDay.weekday == DateTime.saturday || selectedDay.weekday == DateTime.sunday) {
                    // Show snackbar if weekend
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "You can't apply regularisation on weekends"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  else {
                    // Update the selected and focused day
                    setState(() {
                      if (_selectedDates.contains(selectedDay)) {
                        _selectedDates.remove(selectedDay);
                      } else {
                        _selectedDates.add(selectedDay);
                      }
                    });
                    _updateButtonLabel();
                  }
                },
                enabledDayPredicate: (day) {
                  // Disable future dates
                  return !day.isAfter(DateTime.now());
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                  disabledTextStyle: TextStyle(color: Colors.grey), // Style for disabled dates
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.blue[100], // Light blue background
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Yay! No exception Days.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[900], // Dark blue text
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
            Text(
              _selectedDay != null
                  ? 'Selected Date: ${_selectedDay!.toLocal().toString().split(' ')[0]}'
                  : 'Please select a date',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),

    );
  }
  void _updateButtonLabel() {
    if(_selectedDates.isNotEmpty) {
      setState(() {
        _buttonLabel = 'Regularize - ${_selectedDates.length} Days';
      });
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    if (_selectedDates.isNotEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: Duration(seconds: 10),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFF5C6BC0),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_buttonLabel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegularizationScreen(
                          selectedDates: _selectedDates,
                        ),
                       ),
                    );
                  },
                  child: Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

  }

}
