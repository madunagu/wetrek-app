import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/notification_repository.dart';
import 'package:wetrek/widgets/widgets.dart';

import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => NotificationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Notifications',
        rightIcon: Icons.search,
      ),
      body: BlocProvider(
        create: (BuildContext context) => SearchBloc(
          repository: NotificationRepository(
              RepositoryProvider.of<AuthenticationRepository>(context).token!),
        )..add(SearchFetched()),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
          child: NotificationList(),
        ),
      ),
    );
  }
}

class NotificationList extends StatefulWidget {
  NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<Message> messages = [];

  final _scrollController = ScrollController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _searchBloc.add(SearchFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void onSearch(String query) {
    if (query.length > 3) {
      _searchBloc.add(SearchFetched(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case SearchStatus.success:
            if (state.models.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 60, top: 40),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.models.length
                    ? BottomLoader()
                    : NotificationListItem(
                        notification: state.models[index] as Message,
                      );
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

class NotificationListItem extends StatelessWidget {
  NotificationListItem({
    required this.notification
  });
  final Message notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xffF4F4F6)),
        ),
//        color: notification.readAt ? Colors.white: Color(0xff665EFF),
//        borderRadius: notification.readAt
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              notification.from.picture.small,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 112,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(notification.from.name, style: TextStyles.darkNormal),
                      Text(timeago.format(notification.createdAt), style: TextStyles.darkMinor),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  notification.message,
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
