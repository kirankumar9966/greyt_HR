import 'package:flutter/material.dart';
class TrianglePainter extends CustomPainter {
  final Color color;
  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top center
      ..lineTo(0, size.height)    // Bottom left
      ..lineTo(size.width, size.height) // Bottom right
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ShowLegendsView extends StatelessWidget {
  @override
  Widget _legendRowTriangle(Color color, String label) {
    return Row(
      children: [
        CustomPaint(
          size: Size(16, 16), // Triangle size
          painter: TrianglePainter(color),
        ),
        SizedBox(width: 8),
        Text(label),
      ],
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Legend"),
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
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Shift Codes"),
              Row(
                children: [
                  Expanded(
                    child: _legendRowTriangle( Colors.orange,"Regularized"),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _legendRowTriangle( Colors.purple[200]!,"Override"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _legendRowTriangle(Colors.grey, "Ignored"),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _legendRowTriangle(Colors.orange[100]!, "Grace"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _legendRowTriangle( Colors.redAccent,"Deduction"),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _legendRowTriangle(Colors.lightBlueAccent, "Deduction Alert"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _sectionTitle("Status"),
              Row(
                children: [
                  Expanded(
                    child: _legendRowCircle(Colors.purple[200]!, "Holiday"),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _legendText("A", "Absent", Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _legendText("O", "Off Day", Colors.grey),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _legendCircle(Colors.orange, "Overtime"),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _legendText("?", "Status Unknown", Colors.blue),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child:  _legendCircle(Colors.orange[700]!, "Restricted Holiday"),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _legendText("R", "Rest Day", Colors.blue),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _legendText("L", "Leave", Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _legendText("P", "Present", Colors.blue),
                  ),

                ],
              ),


              SizedBox(height: 16),
              _sectionTitle("Leave Type"),
              SizedBox(height: 16),
              Row(
                children: [
                  _legendTextOnly("EL", "Earned Leave"),
                  SizedBox(width: 32),
                  _legendTextOnly("CL", "Casual Leave"),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _legendRow(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  Widget _legendRowCircle(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }

  Widget _legendCircle(Color color, String label) {
    return _legendRowCircle(color, label);
  }

  Widget _legendText(String symbol, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            symbol,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }

  Widget _legendTextOnly(String symbol, String label) {
    return Row(
      children: [
        Text(
          symbol,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(label),
      ],
    );
  }
}
