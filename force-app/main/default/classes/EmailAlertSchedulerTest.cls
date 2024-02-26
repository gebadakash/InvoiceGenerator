@isTest
public class EmailAlertSchedulerTest {
    static testMethod void testScheduler()
    {
        Test.startTest();
        EmailAlertScheduler emailSch=new EmailAlertScheduler();
        String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, emailSch );
        Test.stopTest();
    }

}