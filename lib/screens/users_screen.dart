import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/screens/profile_screen.dart';
import 'package:wetrek/widgets/widgets.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => UsersScreen(),
    );
  }
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
          repository: UserRepository(
              RepositoryProvider.of<AuthenticationRepository>(context).token!)),
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Users',
          rightIcon: Icons.search,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: UserList(),
        ),
      ),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({
    Key? key,
  }) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _scrollController = ScrollController();
  late final SearchBloc _searchBloc;

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
    if (query.length > 3) {
      _searchBloc.add(SearchFetched(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.failure:
            return const Center(child: Text('failed to fetch users'));
          case SearchStatus.success:
            if (state.models.isEmpty) {
              return const Center(child: Text('no users'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.models.length
                    ? BottomLoader()
                    : SingleUser(
                        user: state.models[index] as User,
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

class SingleUser extends StatelessWidget {
  const SingleUser({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffF4F4F6),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: user),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                user.picture.small,
                width: 48,
                height: 48,
              ),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyles.darkNormal,
              ),
              Text(
                'Nigeria',
                style: TextStyles.base.copyWith(
                  color: Color(0xff78849E),
                ),
              ),
            ],
          ),
          Spacer(),
          FollowButton(user),
        ],
      ),
    );
  }
}
