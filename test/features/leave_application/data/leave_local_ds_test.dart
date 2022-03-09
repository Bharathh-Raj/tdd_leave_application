import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:leave_application/core/fixture_reader.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'leave_local_ds_test.mocks.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';

@GenerateMocks([Box])
void main() {
  late LocalLeaveDSImpl localLeaveDs;
  late MockBox mockBox;

  final List<Map<String, dynamic>> leaveApplicationsMap =
      (fixtureAsMap('leave_applications.json')['data']['leave_applications'] as List<dynamic>)
          .map((rawLeaveApplication) => rawLeaveApplication as Map<String, dynamic>)
          .toList();

  setUp(() {
    mockBox = MockBox();
    localLeaveDs = LocalLeaveDSImpl(mockBox);
  });

  group("Fetch Leave Applications", () {
    const String leaveApplicationsKey = "FetchLeaveApplicationsKey";
    void setUpFetchSuccess() {
      when(mockBox.get(leaveApplicationsKey)).thenReturn(leaveApplicationsMap);
    }

    void setUpFetchNull() {
      when(mockBox.get(leaveApplicationsKey)).thenReturn(null);
    }

    void setUpFetchFailure() {
      when(mockBox.get(leaveApplicationsKey)).thenThrow(Exception());
    }

    test("get() method should be called from hive box object", () {
      setUpFetchSuccess();
      localLeaveDs.fetchLeaveApplications();
      verify(mockBox.get(leaveApplicationsKey));
    });

    test("Returns null when nothing is stored", () {
      setUpFetchNull();
      expect(localLeaveDs.fetchLeaveApplications(), null);
    });

    test("Should return List<LeaveApplicationModel> on fetch success", () {
      setUpFetchSuccess();
      List<LeaveApplicationModel>? leaveApplications = localLeaveDs.fetchLeaveApplications();
      expect(leaveApplications,
          leaveApplicationsMap.map((e) => LeaveApplicationModel.fromMap(e)).toList());
    });

    test("Exception should be thrown on fetch failure", () {
      setUpFetchFailure();
      expect(() => localLeaveDs.fetchLeaveApplications(), throwsException);
    });
  });

  group("Apply Leave", () {
    void setUpApplySuccess() {
      when(mockBox.put(any, any)).thenAnswer((_) => Future.value());
    }

    void setUpApplyFailure() {
      when(mockBox.put(any, any)).thenThrow(Exception());
    }

    test("put() method should be called from hive box instance", () async {
      setUpApplySuccess();
      await localLeaveDs.applyLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(mockBox.put(any, any));
    });

    test("should throw exception when put() method throws exception", () async {
      setUpApplyFailure();
      expect(
          () async => await localLeaveDs
              .applyLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });

  group("Delete Leave", () {
    void setUpDeleteSuccess() {
      when(mockBox.delete(any)).thenAnswer((_) => Future.value());
    }

    void setUpDeleteFailure() {
      when(mockBox.delete(any)).thenThrow(Exception());
    }

    test("delete() method should be called from hive box instance", () async {
      setUpDeleteSuccess();
      await localLeaveDs.deleteLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(mockBox.delete('1'));
    });

    test("Exception should be thrown when put() method is called", () {
      setUpDeleteFailure();
      expect(
          () async => await localLeaveDs
              .deleteLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });

  group("Update Leave", () {
    void setUpUpdateSuccess() {
      when(mockBox.put(any, any)).thenAnswer((_) => Future.value());
    }

    void setUpUpdateFailure() {
      when(mockBox.put(any, any)).thenThrow(Exception());
    }

    test("put() method should be called from hive box instance", () async {
      setUpUpdateSuccess();
      await localLeaveDs.updateLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(mockBox.put(any, any));
    });

    test("should throw exception when put() method throws exception", () async {
      setUpUpdateFailure();
      expect(
          () async => await localLeaveDs
              .updateLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });
}
