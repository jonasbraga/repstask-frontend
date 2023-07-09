import 'dart:async';


import 'package:reptask/models/trask_filters_model.dart';

StreamController<TaskFilterModel> refreshTaskPageStream =
    StreamController.broadcast();
StreamController<void> refreshTaskDetailsStream = StreamController.broadcast();
StreamController refreshUserPageStream = StreamController.broadcast();
StreamController refreshRewardsPageStream = StreamController.broadcast();
