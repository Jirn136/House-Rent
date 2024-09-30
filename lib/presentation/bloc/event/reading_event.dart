import 'package:equatable/equatable.dart';
import 'package:house_rent/domain/models/selected_tenant_model.dart';

abstract class ReadingEvent extends Equatable {
  const ReadingEvent();

  @override
  List<Object?> get props => [];
}

class AddReading extends ReadingEvent {
  final SelectedTenantModel r;

  const AddReading(this.r);

  @override
  List<Object?> get props => [r];
}

class GetReading extends ReadingEvent {
  final String tn;
  final int tId;

  const GetReading(this.tn, this.tId);

  @override
  List<Object?> get props => [tn, tId];
}

class CalculateReading extends ReadingEvent {
  final int id;
  final int r;

  const CalculateReading(this.id, this.r);

  @override
  List<Object?> get props => [r];
}
