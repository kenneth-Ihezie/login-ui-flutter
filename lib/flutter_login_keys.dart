/*
This file will contain keys which will use to uniquely identify important
widgets. we can later write test that find widgets based on keys.
We will refernce this keys throughtout this project.
 */

import 'package:flutter/cupertino.dart';

class FlutterLoginKeys{
  static final extraActionsPopupMenuButton =
      const Key('__extraActionsPopupMenuButton__');
  static final extraActionEmptyContainer =
      const Key('__extraActionEmptyContainer__');
  static final filteredLoginEmptyContainer =
      const Key('__filteredLoginEmptyContainer__');
  static final statsLoadInProgressIndicator =
      const Key('__statsLoadInProgressIndicator__');
  static final emptyStatsContainer =
      const Key('__emptyStatsContainer__');
  static final emptyDetailsContainer =
      const Key('__emptyDetailsContainer__');
  static final detailsScreenCheckBox =
      const Key('__detailsScreenCheckBox__');
}
