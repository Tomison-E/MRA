import 'dart:async';
import 'dart:convert';

import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/chat/chat_providers.dart';
import 'package:mra/app/chat/data/models/chat_message.dart';
import 'package:mra/app/chat/data/models/chat_user.dart';
import 'package:mra/app/chat/domain/use_cases/use_cases.dart';
import 'package:mra/app/chat/presentation/ui/widgets/message_card.dart';
import 'package:mra/core/service_exceptions/service_exception.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/state_views/loading_state.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/extensions/dates.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatState();
}

class _ChatState extends ConsumerState<ChatScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  int page = 1;
  int limit = 10;
  String? type;
  late Map<String, ActionParams> actions = {
    "Type": ActionParams(
      MessageCardParams(
        chatMessage:
            "Hello there, to invite guests into the estate kindly select an option",
        sentByMe: false,
        optionsArgs: OptionsParams(
            selected: type,
            onSelected: (val) {
              print(val);
              type = val;
              completeAction(val);
            },
            options: ["Guest", "Dispatch", "Event"]), //todo show selected params
      ),
    ),
    "Name": ActionParams(
      MessageCardParams(
        chatMessage: "What is the name of your guest?",
        sentByMe: false,
      ),
      textInputArgs: TextInputArgs(
        keyboardType: TextInputType.text,
        hintText: "Enter the name",
        controller: _nameController,
        onPressed: (input) {
          if (validateInput(input)) {
            nextAction();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Input'),//todo proper error message
              ),
            );
          }
        },
      ),
    ),
    "NameInput": ActionParams(
      MessageCardParams(
        chatMessage: "The name of my guest is ${_nameController.text}", //todo input value
        sentByMe: true,
      ),
    ),
    "Number": ActionParams(
      MessageCardParams(
        chatMessage: "What is the phone number of your guest?",
        sentByMe: false,
      ),
      textInputArgs: TextInputArgs(
        keyboardType: TextInputType.number,
        hintText: "Enter the phone number",
        controller: _phoneController,
        onPressed: (input) {
          if (validateInput(input)) { //todo proper validation
            nextAction();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Input'), //todo proper error message
              ),
            );
          }
        },
      ),
    ),
    "Time": ActionParams(
      MessageCardParams(
        chatMessage: "What is the time duration for your event?",
        sentByMe: false,
      ),
    ),
    "Guest": ActionParams(
      MessageCardParams(
        chatMessage: "I have a guest, I would like to be granted access",
        sentByMe: true,
      ),
    ),
    "Dispatch": ActionParams(
      MessageCardParams(
        chatMessage: "I have a dispatch rider",
        sentByMe: true,
      ),
    ),
    "Event": ActionParams(
      MessageCardParams(
        chatMessage: "I have an event, i would like my guests in",
        sentByMe: true,
      ),
    )
  };

  late Node activeNode = patterns.first;

  void completeAction(String? key) {
    if (key != null) {
      activeNode =
          activeNode.nodes!.firstWhere((element) => element.name == key);
      messageTrail.value = [...messageTrail.value, actions[activeNode.name]!];
    }
    if (actions[activeNode.name]?.messageCardParams.sentByMe == true) {
      nextAction();
    }
  }

  void nextAction() {
    if (activeNode.nodes?.isNotEmpty ?? false) {
      final List<ActionParams> trails = [];
      for (var value in activeNode.nodes!) {
        activeNode = value;
        trails.add(actions[activeNode.name]!);
      }
      messageTrail.value = [...messageTrail.value, ...trails];
    }
  }

  bool validateInput(String input) => input.isNotEmpty;

  late List<Node> patterns = [
    Node(
      "Type",
      nodes: [
        Node(
          "Guest",
          nodes: [
            Node(
              "Name",
              nodes: [
                Node("NameInput"),
                Node("Number"),
              ],
            ),
          ],
        ),
        Node(
          "Dispatch",
          nodes: [
            Node(
              "Name",
              nodes: [
                Node("Number"),
              ],
            ),
          ],
        ),
        Node(
          "Event",
          nodes: [
            Node("Time"),
          ],
        ),
      ],
    ),
  ];

  late final ValueNotifier<List<ActionParams>> messageTrail =
      ValueNotifier([actions[patterns.first.name]!]);

  @override
  void initState() {
    // scrollListener();
    super.initState();
  }
/*
  void scrollListener() {
    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > nextPageTrigger) {
        getChatMessages(ref.read(chatStateProvider).value!.first.id);
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Admin'),
      ),
      body: ValueListenableBuilder<List<ActionParams>>(
          valueListenable: messageTrail,
          builder: (context, state, _) {
            final args = state.last.textInputArgs;
            return CustomScrollView(
              controller: _scrollController,
              //reverse: true,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 100.h),
                  sliver: SliverList.builder(
                    itemBuilder: (context, index) {
                      return MessageCard(
                          params: state[index].messageCardParams);
                    },
                    key: const PageStorageKey<String>('chat'),
                    itemCount: state.length,
                  ),
                ),
/*                if (args != null)
                   SliverToBoxAdapter(child: TextField(
                        scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        controller: args.controller,
                        decoration: InputDecoration(
                          hintText: args.hintText,
                          suffixIcon: IconButton(
                            highlightColor: kTransparentColor,
                            splashColor: kTransparentColor,
                            onPressed: args.onPressed,
                            icon: SvgPicture.asset(
                              kSendChatSvg,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusColor: Colors.transparent,
                        ),
                      ),
                  )*/
              ],
            );
          }),
      bottomSheet: ValueListenableBuilder<List<ActionParams>>(
          valueListenable: messageTrail,
          builder: (context, state, _) {
            final args = state.last.textInputArgs;
            if (args == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                controller: args.controller,
                onTap: () {
                  Timer(const Duration(milliseconds: 300), () {
                    _scrollController.jumpTo(85);
                  });
                },
                keyboardType: args.keyboardType,
                onSubmitted: args.onPressed,
                decoration: InputDecoration(
                    hintText: args.hintText,
                    suffixIcon: IconButton(
                      highlightColor: kTransparentColor,
                      splashColor: kTransparentColor,
                      onPressed: () => args.onPressed(args.controller.text),
                      icon: SvgPicture.asset(
                        kSendChatSvg,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusColor: Colors.transparent),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    messageTrail.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

/*class TextInput extends StatelessWidget {
  final TextInputArgs args;
  const TextInput(this.args, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      controller: args.controller,
      decoration: InputDecoration(
          hintText: args.hintText,
          suffixIcon: IconButton(
            highlightColor: kTransparentColor,
            splashColor: kTransparentColor,
            onPressed: args.onPressed,
            icon: SvgPicture.asset(
              kSendChatSvg,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusColor: Colors.transparent),
    );
  }
}*/

class TextInputArgs {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged onPressed;
  final TextInputType keyboardType;

  TextInputArgs({
    required this.hintText,
    required this.controller,
    required this.onPressed,
    required this.keyboardType,
  });
}

class ActionParams {
  final MessageCardParams messageCardParams;
  final TextInputArgs? textInputArgs;

  ActionParams(this.messageCardParams, {this.textInputArgs});
}

class Node {
  final String name;
  final List<Node>? nodes;
  Node(this.name, {this.nodes});
}
