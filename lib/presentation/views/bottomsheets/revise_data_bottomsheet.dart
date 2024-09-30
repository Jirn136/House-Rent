import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:house_rent/data/datasource/local/preferences.dart';
import 'package:house_rent/di/app_module.dart';
import 'package:house_rent/presentation/views/custom/custom_edit_field.dart';
import 'package:house_rent/presentation/views/custom/options_view.dart';
import 'package:house_rent/utils/constants.dart';
import 'package:house_rent/utils/extension.dart';

class ReviseDataBottomSheet extends StatelessWidget {
  const ReviseDataBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController unitController = TextEditingController();
    final TextEditingController waterController = TextEditingController();
    final sharedPref = sl<SharedPrefs>();

    Future<void> saveData() async {
      try {
        sharedPref.save(
          Constants.keyAmount,
          amountController.text.isNotEmpty
              ? amountController.text
              : sharedPref.getString(Constants.keyAmount),
        );
        sharedPref.save(
          Constants.keyUnit,
          unitController.text.isNotEmpty
              ? unitController.text
              : sharedPref.getString(Constants.keyUnit),
        );
        sharedPref.save(
          Constants.keyWater,
          waterController.text.isNotEmpty
              ? waterController.text
              : sharedPref.getString(Constants.keyWater),
        );
      } catch (e) {
        if (kDebugMode) {
          print('Something wrong $e');
        }
      }
    }

    void onAddClicked() {
      saveData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Saved Successfully",
          ),
        ),
      );
      Navigator.pop(context);
    }

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
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
                Constants.titleReviseData,
                style: const TextStyle().boldTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: CustomEditField(
                labelText: Constants.hintRevisedAmount,
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: amountController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomEditField(
                      labelText: Constants.hintRevisedUnitAmount,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: unitController,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomEditField(
                      labelText: Constants.hintRevisedWaterAmount,
                      inputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      controller: waterController,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey.shade400,
            ),
            OptionsView(
              onLeftClicked: () => Navigator.of(context).pop(),
              onRightClicked: onAddClicked,
              actionTitle: Constants.actionUpdate,
            ),
          ],
        ),
      ),
    );
  }
}
