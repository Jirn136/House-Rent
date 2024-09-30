import 'package:equatable/equatable.dart';
import 'package:house_rent/domain/models/selected_tenant_model.dart';

abstract class ReadingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReadingInitial extends ReadingState {}

class ReadingLoading extends ReadingState {}

class ReadingLoaded extends ReadingState {
  final List<SelectedTenantModel> r;

  ReadingLoaded(this.r);

  @override
  List<Object?> get props => [r];

}

class ReadingError extends ReadingState {
  final String em;

  ReadingError(this.em);

}