import { LightningElement, wire } from 'lwc';
import getTotals from '@salesforce/apex/MyController.getTotals';
import fetchCustomers from '@salesforce/apex/MyController.fetchCustomers';
import {loadStyle} from 'lightning/platformResourceLoader'
import COLORS from '@salesforce/resourceUrl/lwcDatatableStyle'
// import getCustomers from '@salesforce/apex/MyController.getCustomers';
import { NavigationMixin } from 'lightning/navigation';

const actions = [
    { label: 'View', name: 'view' },
    { label: 'Edit', name: 'edit' },
];

const columns = [
    {
        label: 'Name', fieldName: 'Name', cellAttributes: {
            class: { fieldName: 'textColor' }
        }
    },
    {
        label: 'Contract Start Date', fieldName: 'Contract_Start_Date__c', type: 'date', cellAttributes: {
            class: { fieldName: 'textColor' }
        }
    },
    { label: 'Email', fieldName: 'Email_id__c', type: 'email', cellAttributes: {
        class: { fieldName: 'emailColor' }
        } 
    },
    {
        label: 'Total Admin License', fieldName: 'Total_Admin_License__c', type: 'number', cellAttributes: {
            class: { fieldName: 'amountColor' }
        }
    },
    {
        label: 'Total Employee License', fieldName: 'Total_Employee_License__c', type: 'number', cellAttributes: {
            class: { fieldName: 'amountColor' }
        }
    },
    {
        label: 'Total Manager License', fieldName: 'Total_Manager_License__c', type: 'number', cellAttributes: {
            class: { fieldName: 'amountColor' }
        }
    },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];


export default class Dashboard extends NavigationMixin(LightningElement) {

    isCssLoaded = false;
    availableCustomers;
    error;
    columns = columns;
    searchString;
    initialRecords;

    totalCustomers;
    totalProducts;
    totalServiceOrders;
    totalServiceOrderDetails;



    @wire(getTotals)
    wiredTotals({ error, data }) {
        if (data) {
            this.totalCustomers = data.totalCustomers;
            this.totalProducts = data.totalProducts;
            this.totalServiceOrders = data.totalServiceOrders;
            this.totalServiceOrderDetails = data.totalServiceOrderDetails;
        } else if (error) {
            console.error(error);
        }

    }

    @wire(fetchCustomers)
    wiredAccount({ error, data }) {

        if (data) {

            this.availableCustomers = data.map(item => {
                let amountColor = item.Total_Admin_License__c > 0 ? "slds-text-color_success" : "slds-text-color_error"
                return {
                    ...item,
                    "amountColor": amountColor,
                    "textColor": "slds-text-color_default slds-text-align_center",
                    "emailColor": "datatable-white"
                }
            })
            this.initialRecords = data.map(item => {
                let amountColor = item.Total_Admin_License__c > 0 ? "slds-text-color_success" : "slds-text-color_error"
                return {
                    ...item,
                    "amountColor": amountColor,
                    "textColor": "slds-text-color_default slds-text-align_center",
                    "emailColor": "datatable-white"
                }
            })
            this.error = undefined;

        } else if (error) {

            this.error = error;
            this.availableCustomers = undefined;

        }

    }

    handleRowAction(event) {

        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'view':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
                        objectApiName: 'Customer__c',
                        actionName: 'view'
                    }
                });
                break;
            case 'edit':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
                        objectApiName: 'Customer__c',
                        actionName: 'edit'
                    }
                });
                break;
            default:
        }

    }

    handleSearchChange(event) {

        this.searchString = event.detail.value;
        console.log('Updated Search String is ' + this.searchString);

    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
        if (searchKey) {
            this.filteredCustomers = this.customers.filter(customer =>
                customer.Name.toLowerCase().includes(searchKey)
            );
        } else {
            this.filteredCustomers = this.customers;
        }
    }

    // eslint-disable-next-line no-dupe-class-members
    handleSearchChange(event) {

        this.searchString = event.detail.value;
        console.log('Updated Search String is ' + this.searchString);

    }

    // eslint-disable-next-line no-dupe-class-members
    handleSearch(event) {

        const searchKey = event.target.value.toLowerCase();
        console.log('Search String is ' + searchKey);

        if (searchKey) {

            this.availableCustomers = this.initialRecords;
            console.log('Account Records are ' + JSON.stringify(this.availableCustomers));

            if (this.availableCustomers) {

                let recs = [];

                for (let rec of this.availableCustomers) {

                    console.log('Rec is ' + JSON.stringify(rec));
                    let valuesArray = Object.values(rec);
                    console.log('valuesArray is ' + JSON.stringify(valuesArray));

                    for (let val of valuesArray) {

                        console.log('val is ' + val);
                        let strVal = String(val);

                        if (strVal) {

                            if (strVal.toLowerCase().includes(searchKey)) {

                                recs.push(rec);
                                break;

                            }

                        }

                    }

                }

                console.log('Matched Accounts are ' + JSON.stringify(recs));
                this.availableCustomers = recs;

            }

        } else {

            this.availableCustomers = this.initialRecords;

        }

    }

    renderedCallback(){ 
        if(this.isCssLoaded) return
        this.isCssLoaded = true
        loadStyle(this, COLORS).then(()=>{
            console.log("Loaded Successfully")
        }).catch(error=>{ 
            console.error("Error in loading the colors")
        })
    }

}