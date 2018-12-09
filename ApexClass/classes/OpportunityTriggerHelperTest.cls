@isTest
public class OpportunityTriggerHelperTest{
    @isTest
    public static void TestCourier(){
        Opportunity oppobj = New Opportunity(name = 'Test1',of_Babies__c = 'Single',Requested_Shipping_Method__c = 'Courier',StageName = 'Ask for sale (7)',PickUp_or_Ship_Kit__c = 'Ship',closeDate = system.today(),status__C = 'Enrolled',Due_Date__c = system.today().addDays(2),Ship_To_Street1__c = 'Texas mst',Ship_To_City__c = 'Texas',Ship_To_State__c = 'Texas',Ship_To_Zip_Code__c = '73301',Ship_To_Phone__c = '9900990099',Shipping_Method__c = 'Priority Overnight',Requested_Shipping_Date__c = system.today(),Ship_To_Name__c = 'testName');
        Insert oppobj;
       
    }
    @isTest
    public static void unitTest(){
        //list<opportunity> oppList = New List<opportunity>();
       
        Opportunity oppobj = New Opportunity(name = 'Test1',of_Babies__c = 'Single',Requested_Shipping_Method__c = 'Priority Overnight',StageName = 'Ask for sale (7)',PickUp_or_Ship_Kit__c = 'Ship',closeDate = system.today(),status__C = 'Enrolled',Due_Date__c = system.today().addDays(2),Ship_To_Street1__c = 'Texas mst',Ship_To_City__c = 'Texas',Ship_To_State__c = 'Texas',Ship_To_Zip_Code__c = '73301',Ship_To_Phone__c = '9900990099',Shipping_Method__c = 'Priority Overnight',Requested_Shipping_Date__c = system.today(),Ship_To_Name__c = 'testName');
        
       
        Insert oppobj;
           
        Provider__c provObj = New Provider__c();
        Insert provObj;
        
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        
        Opportunity_Provider__c oppProviderObj = new Opportunity_Provider__c();
        oppProviderObj.Provider__c = provObj.Id;
        oppProviderObj.Opportunity__c = oppobj.id;
        oppProviderObj.Primary_Provider__c = true;
        oppProviderObj.Facility__c = faciObj.id;
        
        Insert oppProviderObj;
     
       
        Contact con = new contact();
        con.FirstName = 'Jhon';
        con.lastName = 'Test';
        con.Birthdate = system.today().addDays(-100);
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Jhon11';
        con1.lastName = 'Test11';
        con1.Birthdate = system.today().addDays(-150);
        insert con1;
        
        Opportunity oppObj1 = New Opportunity();
        oppObj1.name = 'Test1';
        oppObj1.Requested_Shipping_Method__c = 'Priority Overnight';
        oppObj1.Primary_Contact__c = con.id;
        oppObj1.closeDate = system.today();
        oppobj1.Due_Date__c =  system.today().addDays(80);
        oppobj1.StageName = 'Ask for sale (7)';
        oppobj1.Signature_Required__c = true;
        oppobj1.Saturday_Delivery__c = true;
        oppobj1.of_Babies__c = 'Twins';
        oppobj1.PickUp_or_Ship_Kit__c = 'Ship';
        oppobj1.Requested_Shipping_Date__c = system.today();
        oppobj1.Ship_To_Street1__c = 'Texas mst';
        oppobj1.Ship_To_Street2__c = null;
        oppobj1.Ship_To_City__c = 'Texas';
        oppobj1.Ship_To_State__c = 'Texas';
        oppobj1.Ship_To_Zip_Code__c = '73301';
       oppobj1.Ship_To_Name__c = 'Test User';
       oppobj1.Shipping_Method__c = 'Priority Overnight';
       oppobj1.Ship_To_Phone__c = '9998880099';
        Insert oppObj1;
        
        OpportunityContactRole conRoleObj = New OpportunityContactRole();
        conRoleObj.IsPrimary = true;
        conRoleObj.contactId = con.id;
        conRoleObj.Role = 'Mother';
        conRoleObj.OpportunityId = oppobj.id;
        Insert conRoleObj;
        
        OpportunityContactRole conRoleObj1 = New OpportunityContactRole();
        conRoleObj1.contactId = con1.id;
        conRoleObj1.Role = 'Mother';
        conRoleObj1.OpportunityId = oppobj1.id;
        Insert conRoleObj1;
        
        
        oppobj.StageName = 'Won (9)';
        oppobj.status__C = 'Enrolled';
        
        oppobj.of_Babies__c = 'Single';
        oppobj.of_CB__c = '1';
        oppobj.of_CT__c ='1';
        oppobj.LeadSource = 'Chat';
        oppobj.Due_Date__c =  system.today().addDays(2);
        oppobj.Adoption_Type__c = 'Open';
        /*oppobj.Ship_To_Name__c ='Test1';
        oppobj.Ship_To_Street1__c= 'Test2';
        oppobj.Ship_To_Phone__c = 'Test3';
        oppobj.Shipping_Method__c = 'Priority Overnight';
        oppobj.Requested_Shipping_Date__c = system.today();*/
        oppobj.Shipping_Method__c ='Priority Overnight';
        oppobj.Requested_Shipping_Date__c  =system.today().addDays(2);
        oppobj.Ship_To_Name__c  =null;
        oppobj.Ship_To_Street1__c=null;
        oppobj.Ship_To_Phone__c = null;
        try {
        
             update oppobj;
        }
        catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Due Date'));
        }
        
        
    }
    @isTest
    public static void unitTestsecondarycon(){
        //list<opportunity> oppList = New List<opportunity>();
       
        Opportunity oppobj = New Opportunity(name = 'Test1',of_Babies__c = 'Single',Requested_Shipping_Method__c = 'Priority Overnight',StageName = 'Ask for sale (7)',PickUp_or_Ship_Kit__c = 'Ship',closeDate = system.today(),status__C = 'Enrolled',Due_Date__c = system.today().addDays(2),Requested_Shipping_Date__c = system.today(),Ship_To_Street1__c = 'Texas mst',Ship_To_City__c = 'Texas',Ship_To_State__c = 'Texas',Ship_To_Zip_Code__c = '73301',Ship_To_Name__c = 'Test User',Shipping_Method__c = 'Priority Overnight',Ship_To_Phone__c = '9998880099');
        
        Insert oppobj;
           
        Provider__c provObj = New Provider__c();
        provObj.Master_Provider_Id__c = 'TestF';
        Insert provObj;
        
        Facility__c faciObj = New Facility__c();
        faciObj.Master_Facility_Id__c = 'TestMF';
        Insert faciObj;
        
        Provider_Facility__c pfObj = new Provider_Facility__c();
        pfObj.Master_Provider_Facility_ID__c = 'TestPF';
        pfObj.Facility__c = faciObj.id;
        pfObj.Provider__c = provObj.id;
        
        insert pfObj;
        
        
        Opportunity_Provider__c oppProviderObj = new Opportunity_Provider__c();
        oppProviderObj.Provider__c = provObj.Id;
        oppProviderObj.Opportunity__c = oppobj.id;
        oppProviderObj.Primary_Provider__c = true;
        oppProviderObj.Facility__c = faciObj.id;
        oppProviderObj.Provider_Facility__c = pfObj.id;
        
        Insert oppProviderObj;
     
       
        Contact con = new contact();
        con.FirstName = 'Jhon';
        con.lastName = 'Test';
        con.Birthdate = system.today().addDays(-100);
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Jhon11';
        con1.lastName = 'Test11';
        con1.Birthdate = system.today().addDays(-150);
        con1.MailingStreet ='mst';
        con1.MailingState='Texas';
        con1.MailingPostalCode  ='73301';
        con1.MailingCountry = 'United States';
        con1.Email = 'test@test.com';
        con1.ID_Information__c = '123422';
        con1.ID_Type__c  = 'Passport #';
        
        insert con1;
        
        Opportunity oppObj1 = New Opportunity();
        oppObj1.name = 'Test1';
        oppObj1.Requested_Shipping_Method__c = 'Priority Overnight';
        oppObj1.Primary_Contact__c = con.id;
        oppObj1.closeDate = system.today();
        oppobj1.Due_Date__c =  system.today().addDays(80);
        oppobj1.StageName = 'Ask for sale (7)';
        oppobj1.Signature_Required__c = true;
        oppobj1.Saturday_Delivery__c = true;
        oppobj1.of_Babies__c = 'Twins';
        oppobj1.PickUp_or_Ship_Kit__c = 'Ship';
         oppobj1.Requested_Shipping_Date__c = system.today();
        oppobj1.Ship_To_Street1__c = 'Texas mst';
        oppobj1.Ship_To_Street2__c = null;
        oppobj1.Ship_To_City__c = 'Texas';
        oppobj1.Ship_To_State__c = 'Texas';
        oppobj1.Ship_To_Zip_Code__c = '73301';
       oppobj1.Ship_To_Name__c = 'Test User';
       oppobj1.Shipping_Method__c = 'Priority Overnight';
       oppobj1.Ship_To_Phone__c = '9998880099';
        Insert oppObj1;
        
        OpportunityContactRole conRoleObj = New OpportunityContactRole();
        conRoleObj.IsPrimary = true;
        conRoleObj.contactId = con.id;
        conRoleObj.Role = 'Mother';
        conRoleObj.OpportunityId = oppobj.id;
        Insert conRoleObj;
        
        OpportunityContactRole conRoleObj1 = New OpportunityContactRole();
        conRoleObj1.contactId = con1.id;
        conRoleObj1.Role = 'Father';
        conRoleObj1.OpportunityId = oppobj.id;
        Insert conRoleObj1;
        
        
        oppobj.StageName = 'Won (9)';
        oppobj.status__C = 'Enrolled';
        
        oppobj.of_Babies__c = 'Single';
        oppobj.of_CB__c = '1';
        oppobj.of_CT__c ='1';
        oppobj.LeadSource = 'Chat';
        oppobj.Due_Date__c =  system.today().addDays(2);
        oppobj.Adoption_Type__c = 'Open';
        /*oppobj.Ship_To_Name__c ='Test1';
        oppobj.Ship_To_Street1__c= 'Test2';
        oppobj.Ship_To_Phone__c = 'Test3';
        oppobj.Shipping_Method__c = 'Priority Overnight';
        oppobj.Requested_Shipping_Date__c = system.today();*/
        oppobj.Shipping_Method__c ='Priority Overnight';
        oppobj.Requested_Shipping_Date__c  =system.today().addDays(2);
        oppobj.Ship_To_Name__c  =null;
        oppobj.Ship_To_Street1__c=null;
        oppobj.Ship_To_Phone__c = null;
        try {
        
             update oppobj;
        }
        catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Due Date'));
        }
        
        
    }
    @isTest
    public static void unitTest001(){
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Due_Date__c = null;
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Due Date'));
        }
        
    }
    @isTest
    public static void unitTest1(){
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        
        opp.Delivering_Hospital__c = Null;
        opp.Due_Date__c =  system.today().addDays(2);
        try{
            update opp;
        } catch(Exception e) {
           // System.assert(e.getMessage().contains('Please Enter Delivering Hospital'));
        }
        
    }
    @isTest
    public static void unitTest2(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Single';
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter # of Babies'));
        }
    }
    @isTest
    public static void unitTest3(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = null;
        try{
            update opp;
        } catch(Exception e) {
           // System.assert(e.getMessage().contains('Please Enter # of CB'));
        }
    }
    @isTest
    public static void unitTest4(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.of_CT__c = null;
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter # of CT'));
        }
    }
    @isTest
    public static void unitTest5(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.LeadSource = null;
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Lead Source'));
        }
    }
    @isTest
    public static void unitTest6(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Adoption_Type__c  = 'N/A';
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Adoption Type'));
        }
    }
    @isTest
    public static void unitTest7(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Primary_Source__c  = null;
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Primary Source'));
        }
    }
    @isTest
    public static void unitTest8(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Primary_Source__c = 'Advertising (Magazine, Internet)';
        opp.Ship_To_Name__c  = null;
        try{
            update opp;
        } catch(Exception e) {
           // System.assert(e.getMessage().contains('Please Enter Ship To Name'));
        }
    }
    @isTest
    public static void unitTest9(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Primary_Source__c = 'Advertising (Magazine, Internet)';
        opp.Ship_To_Name__c  = 'test';
        opp.Ship_To_Street1__c= null;
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Ship To Address'));
        }
    }
    @isTest
    public static void unitTest10(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Primary_Source__c = 'Advertising (Magazine, Internet)';
        opp.Ship_To_Name__c  = 'test';
        opp.Ship_To_Street1__c= 'test';
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Ship To Address'));
        }
    }
    @isTest
    public static void unitTest11(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Primary_Source__c = 'Advertising (Magazine, Internet)';
        opp.Ship_To_Name__c  = 'test';
        opp.Ship_To_Street1__c= 'test';
        opp.Ship_To_Phone__c = '123456';
        opp.Shipping_Method__c = null;
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Ship To Address'));
        }
    }
    @isTest
    public static void unitTest12(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Primary_Source__c = 'Advertising (Magazine, Internet)';
        opp.Ship_To_Name__c  = 'test';
        opp.Ship_To_Street1__c= 'test';
        opp.Ship_To_Phone__c = '123456';
        opp.Shipping_Method__c = 'Second day';
        opp.Requested_Shipping_Date__c = null;
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Ship To Address'));
        }
    }
    @isTest
    public static void unitTest13(){
        Facility__c faciObj = New Facility__c();
        Insert faciObj;
        Opportunity opp = opportunityInsert();
        opp = updateOpportunity(opp);
        opp.Due_Date__c =  system.today().addDays(32);
        opp.Delivering_Hospital__c = faciObj.Id;
        opp.of_Babies__c = 'Twins';
        opp.of_CB__c = '1';
        opp.Primary_Source__c = 'Advertising (Magazine, Internet)';
        opp.Ship_To_Name__c  = 'test';
        opp.Ship_To_Street1__c= 'test';
        opp.Ship_To_Phone__c = '123456';
        opp.Shipping_Method__c = 'Second day';
        opp.Requested_Shipping_Date__c = system.today();
        try{
            update opp;
        } catch(Exception e) {
            //System.assert(e.getMessage().contains('Please Enter Ship To Address'));
        }
        Provider__c provObj = New Provider__c();
        Insert provObj;
        
        Facility__c faciObj1 = New Facility__c();
        Insert faciObj1;
        
        Opportunity_Provider__c oppProviderObj = new Opportunity_Provider__c();
        oppProviderObj.Provider__c = provObj.Id;
        oppProviderObj.Opportunity__c = opp.id;
        oppProviderObj.Primary_Provider__c = false;
        oppProviderObj.Facility__c = faciObj1.id;
        Insert oppProviderObj;
     
       
        Contact con = new contact();
        con.firstName = 'Test22';
        con.lastName = 'Test';
        insert con;
        
        OpportunityContactRole conRoleObj = New OpportunityContactRole();
        conRoleObj.contactId = con.id;
        conRoleObj.Role = 'Mother';
        conRoleObj.OpportunityId = opp.id;
        Insert conRoleObj;
    }
    @isTest
    public static void unitTest14(){
        Contact con = new contact();
        con.FirstName = 'Jhon';
        con.lastName = 'Test';
        con.Birthdate = system.today().addDays(-100);
        insert con;
        
        Contact con1 = new contact();
        con1.FirstName = 'Jhon11';
        con1.lastName = 'Test11';
        con1.Birthdate = system.today().addDays(-150);
        insert con1;
        
        Opportunity oppObj1 = New Opportunity();
        oppObj1.name = 'Test1';
        oppObj1.Requested_Shipping_Method__c = 'Priority Overnight';
        oppObj1.Primary_Contact__c = con.id;
        oppObj1.closeDate = system.today();
        oppobj1.Due_Date__c =  system.today().addDays(80);
        oppobj1.StageName = 'Ask for sale (7)';
        oppobj1.Signature_Required__c = true;
        oppobj1.Saturday_Delivery__c = true;
        oppobj1.of_Babies__c = 'Twins';
        oppobj1.PickUp_or_Ship_Kit__c = 'Ship';
        oppobj1.Requested_Shipping_Date__c = system.today();
        oppobj1.Ship_To_Street1__c = 'Texas mst';
        oppobj1.Ship_To_Street2__c = null;
        oppobj1.Ship_To_City__c = 'Texas';
        oppobj1.Ship_To_State__c = 'Texas';
        oppobj1.Ship_To_Zip_Code__c = '73301';
       oppobj1.Ship_To_Name__c = 'Test User';
       oppobj1.Shipping_Method__c = 'Priority Overnight';
       oppobj1.Ship_To_Phone__c = '9998880099';
        Insert oppObj1;
        
         OpportunityContactRole conRoleObj = New OpportunityContactRole();
        conRoleObj.contactId = con.id;
        conRoleObj.Role = 'Mother';
        conRoleObj.OpportunityId = oppObj1.id;
        conRoleObj.isPrimary = true;
        Insert conRoleObj;
        
        conRoleObj.isPrimary = false;
        update conRoleObj;
        
        oppobj1.Due_Date__c =  system.today().addDays(79);
        update oppObj1;
        
    }
     
    public static Opportunity opportunityInsert(){
        Opportunity opp = New Opportunity(name = 'Test2',StageName = 'Ask for sale (7)',closeDate = system.today(),status__C = 'Enrolled',Due_Date__c =  system.today().addDays(2));
        insert opp;
        return opp;
    }
    public static Opportunity updateOpportunity(Opportunity opp){
        
        opp.StageName = 'Won (9)';
        opp.status__C = 'Enrolled';
        opp.of_Babies__c = 'Single';
        opp.of_CB__c = '1';
        opp.of_CT__c ='1';
        opp.LeadSource = 'Chat';
        opp.Due_Date__c =  system.today().addDays(2);
        opp.Adoption_Type__c = 'Open';
        opp.Ship_To_Name__c ='Test1';
        opp.Ship_To_Street1__c= 'Test2';
        opp.Ship_To_Phone__c = 'Test3';
        opp.Shipping_Method__c = 'Priority Overnight';
        opp.Requested_Shipping_Date__c = system.today();
        return opp;
    }
    public static testmethod void OLEOPPtest(){
        test.StartTest();
        Online_Enrollment__c oe = new Online_Enrollment__c();
         oe.Cardholder_Name__c ='Test';
         oe.Primary_First_Name__c = 'Sam';
         oe.Primary_Last_Name__c = 'Smith';
         oe.Primary_Home_Phone__c = '1234567901';
         oe.Birth_Date_of_Primary__c = Date.today();
         oe.Primary_Address__c = 'St Marks road';
         oe.Primary_City__c = 'Texas';
         oe.Primary_State__c = 'Texas';
         oe.Primary_Country__c = 'United States';
         oe.Primary_Zipcode__c = '73301';
         oe.PrimaryID__c= 'TestMP2';
         oe.Primary_Email__c = 'samsmith@example.com';
         oe.Primary_Role__c='Mother';
         oe.of_CB__c = '1';
         oe.of_CT__c = '1';
         oe.Due_Date__c = System.today();
         oe.Adoption_Type__c = 'Open';
         oe.Provider_First_Name__c = 'Tom';
         oe.Provider_Last_Name__c = 'Raider';
         //oe.Provider_ID__c ='TestMP2';
         oe.Provider_State__c = 'LA';
         oe.Provider_City__c = 'Chicago';
         oe.Provider_Address__c = 'Times Square';
         //oe.Provider_Facility_ID__c = 'TestMPF2';
         //oe.Hospital_Id__c = 'TestMF2';
         oe.Hospital_Address__c = 'St Anees Road';
         oe.Hospital_City__c = 'Southhamptom';
         oe.Hospital_Name__c ='Forbes';
         oe.Hospital_State__c = 'London';  
         oe.Provider_City__c = 'Japan';
         oe.Provider_Address__c='St Johns';
         oe.Secondary_First_Name__c = 'TestS';
         oe.Secondary_Last_Name__c = 'TestLN00';
         oe.Secondary_Role__c = 'Father';
         oe.Ship_to_first_name__c = 'Shipnametest';
         oe.Ship_to_Last_Name__c = 'lastnametest';
          insert oe;
        Test.StopTest();
        
    }
     public static testmethod void LeadOppStatusChangeTest(){
        Id ManualLeadRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Manual Lead').getRecordTypeId();
        Id MQLRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('MQL').getRecordTypeId();
         system.debug('ManualLeadRecordTypeId'+ManualLeadRecordTypeId);
         system.debug('MQLRecordTypeId'+MQLRecordTypeId);
        test.StartTest();
        // create a Lead with reocrd type manual Lead and convert lead check weather opportunity'stage is Rapport and Education (5) when opportunity created on converion this lead
        //Create Lead with manual Lead record type
        Lead manualLead=new Lead(LastName='Doe',FirstName='John',Company='Test',Status='Manually Qualified',LeadSource='Phone',RecordTypeid=ManualLeadRecordTypeId,Due_Date__c=system.today(),Email='test111@gmail.com');
        insert manualLead; 
        system.debug('manualLead========'+manualLead);
        //COnvert Lead
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(manualLead.id);
        leadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setconvertedStatus(convertStatus.MasterLabel);
        lc.setDoNotCreateOpportunity(false);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
       //Get id of opportunity which is created on conversion of lead
        id oppManualLeadId = lcr.getOpportunityId();
        //with the above opp id query on opportunity
        Opportunity opp =[select id,StageName,Lead_RecordType_Name__c from opportunity where id =:oppManualLeadId];
        system.debug('opp========'+opp);
        //Check opportunity stage is  Rapport and Education (5)
        system.assertEquals(opp.StageName,'Rapport and Education (5)');
        
        // create a Lead with reocrd type MQL and convert lead check weather opportunity'stage is Marketing Qualified (4) when opportunity created on converion this lead   
        //Create Lead with MQL record type      
        Lead MQLLead=new Lead(LastName='Joe',FirstName='James',Company='Test',Status='New',LeadSource='Internet',RecordTypeid=MQLRecordTypeId,Due_Date__c=system.today(),Email='test222@gmail.com');
        insert MQLLead;         
        system.debug('MQLLead========'+MQLLead);
        //COnvert Lead
        Database.LeadConvert lc1 = new database.LeadConvert();
        lc1.setLeadId(MQLLead.id);
        lc1.setconvertedStatus(convertStatus.MasterLabel);
        lc1.setDoNotCreateOpportunity(false);
        
        Database.LeadConvertResult lcr1 = Database.convertLead(lc1);
        //Get id of opportunity which is created on conversion of lead
        id oppMQLLeadId = lcr1.getOpportunityId();
        //with the above opp id query on opportunity
        Opportunity opp1 =[select id,StageName,Lead_RecordType_Name__c from opportunity where id =:oppMQLLeadId];
        system.debug('opp1========'+opp1);
        //Check opportunity stage is  Marketing Qualified (4)
        system.assertEquals(opp1.StageName,'Marketing Qualified (4)');
        test.StopTest();
     }
    public static testmethod void SampleUserUpdatetest(){
        
       // List<UserRole> usr = [Select id,name from UserRole where Name Like: 'Sales Rep NSCE%' ];
        Test.startTest();
        UserRole usr = [Select id,name from UserRole where Name = 'Sales Rep NSCE 1' ];
        UserRole usr1 = [Select id,name from UserRole where Name = 'Sales Account Team Manager 1' ];
        UserRole usr2 = [Select id,name from UserRole where Name = 'Sales Account Team Manager 2' ];
        Profile prof = [Select id,name from Profile where Name = 'Sales Account Team Manager' ];
        Profile prof1 = [Select id,name from Profile where Name = 'Sales Rep NSCE' ];
        System.debug('---------User Name ' +usr1);
        List<User> usersList = new List<User>();
       
        User user1 = new User();
        user1.Username = 'Unitteest01@unittest.com';
        user1.LastName = 'Sample01';
        user1.Email = 'sample01@test.com';
        user1.Alias = 'Samplle';
        user1.CommunityNickname = 'Sampplee01';
        user1.EmailEncodingKey = 'UTF-8';
        user1.LanguageLocaleKey = 'en_US';  
        user1.TimeZoneSidKey = 'Europe/London';
        user1.LocaleSidKey = 'en_US';
        user1.ProfileId = prof1.id;
        user1.UserRoleId = usr.id;//Sales Rep NSCE 1 ROLE ID
        //Insert user1;
        usersList.add(user1);
        System.debug('-----User 1 details '+user1);
        User user2 = new User();
        user2.Username = 'manager@unittest.com';
        user2.LastName = 'Sales Manager';
        user2.Email = 'manager123@test.com';
        user2.Alias = 'Manageer';
        user2.CommunityNickname = 'Manager123';
        user2.EmailEncodingKey = 'UTF-8';
        user2.LanguageLocaleKey = 'en_US';  
        user2.LocaleSidKey = 'en_US';
        user2.TimeZoneSidKey = 'Europe/London';
        user2.ProfileId = prof.id;
        user2.UserRoleId = usr1.id; // Sales Account Team Manager 1 Role ID
        //Insert user2;
        usersList.add(user2);
        
       /* User user3 = new User();
        user3.Username = 'UnitTest1234@unitteeest.com';
        user3.LastName = 'Sample1234';
        user3.Email = 'sample1234@test.com';
        user3.Alias = 'Sammple';
        user3.CommunityNickname = 'Sampplee1234';
        user3.EmailEncodingKey = 'UTF-8';
        user3.LanguageLocaleKey = 'en_US';  
        user3.TimeZoneSidKey = 'Europe/London';
        user3.LocaleSidKey = 'en_US';
        user3.ProfileId = prof1.id;
        user3.UserRoleId = usr.id; // Sales Rep NSCE 2 ROLE ID
        
        
        //Insert user3;
        usersList.add(user3); */
        //INsert users
        
        insert usersList;
        System.debug('-----User 1 details '+user1.id);
        System.debug('-----User 2 details '+user2.Id);
        //System.debug('-----User 3 details '+user3.Id);
        system.RunAs(User1){
        Contact con = new contact();
        con.FirstName = 'Tom';
        con.lastName = 'Hawks';
        con.Birthdate = system.today().addDays(-235);
        con.ID_Type__c = 'Other Government Issued Id #';
        con.ID_Information__c = '19909909909';
        insert con;
        
        Opportunity Oppty = New Opportunity();
        Oppty.name = 'Update Manager';
        Oppty.Requested_Shipping_Method__c = 'Priority Overnight';
        Oppty.Primary_Contact__c = con.id;
        Oppty.closeDate = system.today();
        Oppty.Due_Date__c =  system.today().addDays(10);
        Oppty.StageName = 'Ask for sale (7)';
        Oppty.Signature_Required__c = true;
        Oppty.Saturday_Delivery__c = true;
        Oppty.of_Babies__c = 'Twins';
        Oppty.PickUp_or_Ship_Kit__c = 'Ship';
        Oppty.Requested_Shipping_Date__c = system.today();
        Oppty.OwnerId = user1.id;
        oppty.Ship_To_Street1__c = 'Texas mst';
        oppty.Ship_To_Street2__c = null;
        oppty.Ship_To_City__c = 'Texas';
        oppty.Ship_To_State__c = 'Texas';
        oppty.Ship_To_Zip_Code__c = '73301';
       Oppty.Ship_To_Name__c = 'Test User';
       Oppty.Shipping_Method__c = 'Priority Overnight';
       Oppty.Ship_To_Phone__c = '9998880099';
       // Oppty.Manager__c = NULL;
        Insert Oppty;     
           
        Opportunity oppNew = [Select id,Manager__r.UserRoleId,OwnerId from opportunity where id =:Oppty.id];
        system.debug('user1.id========'+user1.id);
        system.debug('oppNew.OwnerId-----'+oppNew.OwnerId);
        system.debug('user2.Id===='+user2.Id);
        system.debug('oppNew.Manager__c===='+oppNew.Manager__c);
         System.assertEquals(usr1.Id, oppNew.Manager__r.UserRoleId);
         Test.stopTest();
        /*List<Opportunity> opplist = new List<Opportunity>(); 
        opplist.add(Oppty);
            
        Oppty.Due_Date__c = system.today().addDays(79);
        update Oppty;
            
        System.debug('----Users List' +Oppty.Manager__c); 
            
        try {
            
			        } 
        catch(DmlException e) {
        	System.debug('The following exception has occurred during oppty insertion: ' + e.getMessage());
        }
        //Insert Oppty;
        //Check if the Manager field is updated to Sales Manager
        //System.assertEquals(user2.id , Oppty.Manager__c);    
        
        OpportunityContactRole conRoleObj = New OpportunityContactRole();
        conRoleObj.contactId = con.id;
        conRoleObj.Role = 'Mother';
        conRoleObj.OpportunityId = Oppty.id;
        conRoleObj.isPrimary = true;
        Insert conRoleObj;
        
        conRoleObj.isPrimary = false;
        update conRoleObj;
        System.debug('------------I am on line 739'+Oppty.Manager__c);   
        Test.stopTest();
        opportunityTriggerHelper.populateRoleHierarchyPaarent(opplist);
        System.debug('---------ManagerField'+Oppty.Manager__c);
        System.assertEquals(user2.Id, Oppty.Manager__c); */
            
           // System.assertEquals(expected, actual)
                
           
        }
        
      
    }
    
}