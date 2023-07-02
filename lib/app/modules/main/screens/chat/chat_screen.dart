import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../models/models.dart';
import '../../../../../resources/resources.dart';
import '../../../../app.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    this.data,
  });

  final Map? data;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Res.appTheme.getThemeMode() == ThemeMode.dark;

    Widget senderWidget(Message message) {
      return Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.25,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Res.colors.tabIndicatorColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message.message ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              message.time != null
                  ? DateTimeUtils.getTimeFromMillis(message.time!)
                  : '',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      );
    }

    Widget receiverWidget(Message message) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.25,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Res.colors.tabIndicatorColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message.message ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              message.time != null
                  ? DateTimeUtils.getTimeFromMillis(message.time!)
                  : '',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      );
    }

    return BlocProvider(
      create: (context) => ChatCubit(
        context,
        data: data,
      ),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();

          Widget messageWidget({required Message message}) {
            return message.senderId == cubit.senderId
                ? senderWidget(message)
                : receiverWidget(message);
          }

          return GestureDetector(
            onTap: Helpers.unFocus,
            child: Scaffold(
              backgroundColor: darkMode
                  ? Res.colors.backgroundColorDark
                  : Res.colors.backgroundColorLight2,
              appBar: AppBar(
                leading: InkWell(
                  onTap: cubit.back,
                  child: SvgPicture.asset(
                    Res.drawable.back,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                title: Text(
                  state.receiverName ?? 'User Name',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              body: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: cubit.getMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        cubit.messagesScrollController.animateTo(
                          // moveTo(position) - specific
                          cubit.messagesScrollController.position
                              .maxScrollExtent,
                          duration: const Duration(microseconds: 250),
                          curve: Curves.easeOut,
                        );
                      });

                      return Flexible(
                        child: ListView.separated(
                          controller: cubit.messagesScrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36.0,
                            vertical: 16.0,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16.0,
                            );
                          },
                          itemBuilder: (context, index) {
                            return messageWidget(
                              message: Message.fromFromMap(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Res.colors.whiteColor,
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: cubit.messageController,
                              decoration: InputDecoration(
                                hintText: Res.string.enterYourMessage,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: state.isTyping,
                            child: IconButton(
                              onPressed:
                                  state.sending ? null : cubit.sendMessage,
                              icon: state.sending
                                  ? Center(
                                      child: SizedBox(
                                        height: 16.0,
                                        width: 16.0,
                                        child: CircularProgressIndicator(
                                          color: Res.colors.materialColor,
                                        ),
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      Res.drawable.send,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
