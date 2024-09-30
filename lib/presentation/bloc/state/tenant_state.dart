import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:equatable/equatable.dart';

abstract class TenantState extends Equatable{
  @override
  List<Object?> get props => [];
}

class TenantInitial extends TenantState {
}

class TenantLoading extends TenantState {}

class TenantLoaded extends TenantState {
  final List<TenantModel> tenants;

  TenantLoaded(this.tenants);
  @override
  List<Object?> get props => [tenants];
}

class TenantError extends TenantState {
  final String errorMessage;

  TenantError(this.errorMessage);
}
