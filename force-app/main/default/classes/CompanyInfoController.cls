public class CompanyInfoController {
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getCompanyInfo() {
        Organization org = [SELECT Name, Street, City, PostalCode, State, Country FROM Organization LIMIT 1];
        
        Map<String, String> companyInfo = new Map<String, String>();
        companyInfo.put('name', org.Name);
        companyInfo.put('street', org.Street);
        companyInfo.put('city', org.City);
        companyInfo.put('postalCode', org.PostalCode);
        companyInfo.put('state', org.State);
        companyInfo.put('country', org.Country);
        
        system.debug('companyInfo'+companyInfo);
        return companyInfo;
        
    }
}