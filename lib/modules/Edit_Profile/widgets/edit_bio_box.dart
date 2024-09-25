import 'package:flutter/material.dart';

import '../../../shared/components.dart';
import '../../../shared/styles/icon_broken.dart';
import '../edit_profile.dart';

class EditBioBox extends StatelessWidget {
  const EditBioBox({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultTextBox(
      textBoxController: EditProfile.bioController,
      labelText: 'Bio',
      validate: (value){
        if(value!.isEmpty){
          return 'the Bio must be not empty';
        }
        return null;
      },
      prefIcon: const Icon(IconBroken.Info_Circle),
      inputType: TextInputType.name,
      border: const OutlineInputBorder(),
    );
  }
}
