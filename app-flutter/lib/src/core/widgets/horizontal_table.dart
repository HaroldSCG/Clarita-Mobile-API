import 'package:flutter/material.dart';

class HorizontalTable extends StatelessWidget {
  final List<Map<String, dynamic>> rows;
  final List<String> columns;

  const HorizontalTable({
    super.key,
    required this.rows,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
        rows: rows.map((row) {
          return DataRow(
            cells: columns.map((c) {
              return DataCell(Text("${row[c]}"));
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}