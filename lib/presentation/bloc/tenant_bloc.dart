import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rent/domain/usecases/tenant_use_case.dart';
import 'package:house_rent/presentation/bloc/event/tenant_event.dart';
import 'package:house_rent/presentation/bloc/state/tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  final TenantUseCase tc;

  TenantBloc(this.tc) : super(TenantInitial()) {
    on<LoadTenant>((e, em) async {
      em(TenantLoading());
      try {
        em(
          TenantLoaded(
            await tc.getTenantList(),
          ),
        );
      } catch (e) {
        em(TenantError('Failed to load Tenants'));
      }
    });

    on<UpsertTenant>((e, em) async {
      em(TenantLoading());
      try {
        if (!e.isRename) {
          await tc.insertTenant(e.tm);
        } else {
          await tc.updateToNewTenant(e.tm, e.pTm);
        }

        add(LoadTenant());
      } catch (e) {
        em(TenantError('Failed to upsert tenants'));
      }
    });
  }
}
