public class subscriptionManagementClass{

    //Student Method
   
    public static void CreateStudent(Student__c newStudent){
        //Check for Duplicates
       
        List<Student__c> lstStudent =[SELECT id FROM Student__c WHERE Email__c=: newStudent.Email__c];
        if(!lstStudent.isEmpty()){
            //update 
            newStudent.id = lstStudent[0].id;
        }else {
            //insert new student
            try{
       Database.SaveResult[] results = Database.insert(lstStudent, false);
            //insert newStudent;
     for (Database.SaveResult sr : results) {
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted student Student ID: ' + sr.getId());
    }
         else {
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Student fields that affected this error: ' + err.getFields());
        }
                }
     }
            }catch(DMLException e)
{
 system.debug('Error Message ' + e.getMessage());   
}
            } 
        }



//Method to insert Student and Subscription records

public static void CreateSubscription(Subscription__c SubscriptionObj, Student__c St){
      
      //List <Student__c> lstStudent = [SELECT Id, (SELECT Id FROM Student_Subscriptions__r) FROM Student__c WHERE Email__c =: St.Email__c];
      // List<Subscription__c> lstSub =[SELECT id, Name FROM Subscription__c WHERE id=: SubscriptionObj.Id];//Query this to find the id of the subscription
        List <Student_Subscription__c> lstStudentSubscription = [SELECT Id, Student__c, Subscription__c FROM Student_Subscription__c WHERE Student__c =: St.id];
          //Check for Duplicates
        for (Student_Subscription__c theStudentSubscription: lstStudentSubscription){
            if(!String.isBlank(theStudentSubscription.Subscription__c)){ //If student subscription is not empty, update with the id of subscription that was queried
                theStudentSubscription.Subscription__r = SubscriptionObj;
                //theStudentSubscription.Subscription__c = lstSub[0].Id; 
            } else{
                Subscription__c newSubscription = new Subscription__c();
                Student__c newStudent = new Student__c();
                Student_Subscription__c newStudentSubscription = new Student_Subscription__c();
                
            }
        } 
}

//Method to insert Programs and Courses

    public static void CreateProgramCourse(Course__c Cs, Program__c Pg){
        List<Program__c> prList = [SELECT Id, Name, (SELECT Id, Name FROM Courses__r) 
                        FROM Program__c WHERE Program_Type__c =: Pg.Program_Type__c];
        If(!prList.isEmpty()){
          Pg.id =prList[0].id; 
        }
        else {
            //insert new Program
            try{
       Database.SaveResult[] results = Database.insert(prList, false);
     for (Database.SaveResult sr : results) {
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted account. Student ID: ' + sr.getId());
    }
         else {
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Student fields that affected this error: ' + err.getFields());
        }
                }
     }
            }catch(DMLException e)
{
 system.debug('Error Message ' + e.getMessage());   
}
            } 
        }


//Method to Insert Courses and Lessons
public static void CreateCourseLessons(Lesson__c Lesson, Course__c Course){
        
        List<Course__c> csList = [SELECT Id, Name, (SELECT Id, Name FROM Lessons__r) 
                        FROM Course__c WHERE Name =: Course.Name];
 
        If(!csList.isEmpty()){
          Course.id =csList[0].id; 
        }
        else {
            //insert new Program
            try{
       Database.SaveResult[] results = Database.insert(csList, false);
     for (Database.SaveResult sr : results) {
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted account. Student ID: ' + sr.getId());
    }
         else {
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Student fields that affected this error: ' + err.getFields());
        }
                }
     }
            }catch(DMLException e)
{
 system.debug('Error Message ' + e.getMessage());   
}
            } 
        }
}
