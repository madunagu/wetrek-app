import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/message_repository.dart';
import 'package:wetrek/widgets.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Messages',
        rightIcon: Icons.search,
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            ListBloc(repository: MessageRepository())..add(ListFetched()),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          child: MessageList(),
        ),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  MessageList({Key? key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
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
    if (query.length > 3) {
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
          //TODO: design widget for this particular function
          //let the popups be for other exceptions
          return Center(
            child: Text('fetch failed'),
          );
        }
        if (state is ListSuccess) {
          if (state.models.isEmpty) {
            return Center(
              child: Text('no messages'),
            );
          }
          return this.chatMessages(state.models);
        }
        return Container();
      },
    );
  }

  Widget chatMessages(messages) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          for (var i = 0; i < messages.length; i++)
            MessageListItem(
              message: messages[i].message,
              user: messages[i].from,
            ),
        ],
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  MessageListItem({
    required this.user,
    required this.message,
    this.isNew = false,
  });
  final User user;
  final String message;
  final bool isNew;

  factory MessageListItem.random() {
    return MessageListItem(
      user: User(
        name: 'Madunagu Ekene',
        email: 'ekenemadunagu@gmail.com',
        avatar: '',
      ),
      message: 'If you\'re offered a seat on a rocket ship',
      isNew: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xffF4F4F6)),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              user.avatar,
              width: 62,
              height: 62,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 126,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(user.name, style: TextStyles.darkNormal),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffff4f9a),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  message,
                  style: TextStyles.base.copyWith(
                    color: Color(0xff78849E),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
