import 'package:cat_app/blocs/cats_list/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list_item.dart';

import 'package:cat_app/blocs/cats_list/all_cats_list_bloc.dart';
import 'package:cat_app/blocs/cats_list/cats_event.dart';
import 'package:cat_app/widgets/widgets.dart';

// class CatsList extends StatelessWidget {
//   final state;
//   const CatsList(this.state);
//   @override
//   Widget build(BuildContext context) {
//     return state.cats.length == 0
//         ? Center(
//             child: Text('Cats List is empty'),
//           )
//         : ListView.builder(
//             itemCount: state.cats.length,
//             itemBuilder: (context, index) {
//               return ListItem(
//                 key: Key(
//                   index.toString(),
//                 ),
//                 state: state,
//                 index: index,
//                 listType: state.cats,
//               );
//               // return ListItem(key: Key(index.toString()), state: state, index: index,);
//             },
//           );
//   }
// }

class CatsList extends StatefulWidget {
  CatsList();

  @override
  _CatsListState createState() => _CatsListState();
}

class _CatsListState extends State<CatsList> {
  final _scrollController = ScrollController();
  int page = 0;
  late AllCatsListBloc _allCatsListBloc;

  _CatsListState();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    _allCatsListBloc = context.read<AllCatsListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCatsListBloc, CatsState>(
      builder: (context, state) {
        switch (state.status) {
          case CatsStatus.failure:
            return const Center(
              child: Text('Failed to fetch Cats'),
            );
          case CatsStatus.succes:
            if (state.cats.isEmpty) {
              return const Center(
                child: Text('Cats List is empty'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.cats.length
                    ? BottomLoader()
                    : ListItem(
                        key: Key(
                          index.toString(),
                        ),
                        state: state,
                        index: index,
                        listType: state.cats,
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.cats.length
                  : state.cats.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_allCatsListBloc.state.isLoading) {
      page += 1;
      _allCatsListBloc.add(LoadMoreCats(page));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
