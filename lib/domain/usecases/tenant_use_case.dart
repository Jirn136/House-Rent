import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:house_rent/domain/repository/tenant_repository.dart';

class TenantUseCase {
  final TenantRepository _r;

  TenantUseCase(this._r);

  Future<List<TenantModel>> getTenantList() async {
    return _r.getAllTenants();
  }

  Future<void> insertTenant(TenantModel tm) async {
    return _r.upsert(tm);
  }

  Future<void> updateToNewTenant(TenantModel tm,TenantModel? pTm) async {
    return _r.updateToNewTenant(tm,pTm);
  }

}
