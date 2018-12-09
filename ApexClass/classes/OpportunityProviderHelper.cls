/*
* This is a Helper class for to prevent multiple opportunity providers to be primary or delivering
* Created By: Tek Systems
*/

public class OpportunityProviderHelper {

    Public static void rule(List<Opportunity_Provider__c> oppoList, boolean isInsert, Map<Id,Opportunity_Provider__c> oldMap ) {
        
        list<Id> ListId =new list<Id>();
        list<Id> ListIdForParentNW =new list<Id>();
        map <String,Opportunity_Provider__c> mapOppoPrime =new map <String,Opportunity_Provider__c>();
        map <String,Opportunity_Provider__c> mapOppoDeliver =new map <String,Opportunity_Provider__c>();
        map<ID, List<Opportunity_Provider__c>> parentOppoListMap = new map<ID, List<Opportunity_Provider__c>>();
        Map<id,Set<Id>> mapExistingOpptyProvNames = new Map<Id,Set<Id>>();
        
          for(Opportunity_Provider__c ntnew2 : oppoList){
                ListId.add(ntnew2.Opportunity__c);
                List<Opportunity_Provider__c> tempOppProvider = parentOppoListMap.get(ntnew2.Opportunity__c);
                    if(tempOppProvider == null)
                            parentOppoListMap.put(ntnew2.Opportunity__c, new List<Opportunity_Provider__c>{ntnew2});
                    else
                        tempOppProvider.add(ntnew2); 
            }
        
        List<Opportunity_Provider__c> OppoPrimaryDelivering = [SELECT ID, Opportunity__c,Provider__c, Primary_Provider__c, Delivering_Provider__c, Name
                                                       //FROM Opportunity_Provider__c Where Opportunity__c IN:ListId AND
                                                       //(Delivering_Provider__c = true OR Primary_Provider__c = true)];
                                                       FROM Opportunity_Provider__c Where Opportunity__c IN:ListId];
           for(Opportunity_Provider__c mOppoPrimeDeliver : OppoPrimaryDelivering){
              if(mOppoPrimeDeliver.Delivering_Provider__c) 
                    mapOppoDeliver.put(mOppoPrimeDeliver.Opportunity__c,mOppoPrimeDeliver);
               if(mOppoPrimeDeliver.Primary_Provider__c)
                  mapOppoPrime.put(mOppoPrimeDeliver.Opportunity__c,mOppoPrimeDeliver); 
              Set<Id> OpptyProvNameSet;
              if(mapExistingOpptyProvNames.containsKey(mOppoPrimeDeliver.Opportunity__c))
                  OpptyProvNameSet = mapExistingOpptyProvNames.get(mOppoPrimeDeliver.Opportunity__c);
              else
                  OpptyProvNameSet = new Set<Id>();              
              OpptyProvNameSet.add(mOppoPrimeDeliver.Provider__c);
              mapExistingOpptyProvNames.put(mOppoPrimeDeliver.Opportunity__c,OpptyProvNameSet);   
            }                                            
            System.debug('*****Existing Names: '+mapExistingOpptyProvNames);
        if(isInsert) {
        
            for (Opportunity_Provider__c OppoNew: oppoList ){
                if((OppoNew.Delivering_Provider__c ||OppoNew.Primary_Provider__c )&& !(OppoNew.Delivering_Provider__c && OppoNew.Primary_Provider__c)){
                    if(OppoNew.Delivering_Provider__c && mapOppoDeliver.get(OppoNew.Opportunity__c) != null){
                        OppoNew.Opportunity__c.adderror(System.Label.DeliveringProvider  +': '+  mapOppoDeliver.get(OppoNew.Opportunity__c).Name + ' '+ System.Label.ErrorMessage1 );   
                    } else if (OppoNew.Primary_Provider__c && mapOppoPrime.get(OppoNew.Opportunity__c) != null){
                         OppoNew.Opportunity__c.adderror(System.Label.PrimaryProvider  +': '+ mapOppoPrime.get(OppoNew.Opportunity__c).Name+' ' + System.Label.ErrorMessage1);   
                    }
                }else if (OppoNew.Delivering_Provider__c && OppoNew.Primary_Provider__c){
                    if(mapOppoPrime.get(OppoNew.Opportunity__c) != null && mapOppoDeliver.get(OppoNew.Opportunity__c) == null){
                        OppoNew.Opportunity__c.adderror(System.Label.PrimaryProvider  +': '+ mapOppoPrime.get(OppoNew.Opportunity__c).Name+' ' + System.Label.ErrorMessage1);   
                    }else if (mapOppoDeliver.get(OppoNew.Opportunity__c) != null &&  mapOppoPrime.get(OppoNew.Opportunity__c) == null){
                        OppoNew.Opportunity__c.adderror(System.Label.DeliveringProvider  +': '+  mapOppoDeliver.get(OppoNew.Opportunity__c).Name + ' '+ System.Label.ErrorMessage1 );
                    }else if (mapOppoDeliver.get(OppoNew.Opportunity__c) != null && mapOppoPrime.get(OppoNew.Opportunity__c) != null){
                        OppoNew.Opportunity__c.adderror(System.Label.DeliveringProvider +' : ' +mapOppoDeliver.get(OppoNew.Opportunity__c).Name+' & '+System.Label.PrimaryProvider +' : ' + mapOppoPrime.get(OppoNew.Opportunity__c).Name + ' '+System.label.ErrorMessage2);
                    }
                }
                //if(OppoNew.Provider__c != oldMap.get(OppoNew.Id).Provider__c){
                    if(mapExistingOpptyProvNames.containsKey(OppoNew.Opportunity__c)){
                        if(mapExistingOpptyProvNames.get(OppoNew.Opportunity__c).contains(OppoNew.Provider__c)){
                            OppoNew.Provider__c.adderror(System.Label.ProviderNameAlreadyExists);
                        }
                    }
                //}
            }
        }else  {
            for (Opportunity_Provider__c OppoNew: oppoList ){
                
                if((OppoNew.Delivering_Provider__c ||OppoNew.Primary_Provider__c )&& !(OppoNew.Delivering_Provider__c && OppoNew.Primary_Provider__c)){
                    if(OppoNew.Delivering_Provider__c && mapOppoDeliver.get(OppoNew.Opportunity__c) != null 
                            && mapOppoDeliver.get(OppoNew.Opportunity__c).ID != OppoNew.ID){
                        OppoNew.Opportunity__c.adderror(System.Label.DeliveringProvider  +': '+  mapOppoDeliver.get(OppoNew.Opportunity__c).Name + ' '+ System.Label.ErrorMessage1);   
                    } else if (OppoNew.Primary_Provider__c && mapOppoPrime.get(OppoNew.Opportunity__c) != null 
                                                && mapOppoPrime.get(OppoNew.Opportunity__c).ID != OppoNew.ID){
                         OppoNew.Opportunity__c.adderror(System.Label.PrimaryProvider  +': '+ mapOppoPrime.get(OppoNew.Opportunity__c).Name+' ' + System.Label.ErrorMessage1);    
                    }
                }else if (OppoNew.Delivering_Provider__c && OppoNew.Primary_Provider__c){
                    if(mapOppoPrime.get(OppoNew.Opportunity__c) != null && mapOppoPrime.get(OppoNew.Opportunity__c).ID != OppoNew.ID  && mapOppoDeliver.get(OppoNew.Opportunity__c) == null){
                        OppoNew.Opportunity__c.adderror(System.Label.PrimaryProvider  +': '+ mapOppoPrime.get(OppoNew.Opportunity__c).Name+' ' + System.Label.ErrorMessage1);
                    }else if (mapOppoDeliver.get(OppoNew.Opportunity__c) != null && mapOppoDeliver.get(OppoNew.Opportunity__c).ID != OppoNew.ID && mapOppoPrime.get(OppoNew.Opportunity__c) == null){
                         OppoNew.Opportunity__c.adderror(System.Label.DeliveringProvider  +': '+  mapOppoDeliver.get(OppoNew.Opportunity__c).Name + ' '+ System.Label.ErrorMessage1);
                        
                    }else if (mapOppoDeliver.get(OppoNew.Opportunity__c) != null && mapOppoPrime.get(OppoNew.Opportunity__c) != null && (mapOppoDeliver.get(OppoNew.Opportunity__c).ID != OppoNew.ID && mapOppoPrime.get(OppoNew.Opportunity__c).ID != OppoNew.ID)){
                         OppoNew.Opportunity__c.adderror(System.Label.DeliveringProvider +' : ' +mapOppoDeliver.get(OppoNew.Opportunity__c).Name+' & '+System.Label.PrimaryProvider +' : ' + mapOppoPrime.get(OppoNew.Opportunity__c).Name + ' '+System.label.ErrorMessage2);
                    } else if (mapOppoDeliver.get(OppoNew.Opportunity__c) != null && mapOppoPrime.get(OppoNew.Opportunity__c) != null && (mapOppoDeliver.get(OppoNew.Opportunity__c).ID != OppoNew.ID || mapOppoPrime.get(OppoNew.Opportunity__c).ID != OppoNew.ID)){
                        if(mapOppoDeliver.get(OppoNew.Opportunity__c).ID != OppoNew.ID)
                            OppoNew.Opportunity__c.adderror(System.Label.DeliveringProvider +' : ' +mapOppoDeliver.get(OppoNew.Opportunity__c).Name+ ' '  +System.label.ErrorMessage1);  
                        else if(mapOppoPrime.get(OppoNew.Opportunity__c).ID != OppoNew.ID)
                            OppoNew.Opportunity__c.adderror(System.Label.PrimaryProvider +' : ' +mapOppoPrime.get(OppoNew.Opportunity__c).Name+ ' '  +System.label.ErrorMessage1); 
                    }    
                }
                System.debug('OppoNew.Provider__c===>>>'+OppoNew.Provider__c);
                System.debug('Map===>>>'+oldMap.get(OppoNew.Id).Provider__c);
                if(OppoNew.Provider__c != oldMap.get(OppoNew.Id).Provider__c){
                    if(mapExistingOpptyProvNames.containsKey(OppoNew.Opportunity__c)){
                        if(mapExistingOpptyProvNames.get(OppoNew.Opportunity__c).contains(OppoNew.Provider__c)){
                            OppoNew.Provider__c.adderror(System.Label.ProviderNameAlreadyExists);
                        }
                    }
                }
            }
        }   
    }
}