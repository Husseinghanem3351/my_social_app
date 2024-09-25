import 'package:flutter/material.dart';
import 'package:my_social_app/modules/Edit_Profile/edit_profile.dart';

import '../../../shared/components.dart';

class EditPhoneBox extends StatelessWidget {
  const EditPhoneBox({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultTextBox(
      textBoxController: EditProfile.phoneController,
      labelText: 'Phone',
      validate: (value){
        if(value!.isEmpty){
          return 'the phone must be not empty';
        }
        return null;
      },
      prefIcon: const Icon(Icons.phone),
      inputType: TextInputType.phone,
      border: const OutlineInputBorder(),
    );
  }
}
