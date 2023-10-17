public class TakeHomePayEstimation {

    // Constants for tax rates
    public static final Decimal FederalIncomeTaxSingle = 0.20;
    public static final Decimal FederalIncomeTaxHeadOfHousehold = 0.18;
    public static final Decimal FederalIncomeTaxMarriedFilingSeparately = 0.15;
    public static final Decimal FederalIncomeTaxMarriedFilingJointly = 0.16;
    
    public static final Decimal SocialSecurity = 0.062;
    public static final Decimal MedicareWithholding = 0.0145;

    public class TakeHomePayResult {
        public Decimal yearlySalary;
        public Decimal monthlySalary;
        public Decimal biWeeklySalary;
        public Decimal weeklySalary;
        public Decimal halfYearSalary;

        public TakeHomePayResult(Decimal yearlySalary, Decimal monthlySalary, Decimal biWeeklySalary, Decimal weeklySalary, Decimal halfYearSalary) {
            this.yearlySalary = yearlySalary;
            this.monthlySalary = monthlySalary;
            this.biWeeklySalary = biWeeklySalary;
            this.weeklySalary = weeklySalary;
            this.halfYearSalary = halfYearSalary;
        }
    }

    public Decimal getFederalIncomeTaxRate(String filingStatus) {
        // Determine the federal income tax rate based on filing status
        switch on filingStatus {
            when 'single' {
                return FederalIncomeTaxSingle;
            }
            when 'head of household' {
                return FederalIncomeTaxHeadOfHousehold;
            }
            when 'married filing separately' {
                return FederalIncomeTaxMarriedFilingSeparately;
            }
            when 'married filing jointly' {
                return FederalIncomeTaxMarriedFilingJointly;
            }
            when else {
                // Default to single if an invalid filing status is provided
                return FederalIncomeTaxSingle;
            }
        }
    }

    public TakeHomePayResult calculateTakeHomePay(Decimal offeredSalary, String filingStatus) {
        // Calculate yearly and monthly taxes
        Decimal federalIncomeTaxRate = getFederalIncomeTaxRate(filingStatus);
        Decimal yearlyFederalIncomeTax = offeredSalary * federalIncomeTaxRate;
        Decimal yearlySocialSecurityTax = offeredSalary * SocialSecurity;
        Decimal yearlyMedicareWithholding = offeredSalary * MedicareWithholding;

        // Calculate yearly and monthly take-home pay
        Decimal yearlyTakeHomePay = offeredSalary - yearlyFederalIncomeTax - yearlySocialSecurityTax - yearlyMedicareWithholding;
        Decimal monthlyTakeHomePay = yearlyTakeHomePay / 12;
        Decimal biWeeklyTakeHomePay = monthlyTakeHomePay * 12 / 26;
        Decimal weeklyTakeHomePay = monthlyTakeHomePay * 12 / 52;
        Decimal halfYearTakeHomePay = monthlyTakeHomePay * 6;

        // Return the result
        return new TakeHomePayResult(yearlyTakeHomePay, monthlyTakeHomePay, biWeeklyTakeHomePay, weeklyTakeHomePay, halfYearTakeHomePay);
    }
}