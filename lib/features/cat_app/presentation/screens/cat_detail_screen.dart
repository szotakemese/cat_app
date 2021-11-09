import 'package:cat_app/features/authentication/domain/entities/user.dart';
import 'package:cat_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:cat_app/features/cat_app/domain/entities/cat_app_status.dart';
import 'package:cat_app/features/cat_app/presentation/cubit/cat_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_app/features/cat_app/domain/entities/entities.dart';
import 'package:cat_app/features/cat_app/presentation/widgets/widgets.dart';

class CatDetailScreen extends StatelessWidget {
  final String catId;
  final bool onCatsScreen;

  const CatDetailScreen({
    Key? key,
    required this.catId,
    required this.onCatsScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cat cat = context
        .read<CatAppCubit>()
        .state
        .cats
        .firstWhere((element) => element.id == catId);
    final String additionalTag = onCatsScreen ? 'cat' : 'fav';
    return Scaffold(
      appBar: AppBar(
        title: Text('ID: ' + cat.id),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff006666),
              Color(0xffddff99),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff0f0f0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DetailImage(
                        additionalTag: additionalTag,
                        cat: cat,
                      ),
                      CatDetailScreenContent(cat: cat)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CatDetailScreenContent extends StatelessWidget {
  const CatDetailScreenContent({required this.cat, Key? key}) : super(key: key);
  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final User user = context.select((AuthCubit cubit) => cubit.state.user);
    final int index = context.read<CatAppCubit>().state.cats.indexOf(cat);
    return Container(
      child: BlocBuilder<CatAppCubit, CatAppState>(builder: (context, state) {
        if (state.status == CatAppStatus.loading ||
            state.status == CatAppStatus.initial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == CatAppStatus.succes) {
          return Stack(
            children: [
              CatFactWidget(
                state,
                index,
              ),
              Align(
                alignment: Alignment(0.9, 0),
                child: FloatingActionButton(
                  backgroundColor: Colors.grey[350],
                  onPressed: () {},
                  child: LikeIcon(
                    cat: cat,
                    user: user,
                    state: state,
                  ),
                ),
              ),
            ],
          );
        } else if (state.status == CatAppStatus.failure) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                'Error occured: ${state.error}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
