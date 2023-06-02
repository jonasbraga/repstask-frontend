import 'dart:async';

import 'package:reptask/models/trask_filters_model.dart';

StreamController<TaskFilterModel> refreshTaskPageStream = StreamController();
StreamController<void> refreshTaskDetailsStream = StreamController.broadcast();
