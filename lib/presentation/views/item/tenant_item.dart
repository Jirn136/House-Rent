import 'package:flutter/material.dart';
import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:house_rent/utils/constants.dart';
import 'package:house_rent/utils/extension.dart';

class TenantItem extends StatelessWidget {
  final Function(TenantModel)? onUserSelected;
  final Function(TenantModel)? onUpdateClicked;
  final TenantModel tm;
  final bool renameNeeded;
  final bool isForRent;

  const TenantItem({
    super.key,
    required this.tm,
    this.onUserSelected,
    this.renameNeeded = false,
    this.onUpdateClicked,
    this.isForRent = false,
  });

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment getMainAxisAlignment() {
      return !isForRent
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center;
    }

    CrossAxisAlignment getCrossAxisAlignment() {
      return !isForRent ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    }

    return GestureDetector(
      onTap: () => onUserSelected!(tm),
      child: Card(
        margin: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: getMainAxisAlignment(),
            children: [
              Column(
                crossAxisAlignment: getCrossAxisAlignment(),
                children: [
                  Text(
                    tm.tenantName,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Advance: ₹ ${tm.advance}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    tm.timestamp.formatDate(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: renameNeeded,
                child: IconButton(
                  onPressed: () {
                    onUpdateClicked!(tm);
                  },
                  icon: const Icon(
                    Icons.drive_file_rename_outline_outlined,
                  ),
                  tooltip: Constants.titleRenameTenant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
