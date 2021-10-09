import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/chat.bloc.dart';
import 'package:wetrek/blocs/events/chat.event.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/chat.state.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/messagable.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/message_repository.dart';
import 'package:wetrek/repositories/socket_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  static MaterialPageRoute route(Messagable to) {
    return MaterialPageRoute(
      builder: (context) => ChatScreen(to: to),
    );
  }

  ChatScreen({required this.to});
  final Messagable to;

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   late final String token;
//   late final SocketRepository socketRepository;

  // @override
  // void initState() {
  //   token = RepositoryProvider.of<AuthenticationRepository>(context).token!;
  //   socketRepository = RepositoryProvider.of<SocketRepository>(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatBloc(
        repository: MessageRepository(
            RepositoryProvider.of<AuthenticationRepository>(context).token!),
        socketRepository: RepositoryProvider.of<SocketRepository>(context),
        params: Parameters(id: to.id, where: {'isGroup': to.isGroup}),
      )..add(ChatFetched()),
      child: Scaffold(
        appBar: MyAppBar(
          title: to.name,
          rightIcon: Icons.search,
          hasSearch: false,
        ),
        bottomSheet: ChatTextInput(
          to: to,
        ),
        body: Container(
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
  late final ChatBloc _chatBloc;
  late final User me;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _chatBloc = BlocProvider.of<ChatBloc>(context);

    me = BlocProvider.of<AuthenticationBloc>(context).state.user!;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _chatBloc.add(ChatFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void onSearch(String query) {
    if (query.length > 0) {
      _chatBloc.add(ChatFetched(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          switch (state.status) {
            case ChatStatus.failure:
              return const Center(child: Text('failed to fetch posts'));
            case ChatStatus.success:
              if (state.models.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return ListView.separated(
                reverse: true,
                padding: EdgeInsets.only(bottom: 60, top: 40),
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.models.length
                      ? BottomLoader()
                      : ChatItem(
                          message: state.models[index] as Message,
                          size: size,
                          isSender:
                              me.id == (state.models[index] as Message).to.id,
                        );
                },
                separatorBuilder: (BuildContext context, int index) {
                  Message message = state.models[index] as Message;
                  Message messageBefore =
                      state.models[index > 0 ? index - 1 : index] as Message;
                  if (index > 0 &&
                      message.createdAt.difference(messageBefore.createdAt) >
                          Duration(days: 1))
                    return ChatDateChanged(message.createdAt);
                  return Container();
                },
                itemCount: state.hasReachedMax
                    ? state.models.length
                    : state.models.length + 1,
                controller: _scrollController,
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

//  List<Widget> chatMessages(List<Model> messages) {
//    messages as List<Message>;
//    Random r = Random();
//    Size size = MediaQuery.of(context).size;
//    return [
//      for (var i = 0; i < messages.length; i++)
//        if (i > 0 &&
//            messages[i].createdAt.difference(messages[i - 1].createdAt) >
//                Duration(days: 1))
//          ChatDateChanged(messages[i].createdAt),
//      for (var i = 0; i < messages.length; i++)
//        ChatItem(
//          size: size,
//          message: messages[i],
//          isSender: r.nextBool(),
//        ),
//      ImageChatItem(image: 'images/sushi.jpg'),
//    ];
//  }
}

class ChatTextInput extends StatefulWidget {
  ChatTextInput({required this.to});
  final Messagable to;
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
        'to': widget.to.id,
        'is_group': widget.to.isGroup,
      });
      setState(() {
        isSending = false;
        controller.text = '';
      });
    } catch (e, _) {
      setState(() {
        isSending = false;
      });
      print(e);
      print(_);
      catchExceptions(e);
    }
  }

  catchExceptions(e) {
    List<String> _m = ['ERROR OCCURRED', 'Could not Send Message'];
    if (e is MyException) _m[1] = e.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) => ErrorPopup(
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
  ChatItem({
    required this.message,
    required this.size,
    this.isSender = false,
  });
  final isSender;
  final Message message;
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
                message.message,
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
                child: Image.network(
                  message.from.picture.small,
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
