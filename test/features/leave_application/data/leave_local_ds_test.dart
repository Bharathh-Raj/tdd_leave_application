import 'package:flutter_test/flutter_test.dart';
import 'package:leave_application/core/fixture_reader.dart';
import 'package:leave_application/features/leave_application/data/leave_application_model.dart';
import 'package:mockito/mockito.dart';
import 'test_helper/leave_data_test_helper.dart';

void main() {
  late LocalLeaveDataTestHelper testHelper;

  setUp(() {
    testHelper = LocalLeaveDataTestHelper();
  });

  group("Fetch Leave Applications", () {
    test("get() method should be called from hive box object", () {
      testHelper.setUpFetchSuccess();
      testHelper.localLeaveDs.fetchLeaveApplications();
      verify(testHelper.mockBox.values);
    });

    test("Returns null when nothing is stored", () {
      testHelper.setUpFetchNull();
      expect(testHelper.localLeaveDs.fetchLeaveApplications(), null);
    });

    test("Should return List<LeaveApplicationModel> on fetch success", () {
      testHelper.setUpFetchSuccess();
      List<LeaveApplicationModel>? leaveApplications =
          testHelper.localLeaveDs.fetchLeaveApplications();
      expect(leaveApplications,
          testHelper.leaveApplicationsMap.map((e) => LeaveApplicationModel.fromMap(e)).toList());
    });

    test("Exception should be thrown on fetch failure", () {
      testHelper.setUpFetchFailure();
      expect(() => testHelper.localLeaveDs.fetchLeaveApplications(), throwsException);
    });
  });

  group("Apply Leave", () {
    test("put() method should be called from hive box instance", () async {
      testHelper.setUpApplySuccess();
      await testHelper.localLeaveDs
          .applyLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(testHelper.mockBox.put(any, any));
    });

    test("should throw exception when put() method throws exception", () async {
      testHelper.setUpApplyFailure();
      expect(
          () async => await testHelper.localLeaveDs
              .applyLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });

  group("Delete Leave", () {
    test("delete() method should be called from hive box instance", () async {
      testHelper.setUpDeleteSuccess();
      await testHelper.localLeaveDs
          .deleteLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(testHelper.mockBox.delete('1'));
    });

    test("Exception should be thrown when put() method is called", () {
      testHelper.setUpDeleteFailure();
      expect(
          () async => await testHelper.localLeaveDs
              .deleteLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });

  group("Update Leave", () {
    test("put() method should be called from hive box instance", () async {
      testHelper.setUpUpdateSuccess();
      await testHelper.localLeaveDs
          .updateLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json')));
      verify(testHelper.mockBox.put(any, any));
    });

    test("should throw exception when put() method throws exception", () async {
      testHelper.setUpUpdateFailure();
      expect(
          () async => await testHelper.localLeaveDs
              .updateLeave(LeaveApplicationModel.fromMap(fixtureAsMap('leave_01.json'))),
          throwsException);
    });
  });
}
