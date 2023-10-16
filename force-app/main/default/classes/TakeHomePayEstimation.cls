public class TakeHomePayEstimation {

    // Constants for tax rates
    public static final Decimal FederalIncomeTax = 0.20;
    public static final Decimal SocialSecurity = 0.062;
    public static final Decimal MedicareWitholding = 0.0145;

    public class TakeHomePayResult {
        public Decimal yearlySalary;
        public Decimal monthlySalary;
        
        // Constructor for the TakeHomePayResult class
        public TakeHomePayResult(Decimal yearlySalary, Decimal monthlySalary) {
            
            // Initialize the yearly and monthly salary properties with the provided values
            this.yearlySalary = yearlySalary;
            this.monthlySalary = monthlySalary;
        }
    }

    public static TakeHomePayResult calculateTakeHomePay(Decimal offeredSalary) {
        // Calculate yearly and monthly taxes
        Decimal yearlyFederalIncomeTax = offeredSalary * FederalIncomeTax;
        Decimal yearlySocialSecurityTax = offeredSalary * SocialSecurity;
        Decimal yearlyMedicareWithholding = offeredSalary * MedicareWitholding;

        // Calculate yearly and monthly take-home pay
        Decimal yearlyTakeHomePay = offeredSalary - yearlyFederalIncomeTax - yearlySocialSecurityTax - yearlyMedicareWithholding;
        Decimal monthlyTakeHomePay = yearlyTakeHomePay / 12;

        // Return the result
        return new TakeHomePayResult(yearlyTakeHomePay, monthlyTakeHomePay);
    }
}