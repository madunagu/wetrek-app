import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/messagable.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/message_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/screens/chat_screen.dart';
import 'package:wetrek/screens/users_screen.dart';
import 'package:wetrek/widgets/widgets.dart';

class ChatsScreen extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => ChatsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchBloc(
          repository: MessageRepository(
              RepositoryProvider.of<AuthenticationRepository>(context).token!))
        ..add(SearchFetched()),
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Chats',
          rightIcon: Icons.search,
          hasSearch: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          child: MessageList(),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).push(UsersScreen.route());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff5773FF),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 52,
            height: 52,
            child: Icon(Icons.add, color: Colors.white, size: 24),
          ),
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
  final _scrollController = ScrollController();
  late final SearchBloc _searchBloc;
  late final User me;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchBloc = context.read<SearchBloc>();
    me = BlocProvider.of<AuthenticationBloc>(context).state.user!;
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _searchBloc.add(SearchFetched());
  }

  void refresh() {
    _searchBloc.add(SearchFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Widget makeItem(Message m, Size size) {
    return MessageListItem(
      message: m,
      size: size,
      reciever: me.id == m.from.id ? m.to : m.from,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.failure:
            return Center(child: RefreshButton(onClick: refresh));
          case SearchStatus.success:
            if (state.models.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.models.length
                    ? BottomLoader()
                    : makeItem(state.models[index] as Message, size);
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
    );
  }
}

class MessageListItem extends StatelessWidget {
  MessageListItem({
    required this.message,
    required this.size,
    required this.reciever,
    this.isNew = false,
  });
  final Message message;
  final bool isNew;
  final Size size;
  final Messagable reciever;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, ChatScreen.route(reciever));
      },
      child: Container(
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
              child: Image.network(
                reciever.picture.small,
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
                        Text(reciever.name, style: TextStyles.darkNormal),
                        (message.messageCount != null &&
                                message.messageCount! > 0)
                            ? Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffff4f9a),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    width: MediaQuery.of(context).size.width - 126,
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: message.message,
                        style: TextStyles.base.copyWith(
                          color: Color(0xff78849E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
