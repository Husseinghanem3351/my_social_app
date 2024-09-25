import 'package:flutter/material.dart';

import '../../../shared/components.dart';
import '../../../shared/styles/icon_broken.dart';
import '../edit_profile.dart';

class EditNameBox extends StatelessWidget {
  const EditNameBox({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultTextBox(
      textBoxController: EditProfile.nameController,
      labelText: 'Name',
      validate: (value){
        if(value!.isEmpty){
          return 'the Name must be not empty';
        }
        return null;
      },
      prefIcon: const Icon(IconBroken.User),
      inputType: TextInputType.name,
      border: const OutlineInputBorder(),
    );
  }
}
