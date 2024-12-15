import 'package:capsule_care/business_layer/add_new_medicine/add_new_medicine_cubit.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/presentation/widgets/myFullTextForm.dart';
import 'package:flutter/material.dart';

class allTextFormFiledAddNewScreen extends StatelessWidget {
  const allTextFormFiledAddNewScreen({super.key});


  Widget buildMedicineNameTextField(context) {
    return MyFullTextForm(
      formName: S.of(context).medicineName,
      formLableText: S.of(context).medicineName,
      controller: AddNewMedicineCubit.get(context).medicineName,
      formHintText: S.of(context).addNewMedicine,
      formPrefixIcon: Icons.medical_services_outlined,
      keyboardType: TextInputType.name,
    );
  }

  Widget buildTotalNumTextField(context) {
    return MyFullTextForm(
      formName: S.of(context).totalNumberOfCapsules,
      formLableText: S.of(context).totalNumberOfCapsules,
      controller: AddNewMedicineCubit.get(context).totalNumberOfCapsules,
      formHintText: S.of(context).totalNumberOfCapsules,
      formPrefixIcon: Icons.medical_services_outlined,
      keyboardType: TextInputType.number,
    );
  }

  Widget buildRemainderNumTextField(context) {
    return MyFullTextForm(
      formName: S.of(context).remainderOfCapsules,
      formLableText: S.of(context).remainderOfCapsules,
      controller: AddNewMedicineCubit.get(context).remainderOfCapsules,
      formHintText: S.of(context).remainderOfCapsules,
      formPrefixIcon: Icons.medical_services_outlined,
      keyboardType: TextInputType.number,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildMedicineNameTextField(context),
        buildTotalNumTextField(context),
        buildRemainderNumTextField(context)
      ],
    );
  }
}
