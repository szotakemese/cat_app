import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widgets.dart';

class CatsList extends StatefulWidget {
  CatsList();

  @override
  _CatsListState createState() => _CatsListState();
}

class _CatsListState extends State<CatsList> {
  final _scrollController = ScrollController();
  int page = 0;
  late CatAppCubit _catAppCubit;

  _CatsListState();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    _catAppCubit = context.read<CatAppCubit>();
  }

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<CatAppCubit, CatAppState>(
      builder: (context, state) {
        switch (state.status) {
          case CatAppStatus.failure:
            return const Center(
              child: Text('Failed to fetch Cats'),
            );
          case CatAppStatus.succes:
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
                        cat: state.cats[index],
                        onCatsScreen: true,
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
    if (_isBottom && !_catAppCubit.state.isLoading) {
      page += 1;
      _catAppCubit..loadMoreCats(page);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
