import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/screens/profile_screen.dart';
import 'package:wetrek/widgets/widgets.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Users',
        rightIcon: Icons.filter_list,
      ),
      body: BlocProvider<ListBloc>(
        create: (context) => ListBloc(repository: UserRepository()),
        child: UserList(),
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
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [for (User user in treks) SingleUser(user: user)],
        ),
      ),
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
              child: Image.asset(
                user.avatar,
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
          FollowButton('Follow'),
        ],
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  FollowButton(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 32,
        alignment: Alignment.center,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff665EFF),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 17 / 13,
          ),
        ),
      ),
    );
  }
}
