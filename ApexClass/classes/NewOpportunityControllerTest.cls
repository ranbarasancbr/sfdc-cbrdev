@isTest
public class NewOpportunityControllerTest{
    @isTest
    public static void unitTest(){
    PageReference pageRef = Page.NewOpportunity;
        Account acc  = new Account();
        acc.Name = 'test';
        insert acc;
        
        Contact con = new Contact();
        con.firstname = 'Test 12';
        con.Lastname = 'test';
        con.AccountId = acc.Id;
        insert con;
        
        test.startTest();
        Opportunity oppObj1 = New Opportunity();
        oppObj1.name = 'Test1';
        oppObj1.AccountId = acc.Id;
        oppObj1.Requested_Shipping_Method__c = 'Priority Overnight';
        oppObj1.Primary_Contact__c = con.id;
        oppObj1.closeDate = system.today();
        oppobj1.Due_Date__c =  system.Today().addDays(80);
        oppobj1.StageName = 'Ask for sale (7)';
        oppobj1.Signature_Required__c = true;
        oppobj1.Saturday_Delivery__c = true;
        oppobj1.of_Babies__c = 'Twins';
        oppobj1.PickUp_or_Ship_Kit__c = 'Ship';
        oppobj1.Requested_Shipping_Date__c = null;
        Insert oppObj1;
        test.stopTest();
        
        OpportunityContactRole ocr = new OpportunityContactRole();
        ocr.ContactId = con.Id;
        ocr.OpportunityId = oppObj1.Id;
        insert ocr;
        
        
        NewOpportunityController.checkOpportunityOnContact(con.id);
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('conid',con.id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        NewOpportunityController newOppObj = New NewOpportunityController(sc);
        newOppObj.saveOpportunity();
        
    }
    
}