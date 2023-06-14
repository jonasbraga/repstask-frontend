import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:reptask/models/trask_filters_model.dart';

StreamController<TaskFilterModel> refreshTaskPageStream = StreamController();
StreamController<void> refreshTaskDetailsStream = StreamController.broadcast();
StreamController refreshUserPageStream = StreamController();
