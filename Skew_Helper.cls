/**
 * Helper class for determining possible skew.
 */
public class Skew_Helper {

    /**
     * Account Data Skew
     *
     * Get the top 10 accounts that have the most contacts.
     *
     * @return List<AggregateResult>
     */
    public static List<AggregateResult> getAccountsWithTheMostContacts() {
        return accountHelper('Contact');
    }

    /**
     * Account Data Skew
     *
     * Get the top 10 accounts that have the most opportunities.
     *
     * @return List<AggregateResult>
     */
    public static List<AggregateResult> getAccountsWithTheMostOpportunities() {
        return accountHelper('Opportunity');
    }

    /**
     * Account Data Skew
     *
     * Get the top 10 accounts that have the most cases.
     *
     * @return List<AggregateResult>
     */
    public static List<AggregateResult> getAccountsWithTheMostCases() {
        return accountHelper('Case');
    }

    /**
     * Account Data Skew
     *
     * Helper method to perform the query. This will omit records that are not associated with an account.
     *
     * @param objName
     *
     * @return List<AggregateResult>
     */
    private static List<AggregateResult> accountHelper(String objName) {
        return (List<AggregateResult>) Database.query(
                'SELECT Account.Id, Account.Name AccName, COUNT(Id) Total ' +
                'FROM ' + objName + ' ' +
                'WHERE Account.Name != null ' +
                'GROUP BY Account.Id, Account.Name ' +
                'ORDER BY COUNT(Id) DESC ' +
                'LIMIT 10'
        );
    }

    /**
     * Ownership Skew
     *
     * Get the top 10 users that own the most objects of the type specified.
     *
     * @param objName
     *
     * @return List<AggregateResult>
     */
    public static List<AggregateResult> getTopOwnersForSObject(String objName) {
        if (objName == null || objName == '') return null;
        return (List<AggregateResult>) Database.query(
                'SELECT Owner.Id, Owner.Name OwnerName, COUNT(Id) Total ' +
                'FROM ' + objName + ' ' +
                'GROUP BY Owner.Id, Owner.Name ' +
                'ORDER BY COUNT(Owner.Id) DESC ' +
                'LIMIT 10'
        );
    }

    /**
     * Lookup Skew
     *
     * Get the top 10 records of the specified object type which have the most foreign key references.
     *
     * @param objName
     * @param lookupField
     *
     * @return List<AggregateResult>
     */
    public static List<AggregateResult> getTopRelationshipsForRelatedSObject(String objName, String lookupField) {
        if (objName == null || objName == '' || lookupField == null || lookupField == '') return null;
        return (List<AggregateResult>) Database.query(
                'SELECT ' + lookupField + ', COUNT(Id) Total ' +
                'FROM ' + objName + ' ' +
                'WHERE ' + lookupField + ' != null ' +
                'GROUP BY ' + lookupField + ' ' +
                'ORDER BY COUNT(Id) DESC ' +
                'LIMIT 10'
        );
    }

}