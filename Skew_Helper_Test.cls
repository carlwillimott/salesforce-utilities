@IsTest
private class Skew_Helper_Test {

    @IsTest
    private static void getAccountsWithTheMostContacts_Test() {

        List<AggregateResult> res = Skew_Helper.getAccountsWithTheMostContacts();

        System.assert(res[0].get('AccName') == 'ACC_1');
        System.assert((Integer) res[0].get('Total') == 3);

        System.assert(res[1].get('AccName') == 'ACC_2');
        System.assert((Integer) res[1].get('Total') == 2);

    }

    @IsTest
    private static void getAccountsWithTheMostOpportunities_Test() {

        List<AggregateResult> res = Skew_Helper.getAccountsWithTheMostOpportunities();

        System.assert(res[0].get('AccName') == 'ACC_1');
        System.assert((Integer) res[0].get('Total') == 3);

        System.assert(res[1].get('AccName') == 'ACC_2');
        System.assert((Integer) res[1].get('Total') == 2);

    }

    @IsTest
    private static void getAccountsWithTheMostCases_Test() {

        List<AggregateResult> res = Skew_Helper.getAccountsWithTheMostCases();

        System.assert(res[0].get('AccName') == 'ACC_1');
        System.assert((Integer) res[0].get('Total') == 4);

        System.assert(res[1].get('AccName') == 'ACC_2');
        System.assert((Integer) res[1].get('Total') == 2);

        System.assert(res[2].get('AccName') == 'ACC_3');
        System.assert((Integer) res[2].get('Total') == 1);

    }

    @IsTest
    private static void getTopOwnersForSObject_Test() {

        System.assert(Skew_Helper.getTopOwnersForSObject(null) == null);
        System.assert(Skew_Helper.getTopOwnersForSObject('') == null);

        List<AggregateResult> res1 = Skew_Helper.getTopOwnersForSObject('Account');

        System.assert(res1[0].get('OwnerName') == 'John Smith');
        System.assert((Integer) res1[0].get('Total') == 3);

        List<AggregateResult> res2 = Skew_Helper.getTopOwnersForSObject('Contact');

        System.assert(res2[0].get('OwnerName') == 'Daniel James');
        System.assert((Integer) res2[0].get('Total') == 3);

        System.assert(res2[1].get('OwnerName') == 'Mary Adams');
        System.assert((Integer) res2[1].get('Total') == 2);

        List<AggregateResult> res3 = Skew_Helper.getTopOwnersForSObject('Opportunity');

        System.assert(res3[0].get('OwnerName') == 'John Smith');
        System.assert((Integer) res3[0].get('Total') == 4);

        System.assert(res3[1].get('OwnerName') == 'Mary Adams');
        System.assert((Integer) res3[1].get('Total') == 1);

        List<AggregateResult> res4 = Skew_Helper.getTopOwnersForSObject('Case');

        System.assert(res4[0].get('OwnerName') == 'Daniel James');
        System.assert((Integer) res4[0].get('Total') == 4);

        System.assert(res4[1].get('OwnerName') == 'Mary Adams');
        System.assert((Integer) res4[1].get('Total') == 3);

    }

    @IsTest
    private static void getTopRelationshipsForRelatedSObject_Test() {

        System.assert(Skew_Helper.getTopRelationshipsForRelatedSObject(null, null) == null);
        System.assert(Skew_Helper.getTopRelationshipsForRelatedSObject(null, '') == null);
        System.assert(Skew_Helper.getTopRelationshipsForRelatedSObject('', null) == null);
        System.assert(Skew_Helper.getTopRelationshipsForRelatedSObject('', '') == null);

        List<AggregateResult> res = Skew_Helper.getTopRelationshipsForRelatedSObject('Contact', 'Account.Id');

        List<Account> accs = [SELECT Id, Name FROM Account ORDER BY CreatedDate ASC];

        System.assert(res[0].Id == accs[0].Id);
        System.assert((Integer) res[0].get('Total') == 3);

        System.assert(res[1].Id == accs[1].Id);
        System.assert((Integer) res[1].get('Total') == 2);

    }

    @TestSetup
    private static void setup() {

        List<User> users = new List<User>();

        User user1 = createUser('John', 'Smith');
        User user2 = createUser('Daniel', 'James');
        User user3 = createUser('Mary', 'Adams');

        users.add(user1);
        users.add(user2);
        users.add(user3);

        insert users;

        List<Account> accs = new List<Account>();

        Account acc1 = new Account();
        acc1.Name = 'ACC_1';
        acc1.OwnerId = user1.Id;
        accs.add(acc1);

        Account acc2 = new Account();
        acc2.Name = 'ACC_2';
        acc2.OwnerId = user1.Id;
        accs.add(acc2);

        Account acc3 = new Account();
        acc3.Name = 'ACC_3';
        acc3.OwnerId = user1.Id;
        accs.add(acc3);

        insert accs;

        List<Contact> cons = new List<Contact>();

        Contact con1 = new Contact();
        con1.LastName = 'CON_1';
        con1.AccountId = acc1.Id;
        con1.OwnerId = user2.Id;
        cons.add(con1);

        Contact con2 = new Contact();
        con2.LastName = 'CON_2';
        con2.AccountId = acc1.Id;
        con2.OwnerId = user2.Id;
        cons.add(con2);

        Contact con3 = new Contact();
        con3.LastName = 'CON_3';
        con3.AccountId = acc1.Id;
        con3.OwnerId = user2.Id;
        cons.add(con3);

        Contact con4 = new Contact();
        con4.LastName = 'CON_4';
        con4.AccountId = acc2.Id;
        con4.OwnerId = user3.Id;
        cons.add(con4);

        Contact con5 = new Contact();
        con5.LastName = 'CON_5';
        con5.AccountId = acc2.Id;
        con5.OwnerId = user3.Id;
        cons.add(con5);

        insert cons;

        List<Opportunity> opts = new List<Opportunity>();

        Opportunity opt1 = new Opportunity();
        opt1.Name = 'OPP_1';
        opt1.AccountId = acc1.Id;
        opt1.StageName = 'Prospecting';
        opt1.CloseDate = Date.today();
        opt1.OwnerId = user1.Id;
        opts.add(opt1);

        Opportunity opt2 = new Opportunity();
        opt2.Name = 'OPP_2';
        opt2.AccountId = acc1.Id;
        opt2.StageName = 'Prospecting';
        opt2.CloseDate = Date.today();
        opt2.OwnerId = user1.Id;
        opts.add(opt2);

        Opportunity opt3 = new Opportunity();
        opt3.Name = 'OPP_3';
        opt3.AccountId = acc1.Id;
        opt3.StageName = 'Prospecting';
        opt3.CloseDate = Date.today();
        opt3.OwnerId = user1.Id;
        opts.add(opt3);

        Opportunity opt4 = new Opportunity();
        opt4.Name = 'OPP_4';
        opt4.AccountId = acc2.Id;
        opt4.StageName = 'Prospecting';
        opt4.CloseDate = Date.today();
        opt4.OwnerId = user1.Id;
        opts.add(opt4);

        Opportunity opt5 = new Opportunity();
        opt5.Name = 'OPP_5';
        opt5.AccountId = acc2.Id;
        opt5.StageName = 'Prospecting';
        opt5.CloseDate = Date.today();
        opt5.OwnerId = user3.Id;
        opts.add(opt5);

        insert opts;

        List<Case> cass = new List<Case>();

        Case cas1 = new Case();
        cas1.AccountId = acc1.Id;
        cas1.OwnerId = user2.Id;
        cass.add(cas1);

        Case cas2 = new Case();
        cas2.AccountId = acc1.Id;
        cas2.OwnerId = user2.Id;
        cass.add(cas2);

        Case cas3 = new Case();
        cas3.AccountId = acc1.Id;
        cas3.OwnerId = user2.Id;
        cass.add(cas3);

        Case cas4 = new Case();
        cas4.AccountId = acc1.Id;
        cas4.OwnerId = user2.Id;
        cass.add(cas4);

        Case cas5 = new Case();
        cas5.AccountId = acc2.Id;
        cas5.OwnerId = user3.Id;
        cass.add(cas5);

        Case cas6 = new Case();
        cas6.AccountId = acc2.Id;
        cas6.OwnerId = user3.Id;
        cass.add(cas6);

        Case cas7 = new Case();
        cas7.AccountId = acc3.Id;
        cas7.OwnerId = user3.Id;
        cass.add(cas7);

        insert cass;

    }

    private static User createUser(String first, String last) {

        String rand = EncodingUtil.base64Encode(Crypto.generateAesKey(192)).substring(0, 12);

        Profile prof = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

        User create = new User();

        create.FirstName = first;
        create.LastName = last;
        create.Username = first + last + rand + '@test.com';
        create.Email = first + last + '@test.com';
        create.Alias = first.left(1) + last.left(7);
        create.EmailEncodingKey = 'UTF-8';
        create.LanguageLocaleKey = 'en_US';
        create.LocaleSidKey = 'en_US';
        create.ProfileId = prof.Id;
        create.TimeZoneSidKey = 'America/Los_Angeles';

        return create;

    }

}