import 'package:flutter/material.dart';

class CustomStyledDataTable extends StatefulWidget {
  final List<String> columnHeaders;
  final List<String> rowKeys;
  final List<Map<String, dynamic>> data;
  final ScrollController horizontalController;
  final ScrollController verticalController;
  final ValueChanged<int>? onEdit;
  final ValueChanged<int>? onCheckboxChanged;
  final double? tableWidth;
  final double? columnSpacing;
  final Map<String, int>? maxLinesPerColumn;
  final double? dataMinRowHeight;
  final double? dataMaxRowHeight;

  const CustomStyledDataTable({
    super.key,
    required this.columnHeaders,
    required this.rowKeys,
    required this.data,
    required this.horizontalController,
    required this.verticalController,
    this.onEdit,
    this.onCheckboxChanged,
    this.tableWidth,
    this.columnSpacing,
    this.maxLinesPerColumn,
    this.dataMinRowHeight,
    this.dataMaxRowHeight
  });

  @override
  _CustomStyledDataTableState createState() => _CustomStyledDataTableState();
}

class _CustomStyledDataTableState extends State<CustomStyledDataTable> {
  late List<Map<String, dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = List.from(widget.data.map((row) {
      if (!row.containsKey('checkbox')) {
        row['checkbox'] = false;
      }
      return row;
    }));
  }

  void _onCheckboxChanged(int index, bool? newValue) {
    setState(() {
      _data[index]['checkbox'] = newValue ?? false;
    });
    widget.onCheckboxChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: const Radius.circular(3),
      thumbVisibility: true,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      controller: widget.horizontalController,
      child: SingleChildScrollView(
        controller: widget.horizontalController,
        scrollDirection: Axis.horizontal,
        child: Scrollbar(
          radius: const Radius.circular(3),
          thumbVisibility: true,
          scrollbarOrientation: ScrollbarOrientation.right,
          controller: widget.verticalController,
          child: SingleChildScrollView(
            controller: widget.verticalController,
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: widget.tableWidth,
              child: DataTableTheme(
                data: DataTableThemeData(
                  dividerThickness: 0.1,
                  headingRowColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF4B0C0C),
                  ),
                  headingRowHeight: 45,
                  columnSpacing: widget.columnSpacing ?? 12.0,
                ),
                child: DataTable(
                  border: TableBorder.all(
                    width: 0.1,
                    color: Colors.black54.withOpacity(0.5),
                  ),
                  headingRowHeight: 45,
                  dataRowMinHeight: widget.dataMinRowHeight,
                  dataRowMaxHeight: widget.dataMaxRowHeight,
                  columns: widget.rowKeys.map((key) {
                    final String header = widget.columnHeaders[widget.rowKeys.indexOf(key)];
                    return DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            header,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'RobotoThin',
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  rows: _data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final row = entry.value;
                    final color = index % 2 == 0
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1);

                    return DataRow(
                      color: MaterialStateProperty.all(color),
                      cells: widget.rowKeys.map((key) {
                        if (key == 'checkbox') {
                          return DataCell(
                            Center(
                              child: Checkbox(
                                value: row[key] ?? false,
                                onChanged: (bool? newValue) {
                                  _onCheckboxChanged(index, newValue);
                                },
                              ),
                            ),
                          );
                        } else if (key == 'edit') {
                          return DataCell(
                            Center(
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () {
                                  widget.onEdit?.call(index);
                                },
                              ),
                            ),
                          );
                        } else {
                          final int maxLines = widget.maxLinesPerColumn?[key] ?? 1;
                          return DataCell(
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: maxLines == 1
                                  ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Center(
                                  child: SelectableText(
                                    row[key]?.toString() ?? '',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'RobotoThin',
                                      color: Colors.black54,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    // softWrap: false,
                                    // overflow: TextOverflow.visible,
                                  ),
                                ),
                              )
                                  : SelectableText(
                                row[key]?.toString() ?? '',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'RobotoThin',
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                                // softWrap: true,
                                // overflow: TextOverflow.visible,
                              ),
                            ),
                          );
                        }
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}