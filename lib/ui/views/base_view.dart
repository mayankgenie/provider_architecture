import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

/// A widget that abstracts away the boiler plate of [ChangeNotifierProvider]
/// boilerplate
///   - Provides a convenient method to run code when the view is rendered
class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
