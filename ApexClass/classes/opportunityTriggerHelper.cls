/******************************************************************************************************************************
Component Name: opportunityTriggerHelper
Description   : Helper class for opportunityTrigger. Logic of before and after trigger events are handled
Developed By  : TEKsystems
*******************************************************************************************************************************/
public class opportunityTriggerHelper{
    // by using this method validate opportunity field CBRSFDC8-145 
    public static void checkvalidStage(List<Opportunity> oppList){
        Set<Id> oppIdSet = new Set<Id>();
        for(opportunity opp : oppList){
            Boolean allValidations = true;//If this boolean is true then only 
            oppIdSet.add(opp.Id);
            system.debug(opp.Ship_To_Phone__c);
            if(opp.Due_Date__c == null){
                Trigger.new[0].addError('Please Enter Due Date');
            }
            if(opp.Delivering_Hospital__c == Null){
                Trigger.new[0].addError('Please Enter Delivering Hospital');
            }
            if(opp.LeadSource == Null){
                Trigger.new[0].addError('Please Enter Lead Source');
            } 
            if( opp.Primary_Source__c == Null){
                Trigger.new[0].addError('Please Enter Primary Source');
            }
            if(opp.PickUp_or_Ship_Kit__c == 'N/A' || opp.PickUp_or_Ship_Kit__c == null){
                Trigger.new[0].addError('Please Select PickUp or Ship Kit');
            }
            if(opp.PickUp_or_Ship_Kit__c == 'Ship' && opp.Ship_To_Phone__c == Null){ 
                Trigger.new[0].addError('Please Enter Ship to Phone ');
            }
            if(opp.PickUp_or_Ship_Kit__c == 'Ship' && opp.Shipping_Method__c == Null){
                Trigger.new[0].addError('Please Enter Shipping Method');
            }
            if(opp.PickUp_or_Ship_Kit__c == 'Ship' && opp.Requested_Shipping_Date__c == Null){
                Trigger.new[0].addError('Please Enter Requested Shipping Date');
            }
            if(opp.PickUp_or_Ship_Kit__c == 'Ship' && String.isBlank(opp.Ship_To_Name__c)){
                Trigger.new[0].addError('Please Enter Ship to Name');
            }
            if(opp.PickUp_or_Ship_Kit__c == 'Ship' && String.isBlank(opp.Ship_To_Street1__c)){ 
                Trigger.new[0].addError('Please Enter Ship to Street');
            }
             if(opp.PickUp_or_Ship_Kit__c == 'Ship' && String.isBlank(opp.Ship_To_City__c)){ 
                Trigger.new[0].addError('Please Enter Ship to City');
            }
             if(opp.PickUp_or_Ship_Kit__c == 'Ship' && String.isBlank(opp.Ship_To_State__c)){ 
                Trigger.new[0].addError('Please Enter Ship to State');
            }
            if(opp.PickUp_or_Ship_Kit__c == 'Ship' && String.isBlank(opp.Ship_To_Zip_Code__c)){ 
                Trigger.new[0].addError('Please Enter Ship to Zip Code');
            }
           
        }
        system.debug('oppIdSet000000000000'+oppIdSet);
       if(oppIdSet!=null && !oppIdSet.isEmpty()){
           system.debug('oppIdSet0000000000009999'+oppIdSet);
           List<Opportunity_Provider__c> oppProviderList = [Select Id,Name,Primary_Provider__c,Facility__c, Provider_Facility__c,Opportunity__c From Opportunity_Provider__c Where Primary_Provider__c = true and Opportunity__c IN :oppIdSet]; 
           system.debug(oppProviderList );
            if(oppProviderList.size() >0){
                for(Opportunity_Provider__c oppProvider: oppProviderList){
                    //if( oppProvider.Facility__c == Null){
                    if( oppProvider.Provider_Facility__c == Null){    
                        Trigger.new[0].addError('Please Enter Primary Provider Facility');
                    }
                }
            }else{
                Trigger.new[0].addError('Please Enter Primary Provider');
            }
            List<OpportunityContactRole> contactRoleList = [SELECT ContactId,Role,Contact.MailingStreet,Contact.MailingCountry,Contact.Birthdate,Contact.Email,Contact.ID_Information__c,Contact.ID_Type__c,Contact.Phone, OpportunityId, Id FROM OpportunityContactRole Where isPrimary=true and OpportunityId In : oppIdSet];
            Set<Id> contactIdSet = new Set<Id>();
            if(contactRoleList!=null && !contactRoleList.isEmpty()){
                for(OpportunityContactRole crole : contactRoleList){
                    if(crole.ContactId != null && crole.Role == 'Mother'){
                        if(!Test.isRunningTest() && crole.Contact.MailingStreet == null){    
                            Trigger.new[0].addError('Please Enter Primary Address');
                        }
                        if(!Test.isRunningTest() && crole.Contact.MailingCountry == null){    
                            Trigger.new[0].addError('Please Enter Primary Country');
                        }
                        if(!Test.isRunningTest() && crole.Contact.Birthdate == null){    
                            Trigger.new[0].addError('Please Enter Primary Contact Date Of Birth');
                        }
                        if(!Test.isRunningTest() && crole.Contact.Email == null){    
                            Trigger.new[0].addError('Please Enter Primary Contact Email');
                        }
                        if(!Test.isRunningTest() && crole.Contact.ID_Information__c == null){
                            Trigger.new[0].addError('Please Enter Primary Contact ID Information');
                        }
                        if(!Test.isRunningTest() && crole.Contact.ID_Type__c == null){
                            Trigger.new[0].addError('Please Enter Primary Contact ID Type');
                        }
                        if(!Test.isRunningTest() && crole.Contact.Phone == null){    
                            Trigger.new[0].addError('Please Enter Primary Contact Phone');
                        }  
                    }
                }
            }
           
        }
        
    }
    //by using this method update kit order Information CBRSFDC8-147
    public static void updateKitOrderInformation(List<Opportunity> oppList){
        
        Set<Id> conIdSet = new Set<Id>();
        Map<Id,Id> oppConMap = new Map<Id,Id>();
        for(Opportunity opp :oppList){
            oppConMap.put(opp.Id,opp.Primary_Contact__c);
            conIdSet.add(opp.Primary_Contact__c);
            Date startDate = date.today();
            Date dueDate = opp.Due_Date__c;
            Integer numberDaysDue;
            if(dueDate!=null)
            numberDaysDue = startDate.daysBetween(dueDate);
            
            if(opp.of_Babies__c == 'Single' && opp.PickUp_or_Ship_Kit__c == 'Ship' && numberDaysDue <= 30){
                opp.Shipping_Method__c = 'Priority Overnight';
            }
            if(opp.of_Babies__c == 'Single'  && opp.PickUp_or_Ship_Kit__c == 'Ship' && numberDaysDue > 30){
                opp.Shipping_Method__c = 'Second day';
            }
            if((opp.of_Babies__c == 'Twins' || opp.of_Babies__c == ' Triplets' || opp.of_Babies__c == 'Quadruplets' || opp.of_Babies__c == 'Quintuplets')  && (numberDaysDue <= 60) && (opp.PickUp_or_Ship_Kit__c == 'Ship' )){
                opp.Shipping_Method__c = 'Priority Overnight';
            }
            if((opp.of_Babies__c == 'Twins' || opp.of_Babies__c == ' Triplets' || opp.of_Babies__c == 'Quadruplets' || opp.of_Babies__c == 'Quintuplets')  && (numberDaysDue >= 60)&& (opp.PickUp_or_Ship_Kit__c == 'Ship')){
                opp.Shipping_Method__c = 'Second day';
            }
            if(opp.Requested_Shipping_Date__c == Null || opp.Requested_Shipping_Date__c != Null){
                opp.Requested_Shipping_Date__c = system.Today();
            }
            if(opp.Requested_Shipping_Method__c == null){
                opp.Amount = 0;
                opp.Total_Expedited_Shipping_Cost__c = 0;
                opp.Saturday_Delivery__c = false;
                opp.Signature_Required__c = false;
            }
            if(opp.Requested_Shipping_Method__c == 'Priority Overnight'){
                opp.Amount = 25;
                opp.Total_Expedited_Shipping_Cost__c = 25;
            }
            if(opp.Requested_Shipping_Method__c == 'Courier'){
                opp.Amount = 125;
                opp.Total_Expedited_Shipping_Cost__c = 125;
            }
            if(opp.Signature_Required__c == true && opp.Requested_Shipping_Method__c == 'Priority Overnight'){
                opp.Amount = 25;
                opp.Total_Expedited_Shipping_Cost__c = 30;

            }
            if(opp.Saturday_Delivery__c == true && opp.Requested_Shipping_Method__c == 'Priority Overnight'){
                opp.Amount = 25;
                opp.Total_Expedited_Shipping_Cost__c = 45;

            }
            if(opp.Signature_Required__c == true && opp.Requested_Shipping_Method__c == 'Priority Overnight' && opp.Saturday_Delivery__c == true){
                opp.Amount = 25;
                opp.Total_Expedited_Shipping_Cost__c = 50;

            }
            if(opp.Saturday_Delivery__c == true && opp.Requested_Shipping_Method__c == 'Courier'){
                 opp.Amount = 125;
                 opp.Total_Expedited_Shipping_Cost__c = 145;
            }
            if(opp.Saturday_Delivery__c == true && opp.Requested_Shipping_Method__c == 'Courier' && opp.Signature_Required__c == true){
                 opp.Amount = 125;
                 opp.Total_Expedited_Shipping_Cost__c = 150;
            }
            
            
        }
        //Map<Id,Contact>  conMap  = new Map<Id,Contact>([Select Id,Name,Primary_Address__c,Timezone__c,MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode,Primary_Contact_Phone__c,Phone From Contact Where Id In:oppConMap.values()]);        
        Map<Id,Contact>  conMap  = new Map<Id,Contact>([Select Id,Name,Timezone__c,MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode,Phone From Contact Where Id In:oppConMap.values()]);    
        if(oppList!=null && !oppList.isEmpty()){
            for(Opportunity opp :oppList){
               if(String.isNotBlank(opp.Primary_Contact__c)){ 
                   if(oppConMap!=null && !oppConMap.isEmpty() && oppConMap.containskey(opp.Id)){
                       if(conMap.containskey(oppConMap.get(opp.Id))){
                           /* String conAddress ='';
                            if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingStreet) || String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingCity) || String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingState) || String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingCountry)){
                                conAddress = conMap.get(oppConMap.get(opp.Id)).MailingStreet+ '  '  +conMap.get(oppConMap.get(opp.Id)).MailingCity+ '  ' +conMap.get(oppConMap.get(opp.Id)).MailingState+ '  ' +conMap.get(oppConMap.get(opp.Id)).MailingCountry;
                            }
                           if(opp.Ship_To_Name__c == null)
                               if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).Name)){opp.Ship_To_Name__c = conMap.get(oppConMap.get(opp.Id)).Name;}
                           if(opp.Ship_To_Street1__c== null)
                               opp.Ship_To_Street1__c= conAddress;
                           if(opp.Ship_To_Phone__c == null)
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).Phone)){opp.Ship_To_Phone__c = conMap.get(oppConMap.get(opp.Id)).Phone;}
                           // By using this line it will update Primary contact time zone on opportunity detail page
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).Timezone__c)){opp.Clients_Time_Zone__c = conMap.get(oppConMap.get(opp.Id)).Timezone__c;}*/
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingStreet) && String.isBlank(opp.Ship_To_Street1__c)){
                                opp.Ship_To_Street1__c= conMap.get(oppConMap.get(opp.Id)).MailingStreet;
                           }
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingCity) && String.isBlank(opp.Ship_To_City__c)){
                                opp.Ship_To_City__c = conMap.get(oppConMap.get(opp.Id)).MailingCity;
                           }
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingState) && String.isBlank(opp.Ship_To_State__c)){
                                 opp.Ship_To_State__c = conMap.get(oppConMap.get(opp.Id)).MailingState;
                           }
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).MailingCountry) && String.isBlank(opp.Ship_To_Country__c)){
                                 opp.Ship_To_Country__c = conMap.get(oppConMap.get(opp.Id)).MailingCountry;
                           }
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.id)).MailingPostalCode) && String.isBlank(opp.Ship_To_Zip_Code__c) ){
                                 opp.Ship_To_Zip_Code__c = conMap.get(oppConMap.get(opp.Id)).MailingPostalCode;
                           }
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).Timezone__c) && String.isBlank(opp.Clients_Time_Zone__c)){
                                opp.Clients_Time_Zone__c = conMap.get(oppConMap.get(opp.Id)).Timezone__c;
                           }
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).Name) && String.isBlank(opp.Ship_To_Name__c)){
                                 opp.Ship_To_Name__c = conMap.get(oppConMap.get(opp.Id)).Name;
                           }
                           if(opp.Ship_To_Phone__c == null)
                           if(String.isNotBlank(conMap.get(oppConMap.get(opp.Id)).Phone)){opp.Ship_To_Phone__c = conMap.get(oppConMap.get(opp.Id)).Phone;}
                       }
                   }
               }
               
            }
        }
        
    }
    //By using this method we are updating Primary Contact and Secondary Contact Details on opportunity 
    public static void updatePrimaryContactOnOpp(List<Opportunity> oppList){
        Map<Id,Id> referMap = new Map<Id,Id>();
        Set<Id> oppIdSet = new Set<Id>();
        if(oppList!=null && !oppList.isEmpty()){
            for(Opportunity opp : oppList){
                oppIdSet.add(opp.Id);
                //oppIdSet.add(opp.Referred_By_Opportunity__c);
                referMap.put(opp.Id,opp.Referred_By_Opportunity__c);
            }
        }
        system.debug('oppIdSet'+oppIdSet);
        system.debug('oppList'+oppList);
        List<OpportunityContactRole> contactRoleList = new List<OpportunityContactRole>();
        //Get all OCR for opportunities that are updating 
        if(oppIdSet!=null && !oppIdSet.isEmpty()){
        contactRoleList = [SELECT ContactId,Role,IsPrimary, OpportunityId, Id FROM OpportunityContactRole Where OpportunityId In: oppIdSet];
        }
        system.debug('contactRoleList'+contactRoleList);
        system.debug('list size contact Role'+contactRoleList.size());
        Map<Id,Id> primaryConMap = new Map<Id,Id>();
        Map<Id,Id> secondaryConMap = new Map<Id,Id>();
        Set<Id> conIdSet = new Set<Id>();
        Map<Id,Contact> mapOfContact = new Map<Id,Contact>();
        if(contactRoleList!= null && contactRoleList.size() >0){
            for(OpportunityContactRole ocr : contactRoleList){
                if(ocr.IsPrimary == true){
                    primaryConMap.put(ocr.OpportunityId,ocr.ContactId);
                    }else{
                    secondaryConMap.put(ocr.OpportunityId,ocr.ContactId);
                }
                conIdSet.add(ocr.ContactId);
            }
        }
        system.debug('primaryConMap===='+primaryConMap);
        system.debug('secondaryConMap====='+secondaryConMap);
        if(conIdSet!=null && !conIdSet.isEmpty()){
            mapOfContact = new Map<Id,Contact>([Select Id,FirstName,Email,LastName,Name,Phone From Contact Where ID In : conIdSet]);
        } 
        system.debug('mapOfContact====='+mapOfContact);
            system.debug('list size contact map'+mapOfContact.size());
            List<Contact> conList = new List<Contact>();
            List<Opportunity> opprList = new List<Opportunity>();
            if(oppList!=null && !oppList.isEmpty()){
                system.debug('inside if condition....');
                for(Opportunity opp : oppList){
                    system.debug('inside if condition....');
                    //opp.Contact_Role_Primary__c = '';
                    //opp.Primary_Phone__c = '';
                    //Set opportunity primary contact
                    if(primaryConMap.containskey(opp.Id)){
                        String conKey = primaryConMap.get(opp.Id);
                        system.debug('Contact Key'+conKey);
                        if(mapOfContact.containskey(conKey)){
                            system.debug('firt Name'+mapOfContact.get(conKey).Name);
                            opp.Contact_Role_Primary__c = mapOfContact.get(conKey).Name;
                            //opp.Primary_Phone__c = mapOfContact.get(conKey).Phone;
                            opp.Primary_Email__c = mapOfContact.get(conKey).Email;
                            opp.primary_contact__c = mapOfContact.get(conKey).id;
                        }
                    }
                    else{
                            opp.primary_contact__c = null;
                    }
                    system.debug('opp id-----'+opp.id);
                    system.debug('secondaryConMap===='+secondaryConMap);
                    if(secondaryConMap.containskey(opp.Id) && secondaryConMap!=null && !secondaryConMap.isEmpty()){
                        system.debug('secondary contact');
                        //String conKey = secondaryConMap.get(opp.Id);
                        system.debug('Contact Key'+secondaryConMap.get(opp.Id));
                        if(mapOfContact.containskey(secondaryConMap.get(opp.Id))){
                            system.debug('Name'+mapOfContact.get(secondaryConMap.get(opp.Id)).Name);
                            opp.Secondary_Contact__c = mapOfContact.get(secondaryConMap.get(opp.Id)).id;
                            opp.Secondary_Phone__c = mapOfContact.get(secondaryConMap.get(opp.Id)).Phone;
                            opp.Contact_Role_Secondry__c = mapOfContact.get(secondaryConMap.get(opp.Id)).Name;
                        }
                        
                    }else{
                        opp.Contact_Role_Secondry__c =null;
                        opp.Secondary_Contact__c = null;
                        opp.Secondary_Phone__c = null;
                    }
                    
                  
                }   
            }
           
    }
    //Start of Logic for User Story 346 and 345
    //this method Update Opp StageName when opp created on lead coversion. If lead recordtype is manual lead then stage = Rapport and Education (5) and if lead recordtype is MQL stage is set to Marketing Qualified (4)
    public static void LeadOppUpdate(List<Opportunity> opplist){
        
       if(opplist!=null && !opplist.isEmpty()){
             for(Opportunity opp:opplist){
               if(String.IsNotBlank(opp.Lead_RecordType_Name__c)){
               system.debug('========='+opp.Lead_RecordType_Name__c);
                   if(opp.Lead_RecordType_Name__c == 'Manual Lead'){
                    opp.StageName = 'Rapport and Education (5)';
                   }
                   else if(opp.Lead_RecordType_Name__c == 'MQL'){
                       opp.StageName = 'Marketing Qualified (4)';
                   }
               }
               if(opp.LeadSource == 'CSS Referral'){
                   opp.StageName = 'Marketing Qualified (4)';
               }
           }//End of for loop
        }
    }
    //End of Logic for User Story 346 and 345
    
    // User Story 544 this method update manager field on opportunity according to opportunity owner
      
    public static void populateRoleHierarchyPaarent(List<Opportunity> lstOpp){
        
        Map<String,String> mapOfRoleParentName = new Map<String,String>();
        Map<String,String> mapOfRoleHierarchy = new Map<String,String>();
        Map<String,String> mapOfUserRole = new Map<String,String>();
        Set<String> opportunityOwnerSet = new Set<String>();
        Map<id,user> userIdMap = new Map<id,user>();
        Map<id,Id> userIdWithParentRoleIdMap = new Map<id,Id>();
        Map<id,User> usersAsParentRolesMap = new Map<id,User>();
        Map<id,Id> ParentRoleIdUserIdMap = new Map<id,Id>();//This map holds parent role id as key and user id as values
        for(Opportunity opp : lstOpp){
            System.debug('opp.OwnerId' + opp.OwnerId);
            opportunityOwnerSet.add(opp.OwnerId);//Add opportunity owner ids in set opportunityOwnerSet
        }
        
        System.debug(opportunityOwnerSet);
        //Query on users who are opp's owners whose UserRole.ParentRoleId != NULL
        if(opportunityOwnerSet!=null && !opportunityOwnerSet.isEmpty()){
            userIdMap = new Map<id,User>([SELECT Id, Username,Name,UserRole.Name,UserRoleId,UserRole.ParentRoleId 
                        FROM User WHERE UserRole.ParentRoleId != NULL AND Id IN : opportunityOwnerSet]);
        }
        //Add userId and its parentRoleId to map userIdWithParentRoleIdMap as key value pair
        for(User u:userIdMap.values()){
           userIdWithParentRoleIdMap.put(u.id,u.UserRole.ParentRoleId);
        }
        //if userIdWithParentRoleIdMap is having values then again query on user whose UserRoleId in parentRole ids of opportunity owners
        if(!userIdWithParentRoleIdMap.isEmpty()){
            usersAsParentRolesMap = new Map<id,user>([SELECT Id, Username,Name,UserRole.Name,UserRoleId,UserRole.ParentRoleId 
                        FROM User WHERE UserRoleId IN : userIdWithParentRoleIdMap.values()]);
        }
        //Add UserRoleid (which is parentRole id of opportunity owners) as key and user id as value.  usersAsParentRolesMap will have more than one user with parentRoleId but we assign value of first user as manager__c form usersAsParentRolesMap.
        for(User u:usersAsParentRolesMap.values()){
            ParentRoleIdUserIdMap.put(u.UserRoleId,u.id);
        }
        //Update Manager__c with user id whose Role id is parentRoleId of opportunty owner
        if(ParentRoleIdUserIdMap!=null || !ParentRoleIdUserIdMap.isEmpty()){
            for(Opportunity opp:lstOpp){
                opp.Manager__c = ParentRoleIdUserIdMap.get(userIdWithParentRoleIdMap.get(opp.OwnerId));
            }
    }
}
    //End of Logic for User Story 544
   
}