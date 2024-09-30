import 'package:equatable/equatable.dart';
import 'package:house_rent/domain/models/tenant_model.dart';

abstract class TenantEvent extends Equatable {
  const TenantEvent();

  @override
  List<Object?> get props => [];
}

class LoadTenant extends TenantEvent {}

class UpsertTenant extends TenantEvent {
  final TenantModel tm;
  final bool isRename;
  final TenantModel? pTm;

  const UpsertTenant(this.tm, this.isRename, this.pTm);

  @override
  List<Object?> get props => [tm, isRename, pTm];
}
