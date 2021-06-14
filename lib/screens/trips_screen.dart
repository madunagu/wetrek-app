import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/trek_screen.dart';
import '../widgets/widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';
import 'package:wetrek/widgets/map_widgets.dart';

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen>
    with SingleTickerProviderStateMixin {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  late final TabController tabController;
//  RefreshController _refreshController =
//      RefreshController(initialRefresh: false);
  @override
  initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
//    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
//    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Trips',
        child: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xfff4f4f6)))),
          child: MyTabBar(tabController: tabController),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          BlocProvider<ListBloc>(
              create: (context) => ListBloc(repository: TrekRepository()),
              child: TrekList(),),
          SingleChildScrollView(
            child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//                  SingleTrek(),
//                  SingleTrek(),
//                  SingleTrek(),
//                  SingleTrek(),
//                  SingleTrek(),
                ],
              ),
            ),
          ),
        ],
      ),
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
  final _scrollThreshold = 200.0;
  late ListBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<ListBloc>(context);
    _postBloc.add(ListFetched());
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
      _postBloc.add(ListFetched(query: query));
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
          return this.listTreks(state.models);
        }
        return Container();
      },
    );
  }

  Widget listTreks(treks) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [for (Trek trek in treks) SingleTrek(trek: trek)],
        ),
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

class _MyTabBarState extends State<MyTabBar> {
  @override
  void initState() {
    // TODO: implement initState
    widget.tabController.addListener(() {
//      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      indicator: BlueDashGradientDecoration(height: 6),
      labelPadding: EdgeInsets.all(0),
      onTap: (int i) {
//        widget.tabController
//            .animateTo(i, duration: Duration(seconds: 2));
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
          trek.startingAt.toString(),
          style: TextStyles.darkMinor.copyWith(
            color: Color(0x9278849E),
          ),
        ),
        SizedBox(height: 12),
        LocationPairCard(
          trek: trek,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrekScreen(trek: TrekRepository.dummy()),
              ),
            );
          },
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
