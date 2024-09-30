import 'package:house_rent/domain/models/selected_tenant_model.dart';

abstract class ReadingRepository {
  Future<void> addReading(SelectedTenantModel cr);

  Future<List<SelectedTenantModel>> getUserReading(int i,String tn);

  Future<SelectedTenantModel?> getLastReading(int i,String tn);
}
