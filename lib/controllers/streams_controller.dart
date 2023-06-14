import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

StreamController<List<bool>?> refreshTaskPageStream =
    StreamController.broadcast();
// StreamController<List<bool>?> refreshTaskPageStream = StreamController();
StreamController refreshUserPageStream = StreamController.broadcast();
