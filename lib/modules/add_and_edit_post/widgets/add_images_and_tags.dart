import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_social_app/modules/add_and_edit_post/cubit/cubit.dart';
import '../../../shared/styles/icon_broken.dart';
import '../cubit/states.dart';

class AddImagesAndTags extends StatelessWidget {
  const AddImagesAndTags({super.key});

  static List<String> tags = [];
  static TextEditingController tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = EditPostsCubit.get(context);
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              cubit.getPostImage(context);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconBroken.Image),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'add photos',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              tagsController.clear();
              tagsBottomSheet(context);
            },
            child: const Text(
              '# Tags',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

void tagsBottomSheet(
  context,
) =>
    showModalBottomSheet(
      backgroundColor: HexColor('#090B0B'),
      enableDrag: true,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 700),
      ),
      context: context,
      builder: (context) {
        return BlocConsumer<EditPostsCubit, EditPostsStates>(
          listener: (context, state) {},
          builder: (context, state) => Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .75,
                child: Column(
                  children: [
                    Text(
                      'tags',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 20),
                    ),
                    if (AddImagesAndTags.tags.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          children: List.generate(
                            AddImagesAndTags.tags.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child:
                                            Text(AddImagesAndTags.tags[index])),
                                    InkWell(
                                      child: const Icon(
                                        Icons.highlight_remove_outlined,
                                        size: 20,
                                      ),
                                      onTap: () {
                                        EditPostsCubit.get(context)
                                            .removeTag(index);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              EditPostsCubit.get(context).addToTags(
                                AddImagesAndTags.tagsController.text,
                              );
                            }
                          },
                          controller: AddImagesAndTags.tagsController,
                          decoration: InputDecoration(
                            hintText: 'enter tag',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 18),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(.2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (AddImagesAndTags.tagsController.text.isNotEmpty) {
                            EditPostsCubit.get(context).addToTags(
                              AddImagesAndTags.tagsController.text,
                            );
                          }
                        },
                        child: const Text(
                          'add',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
