// Copyright (c) 2024 Philip Softworks. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

/// A enum that represents how the calendar can be closed.
enum CalendarDismissBehavior {
  /// The calendar will close when a tap occurs outside of it or on the action button.
  onOutsideTap,

  /// The calendar will close when a date is selected or on the action button.
  onDateSelect,

  /// The calendar will close when either a tap occurs outside of it or a date
  /// is selected or on the action button.
  onOusideTapOrDateSelect,

  /// The calendar will close when a tap occurs on the action button only.
  onActionTap;

  /// This is `true` if the behavior is either [CalendarDismissBehavior.onOutsideTap]
  /// or [CalendarDismissBehavior.onOusideTapOrDateSelect].
  bool get hasOusideTapDismiss {
    return this == CalendarDismissBehavior.onOutsideTap ||
        this == CalendarDismissBehavior.onOusideTapOrDateSelect;
  }

  /// This is `true` if the behavior is either [CalendarDismissBehavior.onDateSelect]
  /// or [CalendarDismissBehavior.onOusideTapOrDateSelect].
  bool get hasDateSelectDismiss {
    return this == CalendarDismissBehavior.onDateSelect ||
        this == CalendarDismissBehavior.onOusideTapOrDateSelect;
  }
}
