@isTest
public class opportunityValidateAndMergeTest {
    
    @testSetup static void OpptyMerge(){
        
        List<Account> acclist = new List<Account>();
        acclist.add(new Account(Name = 'CBR'));
        acclist.add(new Account(Name = 'CBR1'));
        insert acclist;
        
        List<Contact> contList = new List<Contact>();
        contList.add(new Contact(AccountId = acclist[0].Id,FirstName = 'John',LastName = 'Mayer',Phone = '9009009009',Email ='john@testdata.com',MailingStreet = '298 S. Ringo Street',MailingCity = 'Hanover',MailingState = 'Texas',MailingPostalCode = '73301',MailingCountry = 'United States'));
        contList.add(new Contact(AccountId = acclist[1].Id,FirstName = 'Tom',LastName = 'Hawks',Phone = '9845012345',Email ='tom@testdata.com',MailingStreet = '298 S. Ringo Street',MailingCity = 'Hanover',MailingState = 'Texas',MailingPostalCode = '73301',MailingCountry = 'United States'));
        contList.add(new Contact(AccountId = acclist[1].Id,FirstName = 'TomExa',LastName = 'HawksTest',Phone = '9845012399',Email ='tom@testdata.com',MailingStreet = '298 S. Ringo',MailingCity = 'Hanover',MailingState = 'Texas',MailingPostalCode = '73301',MailingCountry = 'United States'));
        contList.add(new Contact(AccountId = acclist[1].Id,FirstName = 'Test4323',LastName = 'usertest',Phone = '9845010045',Email ='tom@testdata.com',MailingStreet = '298 S. Ringo',MailingCity = 'Hanover',MailingState = 'Texas',MailingPostalCode = '73301',MailingCountry = 'United States'));
        insert contList;
        
        
        List<Provider__c> providerlist = new List<Provider__c>();
        providerlist.add(new Provider__c(Master_Provider_Id__c = 'MP1',Provider_First_Name__c = 'Rock',Provider_Last_Name__c = 'Bottom'));
        providerlist.add(new Provider__c(Master_Provider_Id__c = 'MP2',Provider_First_Name__c = 'TestMP2',Provider_Last_Name__c = 'TestLN2'));
        insert providerlist;
        List<Facility__c> facilityList = new List<Facility__c>();
        facilityList.add(new Facility__c(Facility_Name__c = 'St Marks',Master_Facility_Id__c = 'MF1'));
        facilityList.add(new Facility__c(Facility_Name__c = 'testFac',Master_Facility_Id__c = 'MF2'));
        insert facilityList;
        
        List<Provider_Facility__c> PFList = new List<Provider_Facility__c>();
        PFList.add(new Provider_Facility__c(Facility__c = facilityList[0].id,Provider__c = providerlist[0].id,Master_Provider_Facility_ID__c = 'MPF1'));
        PFList.add(new Provider_Facility__c(Facility__c = facilityList[1].id,Provider__c = providerlist[1].id,Master_Provider_Facility_ID__c = 'MPF2'));
        insert PFList;
        
        Opportunity opp1 = new Opportunity();
        opp1.Name='Sample test'; 
        opp1.AccountId = acclist[0].id;
        opp1.Primary_Contact__c = contList[0].id;
        opp1.Storage_Date__c=system.today();
        opp1.Status__c = 'Closed_Lost';
        opp1.Program_Enrolled_in__c='Newborn Possibilities Program - Designated Treatment Protocol';
        opp1.StageName = 'Overcoming Objections (6)';
        opp1.Due_Date__c = system.today().addDays(20);        
        opp1.CloseDate = system.today();
        opp1.of_Babies__c = 'Single';
        opp1.Adoption_Type__c = 'Open';
        opp1.of_CB__c='1';
        opp1.of_CT__c='0';
        insert opp1;

        Opportunity WinningOpp = new Opportunity();
        WinningOpp.Name='Sample test'; 
        WinningOpp.AccountId = acclist[0].id;
        WinningOpp.Primary_Contact__c = contList[0].id;
        WinningOpp.Storage_Date__c=system.today();
        WinningOpp.Status__c = 'Open';
        WinningOpp.Program_Enrolled_in__c='Newborn Possibilities Program - Designated Treatment Protocol';
        WinningOpp.StageName = 'Overcoming Objections (6)';
        WinningOpp.Due_Date__c = system.today().addDays(20);        
        WinningOpp.CloseDate = system.today();
        WinningOpp.of_Babies__c = 'Single';
        WinningOpp.Adoption_Type__c = 'Open';
        WinningOpp.of_CB__c='1';
        WinningOpp.of_CT__c='0';
        WinningOpp.Description = 'Winning Opportunity';
        //Merge Logic Fields
        WinningOpp.Pricebook2Id = Null;
        WinningOpp.Payment_Plan__c = Null;
        WinningOpp.Payment_Method__c = Null;
        WinningOpp.CB_Storage_Fee_Option__c = Null;        
        WinningOpp.Corporate_Discount__c = Null ;
        WinningOpp.Promo_Code__c = Null ;
        WinningOpp.Manual_Discount__c = Null ;
        WinningOpp.Discount_Comments__c = Null;
        WinningOpp.PickUp_or_Ship_Kit__c = Null;
        WinningOpp.Ship_To_Name__c = Null;
        WinningOpp.Ship_To_Street1__c= Null;
        WinningOpp.Ship_To_Phone__c = Null ;
        WinningOpp.Total_Expedited_Shipping_Cost__c = Null ;
        WinningOpp.Shipping_Method__c = Null ;
        WinningOpp.Requested_Shipping_Method__c = Null ;
        WinningOpp.Saturday_Delivery__c = False;
        WinningOpp.Signature_Required__c = False;        
        WinningOpp.of_Babies__c = 'Single';        
        WinningOpp.of_CB__c='1';
        WinningOpp.of_CT__c='0';
        WinningOpp.Gift_Registry_Start_Date__c = Null ;
        WinningOpp.Gift_Registry_End_Date__c = Null ;
        WinningOpp.Adoption_Type__c = 'N/A';
        WinningOpp.Primary_Source__c = Null;
        //WinningOpp.Referred_By_Contact_Id__c = 'Vincient';
        WinningOpp.Section_1_Received__c = False;
        WinningOpp.Section_2_Received__c = False;
        WinningOpp.Section_3_Received__c = False;
        WinningOpp.Section_3_Incomplete__c =False;
        WinningOpp.Section_3_Needs_Review__c = False;
        WinningOpp.Section_4_Received__c = False;
        WinningOpp.Section_5_Received__c = False;
        WinningOpp.Section_2_Received_Birth_Mother__c = False;
        WinningOpp.Section_3_Incomplete_Birth_Mother__c = False;
        WinningOpp.Section_3_Received_Birth_Mother__c = False;
        WinningOpp.Section_3_Needs_Review__c = False;
        WinningOpp.Section_5_Received_Birth_Mother__c = False;
        WinningOpp.Delivering_Hospital__c = Null;
        WinningOpp.Payment_Method__c = 'Credit Card';
       // WinningOpp.OpportunityMerge__c = opp1.Id;
        insert WinningOpp;
        
        Opportunity LosingOpp = New Opportunity();
        LosingOpp.Name='Sample test'; 
        LosingOpp.Payment_Method__c = 'Credit Card';
        LosingOpp.AccountId = acclist[1].id;
        LosingOpp.Primary_Contact__c = contList[1].id;
        LosingOpp.Storage_Date__c=system.today(); 
        LosingOpp.Status__c = 'Enrolled';
        LosingOpp.Program_Enrolled_in__c='Newborn Possibilities Program - Designated Treatment Protocol';
        LosingOpp.StageName = 'Overcoming Objections (6)';
        LosingOpp.Due_Date__c = system.today().addDays(20);        
        LosingOpp.CloseDate = system.today();
        
        //Merge Logic Fields
        LosingOpp.Primary_Source__c='Email from CBR';
        //LosingOpp.Pricebook2Id = '0064D000004AR5uQAG';
        LosingOpp.Payment_Plan__c = 'Pay in Full';
        LosingOpp.Payment_Method__c = 'Credit Card';
        LosingOpp.CB_Storage_Fee_Option__c = 'Annual Storage';
        LosingOpp.Corporate_Discount__c = 'Repeat Client';
        LosingOpp.Promo_Code__c = 'CBRDISC';
        LosingOpp.Manual_Discount__c = 25.00;
        LosingOpp.Discount_Comments__c = 'To Enroll Today';
        LosingOpp.PickUp_or_Ship_Kit__c = 'PickUp';
        LosingOpp.Ship_To_Name__c ='John';
        LosingOpp.Ship_To_Street1__c= 'St Marks Road';
        LosingOpp.Ship_To_Phone__c = '9009009009';
        LosingOpp.Total_Expedited_Shipping_Cost__c = 45000;
        LosingOpp.Shipping_Method__c = 'Priority Overnight';
        LosingOpp.Requested_Shipping_Method__c = 'Priority Overnight';
        LosingOpp.Saturday_Delivery__c = TRUE;
        LosingOpp.Signature_Required__c = TRUE;        
        LosingOpp.of_Babies__c = 'Twins';        
        LosingOpp.of_CB__c='1';
        LosingOpp.of_CT__c='0';
        LosingOpp.Gift_Registry_Start_Date__c = system.today();
        LosingOpp.Gift_Registry_End_Date__c = system.today();
        LosingOpp.Adoption_Type__c = 'Open';
        LosingOpp.Primary_Source__c = 'Article/News Story';
        //LosingOpp.Referred_By_Contact_Id__c = 'Vincient';
        LosingOpp.Section_1_Received__c = TRUE;
        LosingOpp.Section_2_Received__c = TRUE;
        LosingOpp.Section_3_Received__c = TRUE;
        LosingOpp.Section_3_Incomplete__c =TRUE;
        LosingOpp.Section_3_Needs_Review__c = TRUE;
        LosingOpp.Section_4_Received__c = TRUE;
        LosingOpp.Section_5_Received__c = TRUE;
        LosingOpp.Section_2_Received_Birth_Mother__c = TRUE;
        LosingOpp.Section_3_Incomplete_Birth_Mother__c = TRUE;
        LosingOpp.Section_3_Received_Birth_Mother__c = TRUE;
        LosingOpp.Section_3_Needs_Review__c = TRUE;
        LosingOpp.Section_5_Received_Birth_Mother__c = TRUE;
        LosingOpp.Delivering_Hospital__c = facilityList[0].id;
        LosingOpp.Description = 'Losing Opportunity';
        LosingOpp.OpportunityMerge__c = WinningOpp.Id;
        insert LosingOpp;    
        
        //create open task and close task 
        List<Task> taskList = new List<task>();
        taskList.add(new task(WhatId = LosingOpp.id,Subject = 'CallCall',Priority = 'High',Status = 'Open'));
        taskList.add(new task(WhatId = LosingOpp.id,Subject = 'Call',Priority = 'Low',Status = 'Closed'));
        insert taskList;
        
        DocImage_Attachment__c doc = new DocImage_Attachment__c();
        doc.Opportunity__c = LosingOpp.id;
        doc.DocImage_Link__c = 'www.google.com';
        doc.Form_Name__c = 'Sample Form';
        doc.Form_Code__c = '1001';
        insert doc;
        
        Asset ast = new Asset();
        ast.Opportunity__c = LosingOpp.id; 
        ast.Name = 'Sample'; 
        ast.AccountId = acclist[1].id;
        ast.ContactId = contList[1].id;
        
        insert ast;
        
        //Opportunity Contact Roles for winning and losing opp
        list<OpportunityContactRole> OCRList = new List<OpportunityContactRole>();
        OCRList.add(new OpportunityContactRole(ContactId = contList[0].id,OpportunityId = WinningOpp.id,Role = 'Mother'));
        OCRList.add(new OpportunityContactRole(ContactId = contList[1].id,OpportunityId = LosingOpp.id,Role = 'Mother'));
        OCRList.add(new OpportunityContactRole(ContactId = contList[2].id,OpportunityId = LosingOpp.id,Role = 'Unknown'));
        OCRList.add(new OpportunityContactRole(ContactId = contList[3].id,OpportunityId = LosingOpp.id,Role = 'Father'));
        insert OCRList;
        
        //Inserting Opportunity provider for winning and losing opportunities
        List<Opportunity_Provider__c> oppProviderlist = new List<Opportunity_Provider__c>();
        oppProviderlist.add(new Opportunity_Provider__c(Facility__c =facilityList[0].id ,Provider__c = providerlist[0].id,Primary_Provider__c = false,Delivering_Provider__c = false,Opportunity__c = WinningOpp.Id,Provider_Facility__c = PFList[0].id));
        oppProviderlist.add(new Opportunity_Provider__c(Facility__c = facilityList[1].id ,Provider__c =providerlist[1].id,Primary_Provider__c = true,Delivering_Provider__c = true,Opportunity__c = LosingOpp.Id,Provider_Facility__c = PFList[1].id));
        
        insert oppProviderlist;
        
        //Campaign and campagin Influence records creation for losing opportunity
        Campaign camp = new Campaign();
        camp.Name = 'Test Campaign';
        camp.IsActive = True;
        insert camp;
        
        CampaignInfluence Ci = new CampaignInfluence(CampaignId = camp.id,OpportunityId  =LosingOpp.id,ModelId = Label.Campaign_Model_Id);
        insert Ci;
        
        //Inserting notes for losing opportunity
        Note notesRec = new Note(Title = 'TestNotes', Body = 'Test notes for opportunity Merge', ParentId =LosingOpp.id);
        insert notesRec;
        
        //Inserting files for losing opportunity 
        ContentVersion content=new ContentVersion(); 
        content.Title='Header_Picture1'; 
        content.PathOnClient='/' + content.Title + '.jpg'; 
        Blob bodyBlob=Blob.valueOf('Unit Test ContentVersion Body'); 
        content.VersionData=bodyBlob; 
        content.origin = 'H';
        insert content;
        
        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :content.Id];
        
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=LosingOpp.id;
        contentlink.contentdocumentid=testContent.contentdocumentid;
        contentlink.ShareType = 'V';
        insert contentlink;
        
        Event e = new Event();
        e.WhatId=LosingOpp.id;
        e.StartDateTime=system.today()+2;
        e.EndDateTime=system.today()+5;
        insert e;

        
        
    } 
    @isTest static void testMethod1(){
        Test.StartTest();
        List<Opportunity> oppList = [select id,name,Description,Storage_Date__c,Pending_Date__c,StageName,Status__c,OpportunityMerge__c,Primary_Contact_First_Name__c,Primary_Contact_Last_Name__c,due_date__c,CreatedDate,of_Babies__c,of_CB__c,of_CT__c,Adoption_Type__c,Primary_Source__c,Referred_By_Opportunity__c,Section_2_Received_Birth_Mother__c,Section_3_Incomplete_Birth_Mother__c,Section_3_Received_Birth_Mother__c,Section_3_Needs_Review_Birth_Mother__c,Section_1_Received__c,Section_2_Received__c,Section_3_Received__c,Section_3_Incomplete__c,Section_3_Needs_Review__c,Section_4_Received__c,Section_5_Received__c,Delivering_Hospital__c,Payment_Plan__c,Payment_Method__c,CB_Storage_Fee_Option__c,CT_Storage_Fee_Option__c,Corporate_Discount__c,Promo_Code__c,Manual_Discount__c,Discount_Comments__c,PickUp_or_Ship_Kit__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_Phone__c,Total_Expedited_Shipping_Cost__c,Shipping_Method__c,Requested_Shipping_Method__c,Requested_Shipping_Date__c,Saturday_Delivery__c,Signature_Required__c,PriceBook2Id,Opportunity_Merged_By__c,Opportunity_Merged_Date__c,Losing_Opportunity__c,Primary_Contact__c,Secondary_Contact__c,Online_Enrollment__c,Section_5_Received_Birth_Mother__c,OwnerId,Gift_Registry_End_Date__c,Gift_Registry_Start_Date__c,Loss_Reason__c,Ship_To_Street2__c,Ship_To_City__c,Ship_To_State__c,Ship_To_Zip_Code__c,Ship_To_Country__c from opportunity];
        Opportunity WinningOpp = new Opportunity();
        opportunity LosingOpp = new Opportunity();
        for(Opportunity opp:oppList){
            if(opp.Description == 'Winning Opportunity'){
                WinningOpp = opp;
            }
            else if(opp.Description == 'Losing Opportunity'){
                LosingOpp = opp;
            }
        }
        List<opportunity> oppupdate = new List<opportunity>();
            WinningOpp.OpportunityMerge__c = LosingOpp.id;
            oppupdate.add(WinningOpp);
       // update WinningOpp;
             LosingOpp.Storage_Date__c = null;
             LosingOpp.Status__c = 'Open';
             oppupdate.add(LosingOpp);
             update oppupdate;
       // update LosingOpp;
        system.debug('WinningOpp status'+WinningOpp.Status__C);
        system.debug('Winning opp due date'+WinningOpp.Due_Date__C);

        system.debug('Losing Storage_Date__c'+LosingOpp.Storage_Date__c);
        system.debug('Losing Pending_Date__c'+LosingOpp.Pending_Date__c);
        system.debug('Status__c======='+LosingOpp.Status__c);
        opportunityMergeController omc = new opportunityMergeController();
        PageReference pageRef = Page.OpportunityMergeTab;
        omc.selectedFields = null;
        omc.winningOppty = WinningOpp;
        omc.LosingOpty = LosingOpp;
        omc.selectedvalue = 'Standard';
        omc.MergeOpportunities();
        omc.radioButtonMethod();
        omc.getOpportunity1();  
        
        System.assertEquals(LosingOpp.of_Babies__c, WinningOpp.of_Babies__c);
        System.assertEquals(LosingOpp.Payment_Plan__c, WinningOpp.Payment_Plan__c);
        System.assertEquals(LosingOpp.Payment_Method__c, WinningOpp.Payment_Method__c);
        System.assertEquals(LosingOpp.CB_Storage_Fee_Option__c, WinningOpp.CB_Storage_Fee_Option__c);
        System.assertEquals(LosingOpp.CT_Storage_Fee_Option__c, WinningOpp.CT_Storage_Fee_Option__c);
        System.assertEquals(LosingOpp.Corporate_Discount__c, WinningOpp.Corporate_Discount__c);
        System.assertEquals(LosingOpp.Promo_Code__c, WinningOpp.Promo_Code__c);
        System.assertEquals(LosingOpp.Manual_Discount__c, WinningOpp.Manual_Discount__c);
        System.assertEquals(LosingOpp.Discount_Comments__c, WinningOpp.Discount_Comments__c);
        System.assertEquals(LosingOpp.PickUp_or_Ship_Kit__c, WinningOpp.PickUp_or_Ship_Kit__c);
        // System.assertEquals(LosingOpp.Ship_To_Name__c,WinningOpp.Ship_To_Name__c);
        // System.assertEquals(LosingOpp.Ship_To_Street1__c, WinningOpp.Ship_To_Street1__c);
        System.assertEquals(LosingOpp.Ship_To_Phone__c,WinningOpp.Ship_To_Phone__c);
        System.assertEquals(LosingOpp.Total_Expedited_Shipping_Cost__c, WinningOpp.Total_Expedited_Shipping_Cost__c);
        System.assertEquals(LosingOpp.Shipping_Method__c,WinningOpp.Shipping_Method__c);
        System.assertEquals(LosingOpp.Requested_Shipping_Method__c, WinningOpp.Requested_Shipping_Method__c);
        System.assertEquals(LosingOpp.Requested_Shipping_Date__c,WinningOpp.Requested_Shipping_Date__c);
        System.assertEquals(LosingOpp.Saturday_Delivery__c,WinningOpp.Saturday_Delivery__c);
        System.assertEquals(LosingOpp.Signature_Required__c , WinningOpp.Signature_Required__c );
        System.assertEquals(LosingOpp.of_CB__c, WinningOpp.of_CB__c);
        System.assertEquals(LosingOpp.of_CT__c, WinningOpp.of_CT__c);
        System.assertEquals(LosingOpp.Gift_Registry_Start_Date__c, WinningOpp.Gift_Registry_Start_Date__c);
        System.assertEquals(LosingOpp.Gift_Registry_End_Date__c,WinningOpp.Gift_Registry_End_Date__c);
        System.assertEquals(LosingOpp.Adoption_Type__c, WinningOpp.Adoption_Type__c);
        System.assertEquals(LosingOpp.Primary_Source__c, WinningOpp.Primary_Source__c);
        System.assertEquals(LosingOpp.Referred_By_Opportunity__c, WinningOpp.Referred_By_Opportunity__c);
        System.assertEquals(LosingOpp.Section_1_Received__c, WinningOpp.Section_1_Received__c);
        System.assertEquals(LosingOpp.Section_2_Received__c, WinningOpp.Section_2_Received__c);
        System.assertEquals(LosingOpp.Section_3_Received__c, WinningOpp.Section_3_Received__c);
        System.assertEquals(LosingOpp.Section_3_Incomplete__c, WinningOpp.Section_3_Incomplete__c);
        System.assertEquals(LosingOpp.Section_3_Needs_Review__c, WinningOpp.Section_3_Needs_Review__c);
        System.assertEquals(LosingOpp.Section_4_Received__c, WinningOpp.Section_4_Received__c); 
        System.assertEquals(LosingOpp.Section_5_Received__c, WinningOpp.Section_5_Received__c);
        System.assertEquals(LosingOpp.Section_2_Received_Birth_Mother__c, WinningOpp.Section_2_Received_Birth_Mother__c);
        System.assertEquals(LosingOpp.Section_3_Received_Birth_Mother__c, WinningOpp.Section_3_Received_Birth_Mother__c);
        System.assertEquals(LosingOpp.Section_3_Needs_Review_Birth_Mother__c, WinningOpp.Section_3_Needs_Review_Birth_Mother__c);
        System.assertEquals(LosingOpp.Section_5_Received_Birth_Mother__c, WinningOpp.Section_5_Received_Birth_Mother__c);
        System.assertEquals(LosingOpp.Delivering_Hospital__c, WinningOpp.Delivering_Hospital__c);
        system.assertEquals(LosingOpp.StageName,'Closed Lost (10)');
        system.assertEquals(LosingOpp.Status__c,'Closed_Lost');
        System.assertEquals(LosingOpp.Loss_Reason__c,'Duplicate record');
        //Below code check if all opportunityContactRoles are re parented with correct roles
        List<OpportunityContactRole> oppOCRList = [Select id,Role,OpportunityId From OpportunityContactRole Where OpportunityId =:WinningOpp.id ];
        system.assertEquals(oppOCRList.size(),4);
        Boolean OCRRoles = false;
        Set<String> roles = new Set<String>{'Duplicate','Unknown','Mother','Father'};
            for(OpportunityContactRole ocr:oppOCRList){
                if(roles.contains(ocr.Role)){
                    OCRRoles = true;
                }
            }
        system.assertEquals(OCRRoles,true);
        
        //Query on opp provider to check opportuity provider is reparented successfully
        List<Opportunity_Provider__c> oppProList = [Select id,Delivering_Provider__c,Primary_Provider__c,Opportunity__c from Opportunity_Provider__c  where Opportunity__c =:WinningOpp.id ];
        system.assertEquals(oppProList.size(),2);
        
        //Check CampaignInfluence is re parented
        CampaignInfluence winOppCI = [Select id,OpportunityId from CampaignInfluence];
        system.assertEquals(winOppCI.OpportunityId,WinningOpp.id);
        
        //Check open Activities are re-parented.
        Task winOppT = [Select id,Whatid,Subject from task where Subject = 'CallCall'];
        system.assertEquals(winOppT.Whatid,WinningOpp.id);
        
        Event winOppEvent = [Select id,Whatid from Event];
        system.assertEquals(winOppEvent.Whatid,WinningOpp.id);
        
        ContentDocumentLink winOppFile = [Select id,ContentDocumentId,LinkedEntityId,Visibility,ShareType from ContentDocumentLink where LinkedEntityId IN (Select id from opportunity where id=:WinningOpp.id)];
        system.assertEquals(winOppFile.LinkedEntityId,WinningOpp.id);
        
        DocImage_Attachment__c winOppDocImage = [Select id,Opportunity__c from DocImage_Attachment__c];
        system.assertEquals(winOppDocImage.Opportunity__c,WinningOpp.id);
        
        Asset winOppAsset = [Select id,Opportunity__c from Asset];
        system.assertEquals(winOppAsset.Opportunity__c,WinningOpp.id);
        Test.StopTest();
    }
    @isTest static void testMethod2(){
        Test.StartTest();
        List<Opportunity> oppList = [select id,name,Description,Storage_Date__c,Pending_Date__c,StageName,Status__c,OpportunityMerge__c,Primary_Contact_First_Name__c,Primary_Contact_Last_Name__c,due_date__c,CreatedDate,of_Babies__c,of_CB__c,of_CT__c,Adoption_Type__c,Primary_Source__c,Referred_By_Opportunity__c,Section_2_Received_Birth_Mother__c,Section_3_Incomplete_Birth_Mother__c,Section_3_Received_Birth_Mother__c,Section_3_Needs_Review_Birth_Mother__c,Section_1_Received__c,Section_2_Received__c,Section_3_Received__c,Section_3_Incomplete__c,Section_3_Needs_Review__c,Section_4_Received__c,Section_5_Received__c,Delivering_Hospital__c,Payment_Plan__c,Payment_Method__c,CB_Storage_Fee_Option__c,CT_Storage_Fee_Option__c,Corporate_Discount__c,Promo_Code__c,Manual_Discount__c,Discount_Comments__c,PickUp_or_Ship_Kit__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_Phone__c,Total_Expedited_Shipping_Cost__c,Shipping_Method__c,Requested_Shipping_Method__c,Requested_Shipping_Date__c,Saturday_Delivery__c,Signature_Required__c,PriceBook2Id,Opportunity_Merged_By__c,Opportunity_Merged_Date__c,Losing_Opportunity__c,Primary_Contact__c,Secondary_Contact__c,Online_Enrollment__c,Section_5_Received_Birth_Mother__c,OwnerId,Gift_Registry_End_Date__c,Gift_Registry_Start_Date__c,Ship_To_Street2__c,Ship_To_City__c,Ship_To_State__c,Ship_To_Zip_Code__c,Ship_To_Country__c from opportunity];
        Opportunity WinningOpp = new Opportunity();
        opportunity LosingOpp = new Opportunity();
        for(Opportunity opp:oppList){
            if(opp.Description == 'Winning Opportunity'){
                WinningOpp = opp;
            }
            else if(opp.Description == 'Losing Opportunity'){
                LosingOpp = opp;
            }
        }
       List<opportunity> oppupdate = new List<opportunity>();
            WinningOpp.OpportunityMerge__c = LosingOpp.id;
            oppupdate.add(WinningOpp);
       // update WinningOpp;
             LosingOpp.Storage_Date__c = null;
             LosingOpp.Status__c = 'Open';
             oppupdate.add(LosingOpp);
             update oppupdate;
       // update LosingOpp;
        system.debug('WinningOpp status'+WinningOpp.Status__C);
        system.debug('Winning opp due date'+WinningOpp.Due_Date__C);

        system.debug('Losing Storage_Date__c'+LosingOpp.Storage_Date__c);
        system.debug('Losing Pending_Date__c'+LosingOpp.Pending_Date__c);
        system.debug('Status__c======='+LosingOpp.Status__c);
        Provider_Facility__c pf = [Select id,Provider__c,Facility__c,Master_Provider_Facility_ID__c from Provider_Facility__c where Master_Provider_Facility_ID__c = 'MPF1'];
        List<Opportunity_Provider__c> oppProList = [Select id,Delivering_Provider__c,Primary_Provider__c,Opportunity__c,Provider__c,Provider_Facility__c,Facility__c from Opportunity_Provider__c  where Opportunity__c =:WinningOpp.id OR Opportunity__c =:LosingOpp.id];
        Opportunity_Provider__c winOp = new Opportunity_Provider__c();
        Opportunity_Provider__c lossOp = new Opportunity_Provider__c();
        for(Opportunity_Provider__c op:oppProList){
            if(op.Opportunity__c == WinningOpp.id){
                winOp = op;
            }
            else{
                lossOp = op; 
            }
        }
        system.debug('WinningOpp status'+WinningOpp.Status__C);
        system.debug('Winning opp due date'+WinningOpp.Due_Date__C);

        system.debug('Losing Storage_Date__c'+LosingOpp.Storage_Date__c);
        system.debug('Losing Pending_Date__c'+LosingOpp.Pending_Date__c);
        system.debug('Status__c======='+LosingOpp.Status__c);
        List<Opportunity_Provider__c> delOp = new List<Opportunity_Provider__c>();
        delOp.add(lossOp);
        list<DataBase.DeleteResult> saveresults = DataBase.delete(delOp,false);
        system.debug('saveresults'+saveresults);
        Opportunity_Provider__c newLOp = new Opportunity_Provider__c(Facility__c = pf.Facility__c ,Provider__c =pf.Provider__c,Primary_Provider__c = true,Delivering_Provider__c = true,Opportunity__c = LosingOpp.Id,Provider_Facility__c = pf.id);
        // insert newLOp;
        List<Opportunity_Provider__c> insertOps = new List<Opportunity_Provider__c>();
        insertOps.add(newLOp);
        List<Database.SaveResult> insertResult = Database.insert(insertOps,false);
        system.debug('insertResult===='+insertResult);
        
        opportunityMergeController omc = new opportunityMergeController();
        PageReference pageRef = Page.OpportunityMergeTab;
        omc.selectedFields = null;
        omc.winningOppty = WinningOpp;
        omc.LosingOpty = LosingOpp;
        omc.selectedvalue = 'Standard';
        omc.MergeOpportunities();
        omc.radioButtonMethod();
        omc.getOpportunity1();  
        
        Opportunity_Provider__c winOPUpdated = [select id,Delivering_Provider__c,Primary_Provider__c,Opportunity__c,Provider__c,Provider_Facility__c,Facility__c from Opportunity_Provider__c where id =:winOp.id];
        system.assertEquals(winOPUpdated.Delivering_Provider__c,true);
        system.assertEquals(winOPUpdated.Primary_Provider__c,true);
        
        Test.stopTest();
    }
    @isTest static void testMethod3(){
        Test.StartTest();
        List<Opportunity> oppList = [select id,name,Description,Storage_Date__c,Pending_Date__c,StageName,Status__c,OpportunityMerge__c,Primary_Contact_First_Name__c,Primary_Contact_Last_Name__c,due_date__c,CreatedDate,of_Babies__c,of_CB__c,of_CT__c,Adoption_Type__c,Primary_Source__c,Referred_By_Opportunity__c,Section_2_Received_Birth_Mother__c,Section_3_Incomplete_Birth_Mother__c,Section_3_Received_Birth_Mother__c,Section_3_Needs_Review_Birth_Mother__c,Section_1_Received__c,Section_2_Received__c,Section_3_Received__c,Section_3_Incomplete__c,Section_3_Needs_Review__c,Section_4_Received__c,Section_5_Received__c,Delivering_Hospital__c,Payment_Plan__c,Payment_Method__c,CB_Storage_Fee_Option__c,CT_Storage_Fee_Option__c,Corporate_Discount__c,Promo_Code__c,Manual_Discount__c,Discount_Comments__c,PickUp_or_Ship_Kit__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_Phone__c,Total_Expedited_Shipping_Cost__c,Shipping_Method__c,Requested_Shipping_Method__c,Requested_Shipping_Date__c,Saturday_Delivery__c,Signature_Required__c,PriceBook2Id,Opportunity_Merged_By__c,Opportunity_Merged_Date__c,Losing_Opportunity__c,Primary_Contact__c,Secondary_Contact__c,Online_Enrollment__c,Section_5_Received_Birth_Mother__c,OwnerId,Gift_Registry_End_Date__c,Gift_Registry_Start_Date__c,Ship_To_Street2__c,Ship_To_City__c,Ship_To_State__c,Ship_To_Zip_Code__c,Ship_To_Country__c from opportunity];
        Opportunity WinningOpp = new Opportunity();
        opportunity LosingOpp = new Opportunity();
        for(Opportunity opp:oppList){
            if(opp.Description == 'Winning Opportunity'){
                WinningOpp = opp;
            }
            else if(opp.Description == 'Losing Opportunity'){
                LosingOpp = opp;
            }
        }
       List<opportunity> oppupdate = new List<opportunity>();
            WinningOpp.OpportunityMerge__c = LosingOpp.id;
            oppupdate.add(WinningOpp);
       // update WinningOpp;
             LosingOpp.Storage_Date__c = null;
             LosingOpp.Status__c = 'Open';
             oppupdate.add(LosingOpp);
             update oppupdate;
       // update LosingOpp;
        system.debug('WinningOpp status'+WinningOpp.Status__C);
        system.debug('Winning opp due date'+WinningOpp.Due_Date__C);

        system.debug('Losing Storage_Date__c'+LosingOpp.Storage_Date__c);
        system.debug('Losing Pending_Date__c'+LosingOpp.Pending_Date__c);
        system.debug('Status__c======='+LosingOpp.Status__c);
        list<SelectOption> selectedFields = new List<SelectOption>();
        selectedFields.add(new SelectOption('Adoption_Type__c','Adoption_Type__c'));
        selectedFields.add(new SelectOption('of_CB__c','of_CB__c'));
        selectedFields.add(new SelectOption('Gift_Registry_Start_Date__c','Gift_Registry_Start_Date__c'));
       selectedFields.add(new SelectOption('Gift_Registry_End_Date__c','Gift_Registry_End_Date__c'));
        selectedFields.add(new SelectOption('of_CT__c','of_CT__c'));
        selectedFields.add(new SelectOption('of_Babies__c','of_Babies__c'));
        
        opportunityMergeController omc = new opportunityMergeController();
        PageReference pageRef = Page.OpportunityMergeTab;
        omc.selectedFields = selectedFields;
        omc.winningOppty = WinningOpp;
        omc.LosingOpty = LosingOpp;
        omc.selectedvalue = 'Custom';
        omc.MergeOpportunities();
        omc.radioButtonMethod();
        omc.getOpportunity1(); 
        System.assertEquals(LosingOpp.of_Babies__c, WinningOpp.of_Babies__c);
        System.assertEquals(LosingOpp.of_CB__c, WinningOpp.of_CB__c);
        System.assertEquals(LosingOpp.of_CT__c, WinningOpp.of_CT__c);
        System.assertEquals(LosingOpp.Gift_Registry_Start_Date__c, WinningOpp.Gift_Registry_Start_Date__c);
        System.assertEquals(LosingOpp.Gift_Registry_End_Date__c,WinningOpp.Gift_Registry_End_Date__c);
        System.assertEquals(LosingOpp.Adoption_Type__c, WinningOpp.Adoption_Type__c);
        System.assertNotEquals(LosingOpp.Delivering_Hospital__c, WinningOpp.Delivering_Hospital__c);
        
        
        Test.stopTest();
    }
    //TestMethod to pass custom merge with no selected fields to merge
    @isTest static void testMethod4(){
        Test.StartTest();
        try{
            List<Opportunity> oppList = [select id,name,Description,Storage_Date__c,Pending_Date__c,StageName,Status__c,OpportunityMerge__c,Primary_Contact_First_Name__c,Primary_Contact_Last_Name__c,due_date__c,CreatedDate,of_Babies__c,of_CB__c,of_CT__c,Adoption_Type__c,Primary_Source__c,Referred_By_Opportunity__c,Section_2_Received_Birth_Mother__c,Section_3_Incomplete_Birth_Mother__c,Section_3_Received_Birth_Mother__c,Section_3_Needs_Review_Birth_Mother__c,Section_1_Received__c,Section_2_Received__c,Section_3_Received__c,Section_3_Incomplete__c,Section_3_Needs_Review__c,Section_4_Received__c,Section_5_Received__c,Delivering_Hospital__c,Payment_Plan__c,Payment_Method__c,CB_Storage_Fee_Option__c,CT_Storage_Fee_Option__c,Corporate_Discount__c,Promo_Code__c,Manual_Discount__c,Discount_Comments__c,PickUp_or_Ship_Kit__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_Phone__c,Total_Expedited_Shipping_Cost__c,Shipping_Method__c,Requested_Shipping_Method__c,Requested_Shipping_Date__c,Saturday_Delivery__c,Signature_Required__c,PriceBook2Id,Opportunity_Merged_By__c,Opportunity_Merged_Date__c,Losing_Opportunity__c,Primary_Contact__c,Secondary_Contact__c,Online_Enrollment__c,Section_5_Received_Birth_Mother__c,OwnerId,Gift_Registry_End_Date__c,Gift_Registry_Start_Date__c from opportunity];
            Opportunity WinningOpp = new Opportunity();
            opportunity LosingOpp = new Opportunity();
            for(Opportunity opp:oppList){
                if(opp.Description == 'Winning Opportunity'){
                    WinningOpp = opp;
                }
                else if(opp.Description == 'Losing Opportunity'){
                    LosingOpp = opp;
                }
            }
          List<opportunity> oppupdate = new List<opportunity>();
            WinningOpp.OpportunityMerge__c = LosingOpp.id;
            oppupdate.add(WinningOpp);
       // update WinningOpp;
             LosingOpp.Storage_Date__c = null;
             LosingOpp.Status__c = 'Open';
             oppupdate.add(LosingOpp);
             update oppupdate;
       // update LosingOpp;
            system.debug('WinningOpp status'+WinningOpp.Status__C);
        system.debug('Winning opp due date'+WinningOpp.Due_Date__C);

        system.debug('Losing Storage_Date__c'+LosingOpp.Storage_Date__c);
        system.debug('Losing Pending_Date__c'+LosingOpp.Pending_Date__c);
        system.debug('Status__c======='+LosingOpp.Status__c);
            opportunityMergeController omc = new opportunityMergeController();
            PageReference pageRef = Page.OpportunityMergeTab;
            omc.selectedFields = null;
            omc.winningOppty = WinningOpp;
            omc.LosingOpty = LosingOpp;
            omc.selectedvalue = 'Custom';
            omc.MergeOpportunities();
            omc.getOpportunity1();
            
            
        }
        catch(Exception e){
            
        }
        test.StopTest();
    }

    @isTest static void testMethod5(){
        Test.StartTest();
        try{
            List<Opportunity> oppList = [select id,name,Description,Storage_Date__c,Pending_Date__c,StageName,Status__c,OpportunityMerge__c,Primary_Contact_First_Name__c,Primary_Contact_Last_Name__c,due_date__c,CreatedDate,of_Babies__c,of_CB__c,of_CT__c,Adoption_Type__c,Primary_Source__c,Referred_By_Opportunity__c,Section_2_Received_Birth_Mother__c,Section_3_Incomplete_Birth_Mother__c,Section_3_Received_Birth_Mother__c,Section_3_Needs_Review_Birth_Mother__c,Section_1_Received__c,Section_2_Received__c,Section_3_Received__c,Section_3_Incomplete__c,Section_3_Needs_Review__c,Section_4_Received__c,Section_5_Received__c,Delivering_Hospital__c,Payment_Plan__c,Payment_Method__c,CB_Storage_Fee_Option__c,CT_Storage_Fee_Option__c,Corporate_Discount__c,Promo_Code__c,Manual_Discount__c,Discount_Comments__c,PickUp_or_Ship_Kit__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_Phone__c,Total_Expedited_Shipping_Cost__c,Shipping_Method__c,Requested_Shipping_Method__c,Requested_Shipping_Date__c,Saturday_Delivery__c,Signature_Required__c,PriceBook2Id,Opportunity_Merged_By__c,Opportunity_Merged_Date__c,Gift_Registry_End_Date__c,Gift_Registry_Start_Date__c,Losing_Opportunity__c,Primary_Contact__c,Secondary_Contact__c,Online_Enrollment__c,Section_5_Received_Birth_Mother__c,OwnerId from opportunity];
            Opportunity WinningOpp = new Opportunity();
            opportunity LosingOpp = new Opportunity();
            for(Opportunity opp:oppList){
                if(opp.Description == 'Winning Opportunity'){
                    WinningOpp = opp;
                }
                else if(opp.Description == 'Losing Opportunity'){
                    LosingOpp = opp;
                }
            }
            WinningOpp.Status__c  = 'Closed_Lost';
            LosingOpp.Status__c ='Closed_Lost';
            List<Opportunity> oppListUpdate = new List<Opportunity>();
            oppListUpdate.add(WinningOpp);
            oppListUpdate.add(LosingOpp);
            update oppListUpdate;
            
            List<Opportunity> oppList1 = [select id,name,Description,Storage_Date__c,Pending_Date__c,StageName,Status__c,OpportunityMerge__c,Primary_Contact_First_Name__c,Primary_Contact_Last_Name__c,due_date__c,CreatedDate,of_Babies__c,of_CB__c,of_CT__c,Adoption_Type__c,Primary_Source__c,Referred_By_Opportunity__c,Section_2_Received_Birth_Mother__c,Section_3_Incomplete_Birth_Mother__c,Section_3_Received_Birth_Mother__c,Section_3_Needs_Review_Birth_Mother__c,Section_1_Received__c,Section_2_Received__c,Section_3_Received__c,Section_3_Incomplete__c,Section_3_Needs_Review__c,Section_4_Received__c,Section_5_Received__c,Delivering_Hospital__c,Payment_Plan__c,Payment_Method__c,CB_Storage_Fee_Option__c,CT_Storage_Fee_Option__c,Corporate_Discount__c,Promo_Code__c,Manual_Discount__c,Discount_Comments__c,PickUp_or_Ship_Kit__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_Phone__c,Total_Expedited_Shipping_Cost__c,Shipping_Method__c,Requested_Shipping_Method__c,Requested_Shipping_Date__c,Saturday_Delivery__c,Signature_Required__c,PriceBook2Id,Opportunity_Merged_By__c,Opportunity_Merged_Date__c,Losing_Opportunity__c,Primary_Contact__c,Secondary_Contact__c,Online_Enrollment__c,Section_5_Received_Birth_Mother__c,OwnerId,Gift_Registry_End_Date__c,Gift_Registry_Start_Date__c from opportunity];
            
            for(Opportunity opp:oppList){
                if(opp.Description == 'Winning Opportunity'){
                    WinningOpp = opp;
                }
                else if(opp.Description == 'Losing Opportunity'){
                    LosingOpp = opp;
                }
            }


            system.debug('WinningOpp.Status__c======='+WinningOpp.Status__C);
            system.debug('LosingOpp==========='+LosingOpp.Status__C);
            opportunityMergeController omc = new opportunityMergeController();
            PageReference pageRef = Page.OpportunityMergeTab;
            omc.selectedFields = null;
            omc.winningOppty = WinningOpp;
            omc.LosingOpty = LosingOpp;
            omc.selectedvalue = 'Standard';
            omc.MergeOpportunities();
            omc.getOpportunity1();
        }
        catch(Exception e){
            
        }
        test.StopTest();
    }
    @isTest static void testMethod6(){
        Test.StartTest();
        try{
            opportunityMergeController omc = new opportunityMergeController();
            PageReference pageRef = Page.OpportunityMergeTab;
            omc.selectedFields = null;
            omc.winningOppty = null;
            omc.LosingOpty = null;
            omc.selectedvalue = 'Standard';
            omc.MergeOpportunities();
            omc.getOpportunity1();
        }
        catch(Exception e){
            
        }
        test.StopTest();
    }
    //Unit test to check online Enrollment is updated with winning opportunity id
     @isTest static void testMethod7(){
        Test.StartTest();
        try{
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
      oe1.of_CB__c = '2';
      oe1.of_CT__c = '2';
      oe1.Due_Date__c = System.today();
      oe1.Adoption_Type__c = 'Open';
      oe1.Primary_ID_Type__c = 'Passport #';
      oe1.PrimaryID__c = '1234554454677';
      oe1.of_Babies__c='Twins';
      //Insert OLE
      insert oe1;
            List<Opportunity> oppList = [select id,name,Description,Storage_Date__c,Pending_Date__c,StageName,Status__c,OpportunityMerge__c,Primary_Contact_First_Name__c,Primary_Contact_Last_Name__c,due_date__c,CreatedDate,of_Babies__c,of_CB__c,of_CT__c,Adoption_Type__c,Primary_Source__c,Referred_By_Opportunity__c,Section_2_Received_Birth_Mother__c,Section_3_Incomplete_Birth_Mother__c,Section_3_Received_Birth_Mother__c,Section_3_Needs_Review_Birth_Mother__c,Section_1_Received__c,Section_2_Received__c,Section_3_Received__c,Section_3_Incomplete__c,Section_3_Needs_Review__c,Section_4_Received__c,Section_5_Received__c,Delivering_Hospital__c,Payment_Plan__c,Payment_Method__c,CB_Storage_Fee_Option__c,CT_Storage_Fee_Option__c,Corporate_Discount__c,Promo_Code__c,Manual_Discount__c,Discount_Comments__c,PickUp_or_Ship_Kit__c,Ship_To_Name__c,Ship_To_Street1__c,Ship_To_Phone__c,Total_Expedited_Shipping_Cost__c,Shipping_Method__c,Requested_Shipping_Method__c,Requested_Shipping_Date__c,Saturday_Delivery__c,Signature_Required__c,PriceBook2Id,Opportunity_Merged_By__c,Opportunity_Merged_Date__c,Losing_Opportunity__c,Primary_Contact__c,Secondary_Contact__c,Online_Enrollment__c,Section_5_Received_Birth_Mother__c,OwnerId,Gift_Registry_End_Date__c,Gift_Registry_Start_Date__c from opportunity];
            Opportunity WinningOpp = new Opportunity();
            opportunity LosingOpp = new Opportunity();
            for(Opportunity opp:oppList){
                if(opp.Description == 'Winning Opportunity'){
                    WinningOpp = opp;
                }
                else if(String.isNotBlank(opp.Online_Enrollment__C)){
                    LosingOpp = opp;
                }
            }
            
            List<opportunity> oppupdate = new List<opportunity>();
            WinningOpp.OpportunityMerge__c = LosingOpp.id;
            oppupdate.add(WinningOpp);
       // update WinningOpp;
             LosingOpp.Storage_Date__c = null;
             LosingOpp.Status__c = 'Open';
             oppupdate.add(WinningOpp);
             update oppupdate;
       // update LosingOpp;
            opportunityMergeController omc = new opportunityMergeController();
            PageReference pageRef = Page.OpportunityMergeTab;
            omc.selectedFields = null;
            omc.winningOppty = WinningOpp;
            omc.LosingOpty = LosingOpp;
            omc.selectedvalue = 'Standard';
            omc.MergeOpportunities();
            omc.getOpportunity1();
            Online_Enrollment__C ole = [Select id,Opportunity_Id__c from Online_Enrollment__C];
            system.assertEquals(ole.Opportunity_Id__c,WinningOpp.id);
            
        }
        catch(Exception e){
            
        }
        test.StopTest();
    }
    
}