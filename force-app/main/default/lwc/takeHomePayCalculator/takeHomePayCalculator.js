import { LightningElement, api, wire, track } from "lwc";
import { getRecord } from 'lightning/uiRecordApi'



const SOCIAL = 0.062;
const MEDICARE = 0.0145;
const FEDERALSINGLE = 0.20;
const FIELDS = ['Job_Applications__c.Salary__c'];

export default class TakeHomePayCalculator extends LightningElement {
   
  
    @track salary = 0;
    @track yearlyPay = 0;
    @track sixMonthsPay = 0;
    @track  monthlyPay = 0;
    @track  biWeeklyPay = 0;
    @track yearlyFederalIncomeTax = 0;
    @track yearlySocialSecurityTax =0;
    @track yearlyMedicareWithholding =0;


    @api recordId;
    @wire(getRecord,{ recordId: '$recordId', fields: FIELDS })
    wiredSalary({ data , error }) {
        if (data) {
            // Access the Salary__c field
              this.salary = data.fields.Salary__c.value;
              this.detailedCalculation(this.salary);
        } else if (error) {
            // Handle error here
        }
    }
   
    detailedCalculation(pay)
    {
        
        this.yearlyFederalIncomeTax = (pay * FEDERALSINGLE).toFixed(2);
        this.yearlySocialSecurityTax = (pay * SOCIAL).toFixed(2);
        this.yearlyMedicareWithholding = (pay * MEDICARE).toFixed(2);

        this.yearlyPay =  (isNaN(parseFloat(pay).toFixed(2) - (this.yearlyFederalIncomeTax - this.yearlySocialSecurityTax - this.yearlyMedicareWithholding)))? 0.00 :(parseFloat(pay).toFixed(2) - (this.yearlyFederalIncomeTax - this.yearlySocialSecurityTax - this.yearlyMedicareWithholding));
        this.sixMonthsPay = (this.yearlyPay / 2).toFixed(2);
        this.monthlyPay = (this.yearlyPay / 12).toFixed(2);
        this.biWeeklyPay = (this.yearlyPay / 26).toFixed(2);
    }

    resetValues()
    {
        this.salary = 0.0;
        this.yearlyPay = 0.0;
        this.sixMonthsPay = 0.0;
        this.monthlyPay = 0.0;
        this.biWeeklyPay = 0.0;
        this.yearlyFederalIncomeTax = 0.0;
        this.yearlySocialSecurityTax =0.0;
        this.yearlyMedicareWithholding =0.0;
    }


    showSalary(event)
    {
        if(event.target.value.trim() ==='')
        {
            event.target.value = this.salary;
            this.detailedCalculation(this.salary);
        }
       
    }

    calculatePay(event) {
         const inputValue = event.target.value.trim();

        if(inputValue ==='' && this.salary === null)
        {
            resetValues();
        }
        else
        {
            this.detailedCalculation(inputValue);
        }
    }
}