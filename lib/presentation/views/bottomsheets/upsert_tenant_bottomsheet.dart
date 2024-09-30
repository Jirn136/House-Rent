import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:house_rent/presentation/views/custom/custom_edit_field.dart';
import 'package:house_rent/presentation/views/custom/date_selection.dart';
import 'package:house_rent/presentation/views/custom/options_view.dart';
import 'package:house_rent/utils/constants.dart';
import 'package:house_rent/utils/extension.dart';

class UpsertTenantBottomSheet extends StatefulWidget {
  final bool isRename;
  final Function(TenantModel) tenantCallback;

  const UpsertTenantBottomSheet({
    super.key,
    required this.tenantCallback,
    required this.isRename,
  });

  @override
  State<UpsertTenantBottomSheet> createState() =>
      _UpsertTenantBottomSheetState();
}

class _UpsertTenantBottomSheetState extends State<UpsertTenantBottomSheet> {
  final _nameController = TextEditingController();
  final _advanceController = TextEditingController();
  var timeStamp = 0;

  int getTimeStamp() {
    return timeStamp == 0 ? DateTime.now().millisecondsSinceEpoch : timeStamp;
  }

  void returnTenantData() {
    widget.tenantCallback(
      TenantModel(
        tN: _nameController.text,
        ts: getTimeStamp(),
        a: int.parse(_advanceController.text),
      ),
    );
  }

  String _setupTitle() {
    return widget.isRename
        ? Constants.titleRenameTenant
        : Constants.titleAddTenant;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              child: Text(
                _setupTitle(),
                style: const TextStyle().boldTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: CustomEditField(
                labelText: Constants.hintTenantName,
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
                controller: _nameController,
              ),
            ),
            CustomEditField(
              labelText: Constants.hintAdvanceAmount,
              keyboardType: TextInputType.number,
              inputAction: TextInputAction.done,
              controller: _advanceController,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  bottom: 18.0,
                  top: 8,
                ),
                child: DateSelection(
                  selectedDate: (selectedDate) {
                    if (kDebugMode) {
                      print(selectedDate.formatDate());
                      timeStamp = selectedDate;
                    }
                  },
                )),
            Divider(
              height: 1,
              color: Colors.grey.shade400,
            ),
            OptionsView(
              onLeftClicked: () => Navigator.pop(context),
              onRightClicked: () {
                returnTenantData();
                Navigator.pop(context);
              },
              actionTitle: widget.isRename
                  ? Constants.actionUpdate
                  : Constants.actionAdd,
            )
          ],
        ),
      ),
    );
  }
}
