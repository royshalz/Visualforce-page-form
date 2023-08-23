public class CustInfos { 
    public String FirstName{get; set;}
    public String LastName{get; set;}
    public String PhoneNumber{get; set;}
    public String Email{get; set;}
    public String Website{get; set;}
    public String Language{get; set;}
public List<Account> CustomerList { get; set; }
    
    public void save(){
         boolean isValidNumber=IsValidNum(PhoneNumber) ;
         boolean isValidEmail=IsValidEmail(Email) ;

        
		Account acc = new Account();
         
        if(isValidNumber){
            if (isValidEmail) {
        	acc.Name = FirstName+ ' ' + LastName;
        	acc.Phone = PhoneNumber;
        	acc.Email__c = Email;
        	acc.Website = website;
        	acc.Language__c = language;
    
        	insert acc;
        
        	Contact cont = new Contact();
        	cont.FirstName = FirstName;
       		cont.LastName = LastName;
       		cont.Phone = PhoneNumber;
        	cont.Email = Email;
       		cont.AccountId = acc.Id;
        
        	insert cont;
        	ListCustInfo();
        	clearFields();        
   			}
    
            else{
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid Email '));
       		}
       }
       else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Phone Number must be of 10 digit'));
        }
        
}
    private void clearFields() {
        FirstName = null;
        LastName = null;
        PhoneNumber = null;
        Email = null;
        Website = null;
        Language = null;
        
    }
    private Boolean IsValidNum(String PhoneNumber){
            return phoneNumber != null && PhoneNumber.length() == 10 && PhoneNumber.isNumeric();
        
    }
    private Boolean IsValidEmail(String Email){
        return Email != null && Pattern.matches('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,4}',Email);
        
    }
    
    public List<Account> ListCustInfo() {
        CustomerList = [SELECT Id, Name, Phone, Email__c, Website, Language__c FROM Account   order by CreatedDate desc limit 1 ];

		return CustomerList;   
    }
}