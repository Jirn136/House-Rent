import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rent/domain/models/tenant_model.dart';
import 'package:house_rent/presentation/bloc/event/reading_event.dart';
import 'package:house_rent/presentation/bloc/reading_bloc.dart';
import 'package:house_rent/presentation/bloc/state/reading_state.dart';
import 'package:house_rent/presentation/datasource/reading_data_source.dart';
import 'package:house_rent/presentation/views/bottomsheets/add_reading_bottomsheet.dart';
import 'package:house_rent/presentation/views/item/tenant_item.dart';
import 'package:house_rent/utils/constants.dart';
import 'package:house_rent/utils/extension.dart';

class RentDataScreen extends StatefulWidget {
  final TenantModel m;

  const RentDataScreen({super.key, required this.m});

  @override
  State<RentDataScreen> createState() => _RentDataScreenState();
}

class _RentDataScreenState extends State<RentDataScreen> {
  @override
  Widget build(BuildContext context) {
    print('tms:: ${widget.m.timestamp}');
    context
        .read<ReadingBloc>()
        .add(GetReading(widget.m.tenantName, widget.m.timestamp));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddReadingBottomSheet(context, widget.m);
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TenantItem(
                tm: widget.m,
                isForRent: true,
              ),
            ),
            BlocBuilder<ReadingBloc, ReadingState>(
              builder: (context, s) {
                if (s is ReadingLoaded) {
                  final r = s.r;
                  ReadingDataSource source =
                      ReadingDataSource(m: r, onRowSelected: (s) {});
                  return r.isNotEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: PaginatedDataTable(
                                columnSpacing:
                                    MediaQuery.of(context).size.width * 0.1,
                                columns: const [
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      Constants.titleDate,
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      Constants.titleReading,
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      Constants.titleUnit,
                                    ),
                                  ),
                                  DataColumn(
                                    headingRowAlignment:
                                        MainAxisAlignment.center,
                                    label: Text(
                                      Constants.titleTotal,
                                    ),
                                  )
                                ],
                                rowsPerPage:
                                    (MediaQuery.of(context).size.height * 0.01)
                                        .round(),
                                source: source,
                                showCheckboxColumn: false,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              'No reading found, \n Try add one',
                              textAlign: TextAlign.center,
                              style: const TextStyle().boldTitle,
                            ),
                          ),
                        );
                } else if (s is ReadingLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (s is ReadingError) {
                  return Expanded(
                    child: Center(
                      child: Text(s.em),
                    ),
                  );
                } else {
                  return const Text(Constants.titleSomethingWrong);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showAddReadingBottomSheet(BuildContext context, TenantModel tm) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddReadingBottomSheet(
            tm: tm,
            onAddClicked: (stm) {
              print("stm:: $stm");
              context.read<ReadingBloc>().add(
                    AddReading(
                      stm,
                    ),
                  );
            },
          ),
        );
      },
    );
  }
}
