import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/core/fixture_reader.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:leave_application/features/leave_application/data/local_leave_ds.dart';
import 'package:mockito/mockito.dart';
import 'test_helper/leave_data_test_helper.dart';

void main() {
  late LocalLeaveDataTestHelper testHelper;
  late LocalLeaveDSImpl localLeaveDs;

  setUp(() {
    testHelper = LocalLeaveDataTestHelper();
    localLeaveDs = LocalLeaveDSImpl(testHelper.mockBox);
  });

  group("Fetch Leave Applications", () {
    test("get() method should be called from hive box object", () {
      testHelper.setUpFetchSuccess();
      localLeaveDs.fetchLeaveApplications();
      verify(testHelper.mockBox.values);
    });

    test("Returns null when nothing is stored", () {
      testHelper.setUpFetchNull();
      expect(localLeaveDs.fetchLeaveApplications(), null);
    });

    test("Should return List<LeaveApplicationModel> on fetch success", () {
      testHelper.setUpFetchSuccess();
      List<LeaveApplicationModel>? leaveApplications = localLeaveDs.fetchLeaveApplications();
      expect(leaveApplications,
          testHelper.leaveApplicationsMap.map((e) => LeaveApplicationModel.fromMap(e)).toList());
    });

    test("Exception should be thrown on fetch failure", () {
      testHelper.setUpFetchFailure();
      expect(() => localLeaveDs.fetchLeaveApplications(), throwsException);
    });
  });

  group("Apply Leave", () {
    test("put() method should be called from hive box instance", () async {
      testHelper.setUpApplySuccess();
      await localLeaveDs.applyLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(testHelper.mockBox.put(any, any));
    });

    test("should throw exception when put() method throws exception", () async {
      testHelper.setUpApplyFailure();
      expect(
          () async => await localLeaveDs
              .applyLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });

  group("Delete Leave", () {
    test("delete() method should be called from hive box instance", () async {
      testHelper.setUpDeleteSuccess();
      await localLeaveDs.deleteLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(testHelper.mockBox.delete('2022-03-09 00:00:00.000'));
    });

    test("Exception should be thrown when put() method is called", () {
      testHelper.setUpDeleteFailure();
      expect(
          () async => await localLeaveDs
              .deleteLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });

  group("Update Leave", () {
    test("put() method should be called from hive box instance", () async {
      testHelper.setUpUpdateSuccess();
      await localLeaveDs.updateLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(testHelper.mockBox.put(any, any));
    });

    test("should throw exception when put() method throws exception", () async {
      testHelper.setUpUpdateFailure();
      expect(
          () async => await localLeaveDs
              .updateLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });
}
