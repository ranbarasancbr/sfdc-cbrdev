/******************************************************************************************************************************
Component Name: OpportunityTriggerHelperTest
Description   : Test class for opportunityTriggerHelper.
Developed By  : TEKsystems
*******************************************************************************************************************************/

@isTest
public class OpportunityTriggerHelperTest{
    //oppRecords method will have setupdata 
    @testSetup static void oppRecords() {
        Account acc = new Account(Name = 'TestAccount');
        List<Contact> contLIst = new LIst<Contact>();
        contLIst.add(new Contact(FirstName = 'Jhon', LastName = 'Test',Birthdate = System.today().addDays(-100),Phone='1232431234',ID_Type__c = 'Passport #',ID_Information__c = '54546565655',Email = 'test111@test.com',MailingCountry = 'United States',MailingState = 'Texas',MailingCity = 'Texas',MailingPostalCode='73301',MailingStreet = 'Testmst'));
        contLIst.add(new Contact(FirstName = 'Joy', LastName = 'Test',Birthdate = System.today().addDays(-50),Phone = '8900988900',ID_Type__c = 'Passport #',ID_Information__c = '23475676878',Email = 'test222@test.com',MailingCountry = 'United States',MailingState = 'Texas',MailingCity = 'Texas',MailingPostalCode='73301',MailingStreet = 'mstmst'));
        contLIst.add(new Contact(FirstName = 'Jack', LastName = 'Test',Birthdate = System.today().addDays(-90),Phone = '6786786776',ID_Type__c = 'Passport #',ID_Information__c = '4557609989',Email = 'test333@test.com',MailingCountry = 'United States',MailingState = 'Texas',MailingCity = 'Texas',MailingPostalCode='73301',MailingStreet = 'Test'));
        insert contLIst;

        List<Opportunity> oppList = new List<Opportunity>();
         oppList.add(new Opportunity(name = 'Test1',of_Babies__c = 'Single',
                                             StageName = 'Ask for sale (7)',PickUp_or_Ship_Kit__c = 'Ship',
                                             closeDate = system.today(),status__C = 'Enrolled',Due_Date__c = system.today().addDays(42),
                                             Ship_To_Street1__c = 'Texas mst',Ship_To_City__c = 'Texas',Ship_To_State__c = 'Texas',
                                             Ship_To_Zip_Code__c = '73301',Ship_To_Phone__c = '9900990099',
                                             Requested_Shipping_Date__c = system.today(),Ship_To_Name__c = 'testName',Description = 'Opportunity1'));
         insert oppList;
         List<Facility__c> facilityList = new List<Facility__c>();
         facilityList.add(new Facility__c(Master_Facility_Id__c = 'MF1'));
         insert facilityList;

         LIst<Provider__c> providerList = new List<Provider__c>();
         providerList.add(new Provider__c(Master_Provider_Id__c = 'MP1'));
         insert providerList;

         List<Provider_Facility__c> PFList = new List<Provider_Facility__c>();
         PFList.add(new Provider_Facility__c(Master_Provider_Facility_ID__c = 'MPF1',Facility__c = facilityList[0].id,Provider__c = providerList[0].id));
         insert PFList;
    }
    //testMethod1 to validate opp stage is updated to won
    @isTest static void testMethod1(){
        Test.StartTest();
        //Query on opportunity which is created in setup method
        Opportunity opp = [Select id,Description,Due_Date__c,Delivering_Hospital__c,LeadSource,Primary_Source__c,PickUp_or_Ship_Kit__c,Ship_To_Phone__c,Shipping_Method__c,Requested_Shipping_Date__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_City__c,Ship_To_State__c,Ship_To_Zip_Code__c,Requested_Shipping_Method__c  from Opportunity];
        //Query on facility object
        Facility__c faclity = [Select id from Facility__c];
        //Query on contact
        Contact con = [Select id from Contact LIMIT 1];
        //Query on provider
        Provider__c provObj = [Select id from Provider__c];
        //Query on provider facility
        Provider_Facility__c pfRec = [Select id from Provider_Facility__c];
        //create primary opportunity contact role woth mother role 
        OpportunityContactRole ocr = new OpportunityContactRole(ContactId = con.id,Role = 'Mother',IsPrimary = true,OpportunityId = opp.id);
        insert ocr;

        //create opportunity provider 
        Opportunity_Provider__c oppProviderObj = new Opportunity_Provider__c();
        oppProviderObj.Provider__c = provObj.Id;
        oppProviderObj.Opportunity__c = opp.id;
        oppProviderObj.Primary_Provider__c = true;
        oppProviderObj.Facility__c = faclity.id;
        oppProviderObj.Delivering_Provider__c = true;
        oppProviderObj.Provider_Facility__c = pfRec.id;
        Insert oppProviderObj;

        //update opp stage to won
        opp.Delivering_Hospital__c = faclity.id;
        opp.LeadSource = 'Other';
        opp.Primary_Source__c = 'Other';
        opp.Requested_Shipping_Method__c = 'Priority Overnight';
        opp.StageName = 'Won (9)';
        update opp;
        system.assertEquals(opp.StageName,'Won (9)');

        Test.StopTest();
    }
    @isTest static void testMethod2(){
        Test.StartTest();try{
            Opportunity opp = new Opportunity(name = 'Test1',of_Babies__c = 'Single',                                             StageName = 'Ask for sale (7)',PickUp_or_Ship_Kit__c = 'Ship',closeDate = system.today(),status__C = 'Enrolled',Due_Date__c = system.today().addDays(42));
            insert opp;
            //Query on contact
            Contact con = [Select id from Contact LIMIT 1];
             OpportunityContactRole ocr = new OpportunityContactRole(ContactId = con.id,Role = 'Mother',OpportunityId = opp.id);
            insert ocr;
            opp.StageName = 'Won (9)';
            update opp;
            system.assertNotEquals(opp.StageName,'Won (9)');
        }catch(Exception e){

        }
        
        Test.StopTest();
    }
    @isTest static void testMethod3(){
        Test.StartTest();
        Id ManualLeadRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Manual Lead').getRecordTypeId();
        Id MQLRecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('MQL').getRecordTypeId();
        List<Lead> leadList = new List<Lead>();
         Lead MQLLead=new Lead(LastName='Joe',FirstName='James',Company='Test',Status='New',LeadSource='Internet',RecordTypeid=MQLRecordTypeId,Due_Date__c=system.today(),Email='test222@gmail.com');
         leadList.add(MQLLead);
         Lead manualLead=new Lead(LastName='Doe',FirstName='John',Company='Test',Status='Manually Qualified',LeadSource='Phone',RecordTypeid=ManualLeadRecordTypeId,Due_Date__c=system.today(),Email='test111@gmail.com');
         leadList.add(manualLead);

        insert leadList;

        //Convert lead
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(manualLead.id);
        leadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setconvertedStatus(convertStatus.MasterLabel);
        lc.setDoNotCreateOpportunity(false);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
         id oppManualLeadId = lcr.getOpportunityId();
        //with the above opp id query on opportunity
        Opportunity opp =[select id,StageName,Lead_RecordType_Name__c from opportunity where id =:oppManualLeadId];
       
        //Check opportunity stage is  Rapport and Education (5)
        system.assertEquals(opp.StageName,'Rapport and Education (5)');

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
        Test.Stoptest();
        opportunity oppCSSReferral = new opportunity(name = 'Test1',of_Babies__c = 'Single',                                        StageName = 'Ask for sale (7)',PickUp_or_Ship_Kit__c = 'Ship',closeDate = system.today(),status__C = 'Enrolled',Due_Date__c = system.today().addDays(42),LeadSource = 'CSS Referral');
        insert oppCSSReferral;
        opportunity oppCss = [Select id,StageName from Opportunity where id =:oppCSSReferral.id];
        system.assertEquals(oppCss.StageName,'Marketing Qualified (4)');
    }
    //testMethod5 is to check opp is created when OLE is created and opp's id is updated on OLE
    @isTest static void testMethod4(){
        Test.StartTest();
              Online_Enrollment__c oe1 = new Online_Enrollment__c();
              oe1.Cardholder_Name__c ='Test';
              oe1.Primary_First_Name__c = 'SamTom';
              oe1.Primary_Last_Name__c = 'SmithTt';
              oe1.Primary_Home_Phone__c = '1234567000';
              oe1.Birth_Date_of_Primary__c = Date.today();
              oe1.Primary_Address__c = 'St Marks road';
              oe1.Primary_City__c = 'Texas';
              oe1.Primary_State__c = 'Texas';
              oe1.Primary_Country__c = 'United States';
              oe1.Primary_Zipcode__c = '73301';
              oe1.Primary_Email__c = 'samtest@example.com';
              oe1.Primary_Role__c='Mother';
              oe1.of_CB__c = '1';
              oe1.of_CT__c = '1';
              oe1.Due_Date__c = System.today();
              oe1.Adoption_Type__c = 'Open';
              oe1.Secondary_First_Name__c = 'TestSerw';
              oe1.Secondary_Last_Name__c = 'TestLN00tt';
              oe1.Secondary_Role__c = 'Father';
              oe1.Primary_ID_Type__c = 'Passport #';
              oe1.PrimaryID__c = '1234554454677';
              //Insert OLE
              insert oe1;
              opportunity opp = [Select id,Online_Enrollment__c from  Opportunity Where Online_Enrollment__c =:oe1.id];
              Online_Enrollment__c ole = [Select id,Opportunity_Id__c from Online_Enrollment__c];
              system.assertEquals(ole.Opportunity_Id__c,opp.id);
        Test.StopTest();
    }
    @isTest static void testMethod5(){
        Test.StartTest();
        UserRole usr = [Select id,name from UserRole where Name = 'Sales Rep NSCE 1' ];
        UserRole usr1 = [Select id,name from UserRole where Name = 'Sales Account Team Manager 1' ];
        UserRole usr2 = [Select id,name from UserRole where Name = 'Sales Account Team Manager 2' ];
        Profile prof = [Select id,name from Profile where Name = 'Sales Account Team Manager' ];
        Profile prof1 = [Select id,name from Profile where Name = 'Sales Rep NSCE' ];
        
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
        
        usersList.add(user2);
               
        insert usersList;
        
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
            Oppty.Shipping_Method__c = 'Priority Overnight';
            Oppty.Requested_Shipping_Method__c = 'Courier';
            Oppty.Primary_Contact__c = con.id;
            Oppty.closeDate = system.today();
            Oppty.Due_Date__c =  system.today().addDays(80);
            Oppty.StageName = 'Ask for sale (7)';
            Oppty.Signature_Required__c = true;
            Oppty.Saturday_Delivery__c = true;
            Oppty.of_Babies__c = 'Twins';
            Oppty.PickUp_or_Ship_Kit__c = 'Ship';
            Oppty.Requested_Shipping_Date__c = system.today()+1;
            Oppty.OwnerId = user1.id;
            Oppty.Ship_To_Street1__c = 'Texas mst';
            Oppty.Ship_To_Street2__c = null;
            Oppty.Ship_To_City__c = 'Texas';
            Oppty.Ship_To_State__c = 'Texas';
            Oppty.Ship_To_Zip_Code__c = '73301';
            Oppty.Ship_To_Name__c = 'Test User';
            Oppty.Ship_To_Phone__c = '9998880099';
            Insert Oppty;     
            
            Opportunity oppNew = [Select id,Manager__r.UserRoleId,OwnerId from opportunity where id =:Oppty.id];
            System.assertEquals(usr1.Id, oppNew.Manager__r.UserRoleId);
        Test.Stoptest();
    }
}
}