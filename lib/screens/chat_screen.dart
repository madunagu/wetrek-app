import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/message_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => ChatScreen(title: 'Group Chat'),
    );
  }

  ChatScreen({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        rightIcon: Icons.search,
      ),
      bottomSheet: ChatTextInput(
        to: 1,
      ),
      body: BlocProvider(
        create: (BuildContext context) => ListBloc(
            repository: MessageRepository(
                RepositoryProvider.of<AuthenticationRepository>(context)
                    .token!))
          ..add(ListFetched()),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ChatMessageList(),
        ),
      ),
    );
  }
}

class ChatMessageList extends StatefulWidget {
  const ChatMessageList({
    Key? key,
  }) : super(key: key);

  @override
  _ChatMessageListState createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  List<Message> messages = [];

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late ListBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<ListBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(ListFetched());
    }
  }

  void onSearch(String query) {
    if (query.length > 1) {
      _postBloc.add(ListFetched(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ListBloc, ListState>(
                builder: (context, state) {
                  if (state is ListInitial) {
                    return Container(
                      height: 100,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ListFailure) {
                    //TODO: design widget for this particular function
                    //let the popups be for other exceptions
                    return Container(
                      height: 100,
                      child: Text('fetch failed'),
                    );
                  }
                  if (state is ListSuccess) {
                    if (state.models.isEmpty) {
                      return Container(
                        height: 100,
                        child: Text('no messages'),
                      );
                    }
                    return Column(children: chatMessages(state.models));
                  }
                  return Container();
                },
              ),
            ],
          )),
    );
  }

  List<Widget> chatMessages(List<Model> messages) {
    messages as List<Message>;
    Random r = Random();
    Size size = MediaQuery.of(context).size;
    return [
      for (var i = 0; i < messages.length; i++)
        if (i > 0 &&
            messages[i].createdAt.difference(messages[i - 1].createdAt) >
                Duration(days: 1))
          ChatDateChanged(messages[i].createdAt),
      for (var i = 0; i < messages.length; i++)
        ChatItem(
          size: size,
          message: messages[i].message,
          user: messages[i].from,
          isSender: r.nextBool(),
        ),
      ImageChatItem(image: 'images/sushi.jpg'),
    ];
  }
}

class ChatTextInput extends StatefulWidget {
  ChatTextInput({required this.to, this.isGroup = false});
  final int to;
  final bool isGroup;
  @override
  _ChatTextInputState createState() => _ChatTextInputState();
}

class _ChatTextInputState extends State<ChatTextInput> {
  late final TextEditingController controller;
  bool isTyping = false;
  bool isSending = false;
  @override
  initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  submitChat() async {
    setState(() {
      isSending = true;
    });
    try {
      String token =
          RepositoryProvider.of<AuthenticationRepository>(context).token!;
      Message m = await MessageRepository(token).create({
        'message': controller.value.text,
        'to': widget.to,
      });
      setState(() {
        isSending = false;
        controller.text = '';
      });
    } catch (e, _) {
      setState(() {
        isSending = false;
      });
      catchExceptions(e);
    }
  }

  catchExceptions(e) {
    List<String> _m = ['UNKNOWN ERROR OCCURED', 'Could not Send Message'];
    if (e is ValidationErrorException) _m[0] = 'CONTENT NOT FORMATTED PROPERLY';
    if (e is ServerErrorException) _m[0] = 'SERVER ERROR OCCRED';
    if (e is AuthenticationException) _m[0] = 'USER NOT LOGGED IN';

    showDialog(
      context: context,
      builder: (BuildContext context) => NotificationPopup(
        title: _m[0],
        body: _m[1],
      ),
    );
  }

  addImage() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xff455B63),
              blurRadius: 16,
              offset: Offset(0, 12),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                maxLines: 4,
                controller: controller,
                enabled: !isSending,
                onChanged: (String t) {
                  if (t.isNotEmpty && isTyping == false) {
                    setState(() {
                      isTyping = true;
                    });
                  }
                  if (t.isEmpty && isTyping == true) {
                    setState(() {
                      isTyping = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Say something...',
                  contentPadding:
                      EdgeInsets.only(left: 24, top: 16, bottom: 16),
                  hintStyle:
                      TextStyles.base.copyWith(color: WeTrekColors.darkPurple1),
                ),
              ),
            ),
            Container(
              width: 1,
              color: Color(0xffF4F4F6),
            ),
            InkWell(
              onTap: isTyping ? submitChat : addImage,
              child: Container(
                decoration: BoxDecoration(
                  color: isTyping ? WeTrekColors.blue2 : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                width: 52,
                height: double.infinity,
                child: Icon(
                  isTyping ? Icons.send : Icons.add,
                  color: isTyping
                      ? Colors.white
                      : isSending
                          ? Colors.grey
                          : Color(0xff454F63),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatDateChanged extends StatelessWidget {
  const ChatDateChanged(
    this.dateTime, {
    Key? key,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 14),
        Text(dateTime.toString(), style: TextStyles.darkMinor),
        SizedBox(height: 11),
      ],
    );
  }
}

class ImageChatItem extends StatelessWidget {
  ImageChatItem({required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          image,
          width: 270,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  ChatItem(
      {required this.message,
      required this.user,
      required this.size,
      this.isSender = false});
  final isSender;
  final String message;
  final User user;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Container(
            alignment: isSender ? Alignment.topRight : Alignment.topLeft,
            child: Container(
              width: size.width - 104,
              margin: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 16,
              ),
              padding: EdgeInsets.only(
                left: 24,
                right: 16,
                top: 16,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSender ? WeTrekColors.darkPurple1 : WeTrekColors.blue2,
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  height: 20 / 14,
                ),
              ),
            ),
          ),
          Positioned(
            right: isSender ? 0 : null,
            left: isSender ? null : 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  user.avatar,
                  width: 28,
                  height: 28,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
