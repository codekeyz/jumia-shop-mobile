import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RefreshWrapper extends StatelessWidget {
  final Widget body;
  final Future Function() onRefresh;
  final EdgeInsets? padding;

  final ScrollController? controller;

  const RefreshWrapper({
    Key? key,
    required this.onRefresh,
    required this.body,
    this.padding,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || !Platform.isIOS) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: Scrollbar(
          controller: controller,
          child: SingleChildScrollView(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            child: body,
            padding: padding,
          ),
        ),
      );
    }

    return CupertinoScrollbar(
      controller: controller,
      child: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          CupertinoSliverRefreshControl(onRefresh: onRefresh),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: body,
              padding: padding,
              primary: false,
            ),
          ),
        ],
      ),
    );
  }
}
