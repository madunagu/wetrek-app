import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/index.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/notification_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/splash_screen.dart';
import 'package:wetrek/screens/trek_screen.dart';
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
        color: Color(0xff2A2E43),
        fontColor: Colors.white,
      ),
      body: BlocProvider(
        create: (BuildContext context) => SearchBloc(
          repository: NotificationRepository(
              RepositoryProvider.of<AuthenticationRepository>(context).token!),
        )..add(SearchFetched()),
        child: Container(
          color: Color(0xff2A2E43),
          width: MediaQuery.of(context).size.width,
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
                        notification:
                            state.models[index] as NotificationContainer,
                        seenPrevious: index == 0 ||
                            index > 0 &&
                                (state.models[index - 1]
                                            as NotificationContainer)
                                        .readAt !=
                                    null,
                        seenNext: index >= state.models.length - 1 ||
                            index + 1 < state.models.length - 1 &&
                                (state.models[index + 1]
                                            as NotificationContainer)
                                        .readAt !=
                                    null,
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

class NotificationListItem extends StatefulWidget {
  NotificationListItem({
    required this.notification,
    required this.seenNext,
    required this.seenPrevious,
  });
  final NotificationContainer notification;
  final bool seenNext;
  final bool seenPrevious;

  @override
  _NotificationListItemState createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  openNotification() async {
    String token =
        RepositoryProvider.of<AuthenticationRepository>(context).token!;
    switch (widget.notification.data.objectType) {
      case 'trek':
        Navigator.push(context, SplashScreen.route());

        Trek trek =
            await TrekRepository(token).get(widget.notification.data.objectId);
        Navigator.pop(context);
        Navigator.push(
          context,
          TrekScreen.route(trek),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: openNotification,
      child: Container(
        width: size.width,
        height: 111,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: 111,
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Container(
                    height: 111,
                    width: 48,
                  ),
                  Expanded(
                    child: Container(
                      height: 111,
                      width: size.width - 68,
                      decoration: BoxDecoration(
                        color: widget.notification.readAt != null
                            ? Colors.transparent
                            : Color(0xff665EFF),
                        borderRadius: BorderRadius.only(
                          topLeft: widget.seenPrevious
                              ? Radius.circular(16)
                              : Radius.zero,
                          bottomLeft: widget.seenNext
                              ? Radius.circular(16)
                              : Radius.zero,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.notification.data.messagable.picture.small,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: MediaQuery.of(context).size.width - 112,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 112,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(widget.notification.data.objectType,
                                  style: TextStyles.normal),
                              Text(
                                  timeago.format(widget.notification.createdAt),
                                  style: TextStyles.minor),
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          widget.notification.data.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.base.copyWith(
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
