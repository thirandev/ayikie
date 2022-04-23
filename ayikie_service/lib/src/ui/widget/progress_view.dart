import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app_colors.dart';


class ProgressView extends StatefulWidget {
  final _ProgressViewState _progressViewState = _ProgressViewState();

  ProgressView();

  @override
  State<StatefulWidget> createState() {
    return _progressViewState;
  }
}

class _ProgressViewState extends State<ProgressView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      color: Colors.transparent,
      child: SizedBox(
        width: 60,
        height:  60,
        child: SpinKitThreeBounce(
            color: AppColors.primaryButtonColor, size: 30),
      ),
    );
  }
}
