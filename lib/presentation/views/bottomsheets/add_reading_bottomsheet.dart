import 'package:flutter/material.dart';
import 'package:house_rent/domain/models/selected_tenant_model.dart';
import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:house_rent/presentation/views/custom/custom_edit_field.dart';
import 'package:house_rent/presentation/views/custom/date_selection.dart';
import 'package:house_rent/presentation/views/custom/options_view.dart';
import 'package:house_rent/utils/constants.dart';
import 'package:house_rent/utils/extension.dart';

class AddReadingBottomSheet extends StatefulWidget {
  final TenantModel tm;
  final Function(SelectedTenantModel) onAddClicked;

  const AddReadingBottomSheet(
      {super.key, required this.tm, required this.onAddClicked});

  @override
  State<AddReadingBottomSheet> createState() => _AddReadingBottomSheetState();
}

class _AddReadingBottomSheetState extends State<AddReadingBottomSheet> {
  final TextEditingController _readingController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  var _selectedDate = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              child: Text(
                Constants.titleReading,
                style: const TextStyle().boldTitle,
              ),
            ),
            CustomEditField(
              labelText: Constants.titleAddReading,
              inputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: _readingController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomEditField(
                labelText: Constants.hintAddBalance,
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: _balanceController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 18.0,
                top: 8,
              ),
              child: DateSelection(
                selectedDate: (selectedDate) {
                  _selectedDate = selectedDate;
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey.shade400,
            ),
            OptionsView(
              onLeftClicked: () => Navigator.pop(context),
              onRightClicked: () {
                if (_readingController.text.isNotEmpty) {
                  widget.onAddClicked(
                    SelectedTenantModel(
                      tn: widget.tm.tenantName,
                      id: widget.tm.timestamp,
                      r: int.parse(_readingController.text),
                      b: _balanceController.text.isNotEmpty
                          ? int.parse(_balanceController.text)
                          : 0,
                      tms: _selectedDate != 0
                          ? _selectedDate
                          : DateTime.now().millisecondsSinceEpoch,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Empty Data can\'t be set'),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              actionTitle: Constants.actionAdd,
            )
          ],
        ),
      ),
    );
  }
}
