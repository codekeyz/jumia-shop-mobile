import 'package:flutter/material.dart';
import 'package:jumia_shop/widgets/loader/loader_controller.dart';
import 'package:jumia_shop/widgets/loader/loader_view.dart';

enum LoaderState { showing, hidden }

class LoaderData {
  final LoaderState state;
  final String? message;

  const LoaderData({
    required this.state,
    this.message,
  });
}

class LoaderScreen extends StatefulWidget {
  final Widget child;

  const LoaderScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationCtrl;

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loaderCtrl = LoaderController.of(context)
      ..withController(animationCtrl);
    return StreamBuilder<LoaderData>(
      builder: (_, snap) {
        final data = snap.data;
        final _loading = data?.state == LoaderState.showing;
        return Stack(
          children: [
            widget.child,
            if (_loading)
              LoaderView(
                controller: animationCtrl,
                message: data?.message,
              ),
          ],
        );
      },
      stream: loaderCtrl.stream,
      initialData: loaderCtrl.lastEvent,
    );
  }

  @override
  void dispose() {
    animationCtrl.dispose();
    super.dispose();
  }
}
