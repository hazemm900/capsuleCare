import 'package:bloc/bloc.dart';
import 'edit_medicine_state.dart';

class EditMedicineCubit extends Cubit<EditMedicineState> {
  EditMedicineCubit() : super(EditMedicineInitial());
}
