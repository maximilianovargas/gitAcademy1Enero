// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

/**
String texto
Integer numero
Decimal numero con coma
Boolean un booleano (true o false)
 */
List<Account> accounts = new List<Account>();

Account anAccount = new Account(
	Name = 'Creando segunda Cuenta Junio'
);
accounts.add(anAccount);
Account anOtherAccount = new Account(
	Name = 'Creando segunda Cuenta Junio'
);
accounts.add(anOtherAccount);

//insert anAccount;
//insert anOtherAccount;

insert accounts;
//otra forma de insertar registros
Database.SaveResult[] results = Database.insert(accounts,false);

//ver si se inserto o no
Boolean paso = results[0].isSuccess();
//ver si tiene mensaje de error
String error = results[0].getErrors()[0].getMessage();

/*
    insert
    update
    delete
    undelete
    upsert
 */

map<String,Account> customerByDni = new Map<String,Account>();

customerByDni.put('33333333', new Account( Name = 'Maximiliano', document_Number__c = '33333333'));

Account myAccount = customerByDni.get('33333333');

String name = myAccount.Name;

system.debug(name);
Account anAccount = new Account();
anAccount =  [
    SELECT Name, CreatedBy.Name
    FROM Account
    WHERE Name = 'Creando Cuenta Junio'
    LIMIT 1
];

System.debug(anAccount.CreatedBy.Name);

Account anAccount = MyFirstClass.getAccountViaStatic('Creando Cuenta Junio');

MyFirstClass myClass = new MyFirstClass();

Account anAccount = myClass.getAccount('Creando Cuenta Junio');


HttpResponse response = StarwarsApi.getStarwarsPeopleByNumber('22');
System.debug(response.getBody());
////////////// future ////////////
List<Account> accounts = [
    SELECT Id, Name
    FROM Account
    WHERE Active__c = 'Yes'
];

List<Id> accountsIds = new List<Id>();
Id myId;
for(Account anAccount: accounts){
    accountsIds.add(anAccount.Id);
}

AsyncClassJune.updateAccounts(accountsIds);
////////////////// queueable ////////////////////
List<Account> accounts = [
    SELECT Id, Name
    FROM Account
    WHERE Active__c = 'Yes'
];

AsyncClassJune enqueue = new AsyncClassJune(accounts);

Id idJob = System.enqueueJob(enqueue);

System.debug(idJob);

AsyncApexJob myJob = [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :idJob];
System.debug(myJob.Status);

/////////// batch /////////
CloseOpportunitiesBatch myBatch = new CloseOpportunitiesBatch('YESTERDAY');
Id idJob = Database.executeBatch(myBatch, 20);

System.debug(idJob);

AsyncApexJob myJob = [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :idJob];
System.debug(myJob.Status);


////// SCHEDULE //////

String cron = '0 0 12 * * ?';
Id idJob  = System.schedule('Cerrar oportunidades junio', cron, new CloseOpportunitySchedule());

