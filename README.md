# Salesforce Utilities

## Skew Helper
A simple helper class that can be used to identify the three different types of skew.

* Account Data Skew
* Ownership Skew
* Lookup Skew

### Account Data Skew
Find accounts that have the most contacts, opportunities and cases.
```java
List<AggregateResult> accs1 = Skew_Helper.getAccountsWithTheMostContacts();
List<AggregateResult> accs2 = Skew_Helper.getAccountsWithTheMostOpportunities();
List<AggregateResult> accs3 = Skew_Helper.getAccountsWithTheMostCases();
```

### Ownership Skew
Find users that own the most records of a particular object (either standard or custom).
```java
List<AggregateResult> users = Skew_Helper.getTopOwnersForSObject('Account');
```

### Lookup Skew
Find records that have the most lookup relationships to another object.
```java
List<AggregateResult> cons = Skew_Helper.getTopRelationshipsForRelatedSObject('Contact', 'Account.Id');
```

### Useful Links
* [Avoid Account Data Skew](https://developer.salesforce.com/blogs/engineering/2012/04/avoid-account-data-skew-for-peak-performance.html)
* [Managing Lookup Skew in Salesforce](https://developer.salesforce.com/blogs/engineering/2013/04/managing-lookup-skew-to-avoid-record-lock-exceptions.html)
* [Reducing Lock Contention](https://developer.salesforce.com/blogs/engineering/2013/01/reducing-lock-contention-by-avoiding-account-data-skews.html)