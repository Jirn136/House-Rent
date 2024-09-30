import 'package:flutter/material.dart';
import 'package:house_rent/data/datasource/local/preferences.dart';
import 'package:house_rent/di/app_module.dart';
import 'package:house_rent/domain/models/current_rent_model.dart';
import 'package:house_rent/presentation/views/bottomsheets/revise_data_bottomsheet.dart';
import 'package:house_rent/utils/extension.dart';

import '../../../utils/constants.dart';
import '../item/rent_item.dart';

class CurrentRentBottomSheet extends StatefulWidget {
  const CurrentRentBottomSheet({super.key});

  @override
  State<CurrentRentBottomSheet> createState() => _CurrentRentBottomSheetState();
}

class _CurrentRentBottomSheetState extends State<CurrentRentBottomSheet> {
  late List<CurrentRentModel> rentData;
  final sharedPref = sl<SharedPrefs>();

  @override
  void initState() {
    super.initState();
    _setupData();
  }

  Future<void> _setupData() async {
    String amount = sharedPref.getString(Constants.keyAmount);
    String unit = sharedPref.getString(Constants.keyUnit);
    String water = sharedPref.getString(Constants.keyWater);

    setState(() {
      rentData = [
        CurrentRentModel(c: Constants.contentRent, v: amount),
        CurrentRentModel(c: Constants.contentWater, v: water),
        CurrentRentModel(c: Constants.contentUnit, v: unit)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    void showReviseBottomSheet() {
      Navigator.pop(context);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const ReviseDataBottomSheet(),
          );
        },
      );
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
            Text(
              Constants.titleCurrentRent,
              style: const TextStyle().boldTitle,
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: rentData.length,
                itemBuilder: (BuildContext context, index) {
                  CurrentRentModel rent = rentData[index];
                  return RentItem(
                    model: rent,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Divider(
                height: 1,
                color: Colors.grey.shade400,
              ),
            ),
            TextButton.icon(
              onPressed: showReviseBottomSheet,
              icon: const Icon(
                Icons.edit,
              ),
              label: Text(
                Constants.titleReviseData,
                style: const TextStyle().textButtonStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
