import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import { getService } from 'lightning/uiRecordApi';

const COLUMNS = [
    { label: 'Service Order ID', fieldName: 'Name', type: 'Auto Number' },
    { label: 'Customer Name', fieldName: 'Customer__c', type: '	Lookup' },
    { label: 'Order Status', fieldName: 'Order_Status__c', type: 'Picklist' },
    { label: 'Order Type', fieldName: 'Order_Type__c', type: 'Picklist' },
    { label: 'Service Start Date', fieldName: 'Service_Start_Date__c', type: 'date' }
];

export default class RecentServiceOrders extends LightningElement {
    columns = COLUMNS;

    @wire(getService, { recordId: '$_recordId', fields: ['Name.Customer__c'] })
    wiredRecord({ error, data }) {
        if (data) {
            this.customerId = data.fields.Customer_Name__c.value;
        } else if (error) {
            console.log(error);
        }
    }

    @wire(getListUi, {
        objectApiName: 'Service_Order__c',
        orderBy: 'CreatedDate',
        pageSize: 10,
        fields: ['Service_Order__c.Name', 'Service_Order__c.Customer__c', 'Service_Order__c.Order_Status__c', 'Service_Order__c.Order_Type__c', 'Service_Order__c.Service_Start_Date__c']
    })
    wiredServiceOrders({ error, data }) {
        if (data) {
            let serviceOrders = data.records.records;
            serviceOrders = serviceOrders.filter(serviceOrder => serviceOrder.fields.Customer__c.value === this.customerId);
            serviceOrders = serviceOrders.map(serviceOrder => ({
                id: serviceOrder.id,
                Name: serviceOrder.fields.Name.value,
                Customer__c: serviceOrder.fields.Customer__c.value,
                Order_Status__c: serviceOrder.fields.Order_Status__c.value,
                Order_Type__c: serviceOrder.fields.Order_Type__c.value,
                Service_Start_Date__c: serviceOrder.fields.Service_Start_Date__c.value
            }));
            this.serviceOrders = serviceOrders;
        } else if (error) {
            console.log(error);
        }
    }

    get _recordId() {
        return this.customerRecord ? this.customerRecord.id : undefined;
    }

    handleCustomerChange(event) {
        this.customerRecord = event.detail.value[0];
    }
}