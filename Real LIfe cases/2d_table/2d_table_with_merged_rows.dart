/// https://gist.github.com/azatech/6d4894559a1467e84da320580aa24ce6
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class CustomMergedExample extends StatefulWidget {
  const CustomMergedExample({super.key});

  @override
  State<CustomMergedExample> createState() => _CustomMergedState();
}

const mergedRowsCount = 5; // adjust here
const columnsCount = 6; // adjust here
const skipFirstRowIndex = 1; // adjust here

class _CustomMergedState extends State<CustomMergedExample> {
  ({
  String name,
  Color color,
  }) _getDataForVicinity(TableVicinity vicinity) {
    final int blockIndex =
    ((vicinity.row - skipFirstRowIndex) / mergedRowsCount).floor();
    if (vicinity.row == 0) {
      return (
      color: Colors.grey.withOpacity(0.3),
      name: vicinity.column > 1 ? 'Column ${vicinity.column - 1}' : ''
      );
    }
    if (vicinity.column == 0) {
      return (color: Colors.blue, name: 'Block $blockIndex');
    }
    return (
    color: Colors.white,
    name: vicinity.column < 2
        ? 'Floor ${vicinity.row - skipFirstRowIndex}'
        : '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: TableView.builder(
          cellBuilder: _buildCell,
          columnCount: columnsCount,
          columnBuilder: _buildColumnSpan,
          rowCount: (mergedRowsCount * 10) + skipFirstRowIndex,
          rowBuilder: _buildRowSpan,
        ),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
    final int blockIndex =
    ((vicinity.row - skipFirstRowIndex) / mergedRowsCount).floor();
    final ({String name, Color color}) cell = _getDataForVicinity(vicinity);
    final TextStyle style = TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: vicinity.column == 0 ? FontWeight.bold : null,
    );
    final rowMergeStart = vicinity.column == 0 && vicinity.row > 0
        ? (blockIndex * mergedRowsCount) + skipFirstRowIndex
        : null;
    final rowMergeSpan =
    vicinity.column == 0 && vicinity.row > 0 ? mergedRowsCount : null;
    print(
        'vicinity.row: ${vicinity.row}, blockIndex: $blockIndex, rowMergeStart: $rowMergeStart, rowMergeSpan: $rowMergeSpan');

    return TableViewCell(
      rowMergeStart: rowMergeStart,
      rowMergeSpan: rowMergeSpan,
      child: Container(
        decoration: BoxDecoration(
          color: cell.color,
          border: Border.all(color: Colors.black),
        ),
        child: Center(child: Text(cell.name, style: style)),
      ),
    );
  }

  TableSpan _buildColumnSpan(int index) {
    final extent = switch (index) {
      0 => 140.0,
      1 => 200.0,
      _ => 100.0,
    };
    return TableSpan(extent: FixedTableSpanExtent(extent));
  }

  TableSpan _buildRowSpan(int index) {
    return const TableSpan(extent: FixedTableSpanExtent(200 / mergedRowsCount));
  }
}
