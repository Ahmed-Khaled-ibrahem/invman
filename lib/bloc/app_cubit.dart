import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AllAppCubit extends Cubit<AllAppStates> {
  AllAppCubit() : super(Start());

  static AllAppCubit get(context) => BlocProvider.of(context);

  void setState() {
    emit(AllAppRendered());
  }

}
