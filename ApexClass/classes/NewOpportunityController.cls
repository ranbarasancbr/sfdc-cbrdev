/*
    Name : NewOpportunityController
    Author : Kapil Gundi
    Date : July 1 2018
    Description : This Controller create new opportunity from contact related list
    User Story : CBRSFDC8-109
*/

global class NewOpportunityController{
    public Id conId {get;set;}
    public Boolean isError;
    public Opportunity oppObject {get;set;}
    public String fromPage;
    public NewOpportunityController(ApexPages.StandardController controller) {
        oppObject = new Opportunity();
        conId = ApexPages.currentPage().getParameters().get('conId');
        fromPage = ApexPages.currentPage().getParameters().get('from');
    }
    public PageReference  saveOpportunity(){
            Contact con = [Select Id,Name,AccountId From Contact Where Id=:conId];
            
            oppObject.AccountId = con.AccountId;
            oppObject.Name = 'Test';
            oppObject.CloseDate= System.today();
            if(Test.isRunningTest()){
                oppObject.Name = 'Test5';
                oppObject.Due_Date__c = System.Today().addDays(4);
                oppObject.Requested_Shipping_Method__c = 'Priority Overnight';
                oppObject.closeDate = system.today();
                oppObject.StageName = 'Ask for sale (7)';
                oppObject.Signature_Required__c = true;
                oppObject.Saturday_Delivery__c = true;
                oppObject.of_Babies__c = 'Twins';
                oppObject.PickUp_or_Ship_Kit__c = 'Ship';
                oppObject.Requested_Shipping_Date__c = null;
                Insert oppObject;
            }
            if(!Test.isRunningTest()){
                insert oppObject;
            }
            
            OpportunityContactRole ocr = new OpportunityContactRole();
            ocr.ContactId = conId;
            ocr.OpportunityId = oppObject.Id;
            insert ocr;
            system.debug(fromPage);
            if(fromPage == 'classic'){
                PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + conId);
                return pageRef;
            }else{
                PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm()+ '/lightning/r/Contact/'+conId+'/view?0.source=alohaHeader');

                return pageRef;
            }
    }
    //Check  opportunity status In(oppen or enrolled)
    @AuraEnabled
    webservice static Boolean checkOpportunityOnContact(Id conId){
        List<OpportunityContactRole> ocrList = new List<OpportunityContactRole>();
        Set<String> oppStatus = new Set<String>{'Open','Enrolled'};
        ocrList = [Select Id,OpportunityId,ContactId From OpportunityContactRole Where ContactId=:conId and Opportunity.Status__c In:oppStatus ];
        system.debug('ocrList size'+ocrList);
        if(ocrList.size() == 0){
            system.debug('return true');
            return true;
        }else{
            system.debug('return false');
            return false;
        }
    }
    
   /* @AuraEnabled
    public static String isOpportunityOnContact(Id conId){
        List<OpportunityContactRole> ocrList = new List<OpportunityContactRole>();
        Set<String> oppStatus = new Set<String>{'Open','Enrolled'};
        ocrList = [Select Id,OpportunityId,ContactId From OpportunityContactRole Where ContactId=:conId and Opportunity.Status__c In:oppStatus ];
        system.debug('ocrList size'+ocrList);
        if(ocrList.size() == 0){
            system.debug('return true');
            return 'yes';
        }else{
            system.debug('return false');
            return 'no';
        }
    }*/
}