import 'package:hive/hive.dart';
import 'package:leave_application/core/fixture_reader.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'leave_data_test_helper.mocks.dart';

@GenerateMocks([Box])
class LocalLeaveDataTestHelper {
  final MockBox mockBox = MockBox();

  final List<Map<String, dynamic>> leaveApplicationsMap =
      (fixtureAsMap('leave_applications.json')['data']['leave_applications'] as List<dynamic>)
          .map((rawLeaveApplication) => rawLeaveApplication as Map<String, dynamic>)
          .toList();

  //region Fetch Leave Applications
  void setUpFetchSuccess() {
    when(mockBox.values).thenReturn(leaveApplicationsMap);
  }

  void setUpFetchNull() {
    when(mockBox.values).thenReturn([]);
  }

  void setUpFetchFailure() {
    when(mockBox.values).thenThrow(Exception());
  }
//endregion

  //region Apply Leave
  void setUpApplySuccess() {
    when(mockBox.put(any, any)).thenAnswer((_) => Future.value());
  }

  void setUpApplyFailure() {
    when(mockBox.put(any, any)).thenThrow(Exception());
  }
//endregion

  //region Delete Leave
  void setUpDeleteSuccess() {
    when(mockBox.delete(any)).thenAnswer((_) => Future.value());
  }

  void setUpDeleteFailure() {
    when(mockBox.delete(any)).thenThrow(Exception());
  }
//endregion

  //region Update Leave
  void setUpUpdateSuccess() {
    when(mockBox.put(any, any)).thenAnswer((_) => Future.value());
  }

  void setUpUpdateFailure() {
    when(mockBox.put(any, any)).thenThrow(Exception());
  }
//endregion
}
