import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/widgets.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Marie',
        rightIcon: Icons.search,
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            ListBloc(repository: TrekRepository())..add(ListFetched()),
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
  List<dynamic> items = [];

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is ListInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ListFailure) {
          return Center(
            child: Text('failed to fetch devotionals'),
          );
        }
        if (state is ListSuccess) {
          if (state.models.isEmpty) {
            return Center(
              child: Text('no devotionals'),
            );
          }
          return this.chatMessages(context);
        }
        return Container();
      },
    );
  }

  Widget chatMessages(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ChatItem(
            message:
                'The person who says it cannot be done should not interrupt the person who is doing it.',
            user: User(name: 'Marie',email: "something", avatar: 'images/avatar1.jpg'),
          ),
          ChatItem(
            message:
                'Remember that not getting what you want is sometimes a wonderful stroke of luck. ',
            user: User(name: 'Marie',email:'something', avatar: 'images/avatar1.jpg'),
            isSender: true,
          ),
          ChatDateChanged(),
          ChatItem(
            message: 'You can\'t use us creativity',
            user: User(name: 'Marie',email: 'something', avatar: 'images/avatar2.jpg'),
          ),
          ImageChatItem(image: 'images/sushi.jpg'),
        ],
      ),
    );
  }
}

class ChatTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
//        boxShadow: [BoxShadow()],
      ),
      child: Row(
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Say something...',
                hintStyle:
                    TextStyles.base.copyWith(color: WeTrekColors.darkPurple1)),
          ),
          Container(
            height: 1,
            color: Color(0xffF4F4F6),
          ),
          Icon(
            Icons.add,
            color: Color(0xff454F63),
          )
        ],
      ),
    );
  }
}

class ChatDateChanged extends StatelessWidget {
  const ChatDateChanged({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 14),
        Text('YESTERDAY, 7:43 PM', style: TextStyles.darkMinor),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(image, width: 283),
    );
  }
}

class ChatItem extends StatelessWidget {
  ChatItem({required this.message, required this.user, this.isSender = false});
  final isSender;
  final String message;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Container(
            alignment: isSender ? Alignment.topRight : Alignment.topLeft,
            child: Container(
              width: 283,
              margin: EdgeInsets.only(
                left: 16,
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
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(user.avatar),
              ),
            ),
          )
        ],
      ),
    );
  }
}
