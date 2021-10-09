import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/models/where.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/trek_screen.dart';
import 'package:wetrek/widgets/widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';
import 'package:wetrek/widgets/map_widgets.dart';

import 'package:timeago/timeago.dart' as timeago;

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => TripsScreen(),
    );
  }
}

class _TripsScreenState extends State<TripsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
          repository: TrekRepository(
              RepositoryProvider.of<AuthenticationRepository>(context).token!)),
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Trips',
          rightIcon: Icons.search,
          hasSearch: true,
          child: MyTabBar(tabController: tabController),
        ),
        body: TrekList(),
      ),
    );
  }
}

class MyTabBar extends StatefulWidget {
  const MyTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>  {
  late final SearchBloc _searchBloc;
  initState() {
    _searchBloc = context.read<SearchBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding: EdgeInsets.all(0),
      indicator: BlueDashGradientDecoration(height: 6),
      unselectedLabelColor: Color(0xff959DAD),
      labelColor: Color(0xff454F63),
      controller: widget.tabController,
      onTap: (int i) {
        widget.tabController
            .animateTo(i, duration: Duration(milliseconds: 500));
        if (i > 0) {
          _searchBloc.add(
            SearchFetched(conditions: [Where(column: 'p', val: 'anything')]),
          );
        } else {
          _searchBloc.add(SearchFetched());
        }
      },
      tabs: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Color(0xfff4f4f6)),
            ),
          ),
          child: Tab(
              child: Text(
            'UPCOMING',
            style: TextStyles.tab,
          )),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Color(0xfff4f4f6)),
            ),
          ),
          child: Tab(
              child: Text(
            'HISTORY',
            style: TextStyles.tab,
          )),
        ),
      ],
    );
  }
}

class TrekList extends StatefulWidget {
  const TrekList({
    Key? key,
  }) : super(key: key);

  @override
  _TrekListState createState() => _TrekListState();
}

class _TrekListState extends State<TrekList> {
  final _scrollController = ScrollController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    _searchBloc = context.read<SearchBloc>();
    _searchBloc.add(SearchFetched());
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
    _searchBloc.add(SearchFetched(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xffF7F7FA),
          ],
        ),
      ),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          switch (state.status) {
            case SearchStatus.failure:
              return const Center(child: Text('failed to fetch posts'));
            case SearchStatus.success:
              if (state.models.isEmpty) {
                return const Center(child: Text('no posts'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.models.length
                      ? BottomLoader()
                      : SingleTrek(trek: state.models[index] as Trek);
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
}

class SingleTrek extends StatelessWidget {
  const SingleTrek({
    Key? key,
    required this.trek,
  }) : super(key: key);
  final Trek trek;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          readableTime(trek.startingAt),
          style: TextStyles.darkMinor.copyWith(
            color: Color(0x9278849E),
          ),
        ),
        SizedBox(height: 12),
        TrekCard(
          trek: trek,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrekScreen(trek: trek),
              ),
            );
          },
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

List<String> kMonths = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

String readableTime(DateTime time) {
  DateTime timeNow = DateTime.now();
  String result = '';
  if (timeNow.difference(time) > Duration(days: 365)) result += "${time.year} ";
  if (timeNow.difference(time) > Duration(days: 10))
    result += "${kMonths[time.month - 1]} ${time.day}";
  else
    return timeago.format(time);
  return result;
}
