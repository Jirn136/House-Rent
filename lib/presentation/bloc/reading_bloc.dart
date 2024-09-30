import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rent/domain/usecases/reading_use_case.dart';
import 'package:house_rent/presentation/bloc/event/reading_event.dart';
import 'package:house_rent/presentation/bloc/state/reading_state.dart';

class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  final ReadingUseCase r;

  ReadingBloc(this.r) : super(ReadingInitial()) {
    on<AddReading>((e, em) async {
      em(ReadingLoading());
      try {
        await r.executeAddReading(e.r);
        add(GetReading(e.r.tenantName, e.r.tenantId));
      } catch (e) {
        em(ReadingError('Unable to add data $e'));
      }
    });

    on<GetReading>((e, em) async {
      em(ReadingLoading());
      try {
        em(
          ReadingLoaded(
            await r.getReading(e.tId, e.tn),
          ),
        );
      } catch (e) {
        em(
          ReadingError('Unable to get data:: $e'),
        );
      }
    });
  }
}
