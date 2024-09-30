import 'package:flutter/material.dart';
import 'package:house_rent/domain/models/selected_tenant_model.dart';
import 'package:house_rent/utils/extension.dart';

class ReadingDataSource extends DataTableSource {
  late final List<SelectedTenantModel> _m;
  int? _selectedRowIndex;
  late Function(SelectedTenantModel) _onRowSelected;

  ReadingDataSource({
    required List<SelectedTenantModel> m,
    required Function(SelectedTenantModel) onRowSelected,
  }) {
    _m = m;
    _onRowSelected = onRowSelected;
  }

  @override
  DataRow? getRow(int index) {
    final bool isSelected = _selectedRowIndex == index;
    if (index >= _m.length) {
      return null;
    }
    final rd = _m[index];
    return DataRow(
        cells: [
          DataCell(
            Text(
              rd.timestamp.formatDate(),
            ),
          ),
          DataCell(
            Text(
              rd.reading.toString(),
            ),
          ),
          DataCell(
            Text(
              rd.unit.toString(),
            ),
          ),
          DataCell(
            Text(
              rd.total.toString(),
            ),
          ),
        ],
        selected: isSelected,
        onSelectChanged: (onSelect) {
          _onRowSelected(_m[index]);
          _selectedRowIndex = onSelect == true ? index : null;
          notifyListeners();
        });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _m.length;

  @override
  int get selectedRowCount => 0;
}
