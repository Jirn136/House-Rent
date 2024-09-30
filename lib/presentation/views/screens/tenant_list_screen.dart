import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:house_rent/presentation/bloc/event/tenant_event.dart';
import 'package:house_rent/presentation/bloc/state/tenant_state.dart';
import 'package:house_rent/presentation/bloc/tenant_bloc.dart';
import 'package:house_rent/presentation/views/bottomsheets/current_rent_bottomsheet.dart';
import 'package:house_rent/presentation/views/bottomsheets/upsert_tenant_bottomsheet.dart';
import 'package:house_rent/presentation/views/item/tenant_item.dart';
import 'package:house_rent/presentation/views/screens/rent_data_screen.dart';
import 'package:house_rent/utils/constants.dart';
import 'package:house_rent/utils/extension.dart';

class TenantListScreen extends StatefulWidget {
  const TenantListScreen({super.key});

  @override
  State<TenantListScreen> createState() => _TenantListScreenState();
}

class _TenantListScreenState extends State<TenantListScreen> {
  TenantModel? pTm;
  late List<TenantModel> m;

  @override
  void initState() {
    super.initState();
    context.read<TenantBloc>().add(
          LoadTenant(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showCurrentBottomSheet,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.monetization_on_outlined,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextButton.icon(
                  onPressed: () => showUpsertTenantBottomSheet(false),
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    Constants.titleAddTenant,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<TenantBloc, TenantState>(
              builder: (context, state) {
                if (state is TenantLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is TenantError) {
                  return const Expanded(
                    child: Center(
                      child: Text(Constants.titleSomethingWrong),
                    ),
                  );
                } else if (state is TenantLoaded) {
                  final tm = state.tenants;
                  m = tm;
                  return tm.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: tm.length,
                            itemBuilder: (BuildContext context, int index) {
                              TenantModel model = tm[index];
                              return TenantItem(
                                tm: model,
                                onUserSelected: (m) {
                                  navigateToRentData(m);
                                },
                                renameNeeded: true,
                                onUpdateClicked: (tm) {
                                  pTm = tm;
                                  showUpsertTenantBottomSheet(true);
                                },
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              Constants.titleNoTenantList,
                              textAlign: TextAlign.center,
                              style: const TextStyle().boldTitle,
                            ),
                          ),
                        );
                } else {
                  return Text("state:: $state");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showUpsertTenantBottomSheet(bool isRename) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: UpsertTenantBottomSheet(
            isRename: isRename,
            tenantCallback: (TenantModel tm) {
              print('new Tenant:: $tm isRename:: $isRename pTm:: $pTm');
              context.read<TenantBloc>().add(UpsertTenant(tm, isRename,pTm));
            },
          ),
        );
      },
    );
  }

  void showCurrentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const CurrentRentBottomSheet(),
        );
      },
    );
  }

  void navigateToRentData(TenantModel m) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RentDataScreen(
          m: m,
        ),
      ),
    );
  }
}
