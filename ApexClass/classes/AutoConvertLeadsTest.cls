@isTest(seeAllData=true)
public class AutoConvertLeadsTest {
    
    static testMethod void convertLead(){

    
        Lead ld=new Lead();
        ld.lastName='Test';
        ld.company='Test';
        ld.FirstName='Funny';
        ld.Phone = '1234568901';
        ld.Email ='abc@gmail.com';
        ld.LeadSource = 'Online Enrollment';
        Database.insert(ld);
        List<Id> leadIds = new List<Id>{ld.Id};
        AutoConvertLeads.LeadAssign(leadIds);
    }
}