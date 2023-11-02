@IsTest
private with sharing class TakeHomePayEstimationTest {
   

    @IsTest
    static void calculateTakeHomePayTest()
    {   
        TakeHomePayEstimation takeHomePay = new TakeHomePayEstimation();

        TakeHomePayEstimation.TakeHomePayResult calculateTakeHome1 = new TakeHomePayEstimation.TakeHomePayResult(43410.00,3617.50,1669.62,834.81,21705.00);
        
        TakeHomePayEstimation.TakeHomePayResult calculateTakeHome2 = takeHomePay.calculateTakeHomePay(60000,'single');

        Assert.areEqual(calculateTakeHome1.yearlySalary, calculateTakeHome2.yearlySalary,'Excepted yearly salary');
        Assert.areEqual(calculateTakeHome1.monthlySalary, calculateTakeHome2.monthlySalary,'Excepted monthly salary');
        Assert.areEqual(calculateTakeHome1.halfYearSalary, calculateTakeHome2.halfYearSalary,'Excepted halfyearly salary');
        Assert.areEqual(calculateTakeHome1.weeklySalary, calculateTakeHome2.weeklySalary,'Excepted weekly salary');
        Assert.areEqual(calculateTakeHome1.biWeeklySalary, calculateTakeHome2.biWeeklySalary,'Excepted biweekly salary');


    }


    @IsTest
    static void getFederalIncomeTaxRateTest()
    {

        TakeHomePayEstimation takeHomePay = new TakeHomePayEstimation();
        Decimal federalIncomeTaxRate1 = takeHomePay.getFederalIncomeTaxRate('single');
        Decimal federalIncomeTaxRate2 = takeHomePay.getFederalIncomeTaxRate('head of household');
        Decimal federalIncomeTaxRate3 = takeHomePay.getFederalIncomeTaxRate('married filing separately');
        Decimal federalIncomeTaxRate4 = takeHomePay.getFederalIncomeTaxRate('married filing jointly');
        Decimal federalIncomeTaxRate5 = takeHomePay.getFederalIncomeTaxRate('other');

        Assert.areEqual(0.20, federalIncomeTaxRate1, 'Wrong tax rate.');
        Assert.areEqual(0.18, federalIncomeTaxRate2, 'Wrong tax rate.');
        Assert.areEqual(0.15, federalIncomeTaxRate3, 'Wrong tax rate.');
        Assert.areEqual(0.16, federalIncomeTaxRate4, 'Wrong tax rate.');
        Assert.areEqual(0.20, federalIncomeTaxRate5, 'Wrong tax rate.');

    }

}