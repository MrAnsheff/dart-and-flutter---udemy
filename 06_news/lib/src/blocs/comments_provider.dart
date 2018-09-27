import 'package:flutter/material.dart';
import "comments_bloc.dart";
export "comments_bloc.dart";

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc;
  final int itemId;

  CommentsProvider(this.itemId, {Widget child})
      : bloc = CommentsBloc(),
        super(child: child) {
    bloc.fetchItemWithComments(itemId);
  }

  static CommentsBloc of(BuildContext context) {
    final provider = context.inheritFromWidgetOfExactType(CommentsProvider)
        as CommentsProvider;
    return provider == null ? null : provider.bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
