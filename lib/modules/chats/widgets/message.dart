import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_social_app/shared/components.dart';
import 'package:my_social_app/shared/widgets/default_button.dart';
import 'package:my_social_app/shared/widgets/extended_image.dart';
import '../../../models/Message_model.dart';
import '../../../shared/constants/const.dart';
import '../cubit/cubit.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
    required this.index,
    required this.isSendingMessage,
  });

  final MessageModel message;
  final int index;
  final bool isSendingMessage;

  Size _textSize(
      String text, TextStyle style, double maxWidth, var textDirection) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: TextAlign.center,
      maxLines: 1,
      textDirection: textDirection,
    )..layout(minWidth: 40, maxWidth: maxWidth);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd hh:mm');
    double screenWidth = MediaQuery.of(context).size.width;
    Size textWidth = _textSize(
        message.text ?? '',
        const TextStyle(fontSize: 18),
        screenWidth * 3 / 4,
        Directionality.of(context));
    return Align(
      alignment: isSendingMessage
          ? AlignmentDirectional.topStart
          : AlignmentDirectional.topEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              ChatCubit.get(context).showMessage(index);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.messageImage != null)
                  SizedBox(
                    width: screenWidth / 3,
                    child: DefaultButton(
                      onTap: () {
                        navigateTo(
                          context: context,
                          screen: DefaultExtendedImage(url: message.messageImage!),
                        );
                      },
                      buttonWidget: Image(
                        image: CachedNetworkImageProvider(message.messageImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (message.text!.isNotEmpty)
                  Container(
                    width: textWidth.width + 10,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(10),
                        bottomLeft: const Radius.circular(10),
                        bottomRight: !isSendingMessage
                            ? const Radius.circular(10)
                            : const Radius.circular(0),
                        topLeft: isSendingMessage
                            ? const Radius.circular(10)
                            : const Radius.circular(0),
                      ),
                      color: isSendingMessage
                          ? Colors.grey.withOpacity(.4)
                          : Colors.purple.withOpacity(.4),
                    ),
                    child: Center(child: Text(message.text.toString())),
                  ),
              ],
            ),
          ),
          if (showMessageId == index)
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                dateFormat.format(message.dateTime!.toDate()),
                style: const TextStyle(fontSize: 12),
              ),
            )
        ],
      ),
    );
  }
}
