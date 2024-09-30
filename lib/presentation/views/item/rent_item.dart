import 'package:flutter/cupertino.dart';
import 'package:house_rent/domain/models/current_rent_model.dart';

class RentItem extends StatelessWidget {
  final CurrentRentModel model;

  const RentItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          model.content,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '₹ ${model.value}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
