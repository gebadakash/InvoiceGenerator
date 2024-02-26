import { LightningElement, wire, api, track } from 'lwc';
import getInvoiceData from '@salesforce/apex/InvoiceController.getInvoiceData';
import saveAsAttachment from '@salesforce/apex/PdfController.saveAsAttachment';
import getAndIncrementInvoiceNumber from '@salesforce/apex/InvoiceNumberController.getAndIncrementInvoiceNumber';
import sendEmailWithAttachment from '@salesforce/apex/PdfController.sendEmailWithAttachment';
import getCompanyInfo from '@salesforce/apex/CompanyInfoController.getCompanyInfo';
// import Company_Logo from '@salesforce/resourceUrl/companyLogo';
import INV from '@salesforce/resourceUrl/invTemplate';
import { loadScript } from "lightning/platformResourceLoader";
import PDFLib from "@salesforce/resourceUrl/pdflib";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';



export default class InvoiceTemplate extends LightningElement {
    @api pdfURL;
    base64String = '';
    isExecuting = false;
    @track isLoading = false;
    @track showPDF = false;
    invoiceNumber;
    address;
    employee;
    admin;
    manager;
    isPDFLoaded = false;
    //    companyLogoUrl = Company_Logo;
    @api recordId; // Customer Id
    invoiceData = {};
    companyInfo;
    companyName;

    async renderedCallback() {
        const thisLwc = this;
        var xhr = new XMLHttpRequest();

        if (this.isExecuting || this.isPDFLoaded) {
            return;
        }
        this.isExecuting = true;
        await loadScript(this, PDFLib)
            .then(() => {
                console.log('PDFLib loaded successfully');
            })
            .catch((error) => {
                console.error('Failed to load PDFLib', error);
            });

        xhr.responseType = "blob";
        xhr.onreadystatechange = function () {
            if (this.response !== null)
                thisLwc.processPdf(thisLwc, this.response);
        };
        xhr.open("GET", INV);
        xhr.send();

        this.isExecuting = false;
        console.log('this.isExecuting' + this.isExecuting);
    }

    async processPdf(thisLwc, res) {
        this.isLoading = true;

        try {

            const arrayBuf = await res.arrayBuffer();
            // console.log('arrayBuf'+arrayBuf);
            const pdfDoc = await window.PDFLib.PDFDocument.load(arrayBuf);
            // console.log('pdfDoc'+pdfDoc);
            const form = pdfDoc.getForm();
            // console.log('form'+form);

            // Edit the fillable PDF form here
            form.getTextField('inv_no').setText('INV-' + this.invoiceNumber.toString());
            console.log('form' + form);
            form.getTextField('inv_balance').setText('Rs.' + this.invoiceData.total.toString());
            form.getTextField('inv_duedate').setText(this.invoiceData.dueDate.toString());
            form.getTextField('inv_date').setText(this.invoiceData.invoiceDate.toString());
            form.getTextField('inv_cgst').setText(this.invoiceData.cgst.toString());
            form.getTextField('inv_sgst').setText(this.invoiceData.sgst.toString());
            form.getTextField('inv_discount').setText(this.invoiceData.discount.toString());
            form.getTextField('inv_total').setText('Rs.'+ this.invoiceData.total.toString());
            form.getTextField('inv_adminqty').setText(this.admin.qty.toString());
            form.getTextField('inv_managerqty').setText(this.manager.qty.toString());
            form.getTextField('inv_employeeqty').setText(this.employee.qty.toString());
            form.getTextField('cust_name').setText(this.invoiceData.customerName.toString());
            form.getTextField('inv_address').setText(this.address.toString());
            form.getTextField('inv_admintotal').setText(this.admin.amount.toString());
            form.getTextField('inv_managertotal').setText(this.manager.amount.toString());
            form.getTextField('inv_employeetotal').setText(this.employee.amount.toString());
            form.getTextField('inv_adminprice').setText(this.invoiceData.adminLicensePrice.toString());
            form.getTextField('inv_managerprice').setText(this.invoiceData.managerLicensePrice.toString());
            form.getTextField('inv_employeeprice').setText(this.invoiceData.employeeLicensePrice.toString());
            form.getTextField('inv_subtotal').setText(this.invoiceData.subtotal.toString());
            form.getTextField('inv_terms').setText(this.invoiceData.terms.toString());
            form.getTextField('inv_companyaddress').setText(this.companyInfo.toString());
            form.getTextField('inv_companyname').setText(this.companyName.toString());
            


            //get rid of form and make it just a filled-out pdf
            form.flatten();

            const modifiedPDFBytes = await pdfDoc.save();

            const blob = new Blob([modifiedPDFBytes], { type: 'application/pdf' });
            const reader = new FileReader();
            reader.onloadend = () => {
                const base64String = reader.result.split(',')[1];
                this.base64String = base64String;
                // console.log(this.base64String); // Base64 string representation of the PDF
            };
            reader.readAsDataURL(blob);


            this.pdfURL = URL.createObjectURL(blob);
            this.showPDF = true;
            this.isPDFLoaded = true;
        } catch (error) {
            console.error('Error occurred while fetching or editing the PDF:', error);
        }

        this.isLoading = false;
    }
    handleDownload() {
        const link = document.createElement('a');
        link.href = this.pdfURL;
        link.target = '_blank';
        link.download = 'invoice.pdf';
        link.click();
    }

    sendMail() {
        // Call the Apex controller method to send the email with the invoice attachment
        sendEmailWithAttachment({
            recId: this.recordId,
            attachmentName: 'invoice' + this.invoiceNumber + '.pdf',
            attachmentBody: this.base64String
        })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Invoice sent successfully',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.error('Error occurred while sending the email:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Failed to send the invoice',
                        variant: 'error'
                    })
                );
            });
    }


    handleSave() {
        const file_name = 'invoice' + this.invoiceNumber+ '.pdf';
        const attachment = {
            recId: this.recordId,
            fileName: file_name,
            attachmentBody: this.base64String
        };
        // Call the Apex controller method to save the file as an attachment
        saveAsAttachment({ attachments: [attachment] })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Invoice PDF saved as attachment',
                        variant: 'success',
                    })
                );

            })
            .catch((error) => {
                console.error('Error occurred while saving the PDF as attachment:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Failed to save the invoice PDF as attachment',
                        variant: 'error',
                    })
                );
            });
    }



    @wire(getInvoiceData, { customerId: '$recordId' })
    wiredInvoiceData({ error, data }) {
        if (data) {
            console.log(data);
            this.invoiceData = data;

            // Set initial values for employee, manager, and admin
            this.employee = { name: 'Employee License', qty: 0, price: 0, amount: 0 };
            this.manager = { name: 'Manager License', qty: 0, price: 0, amount: 0 };
            this.admin = { name: 'Admin License', qty: 0, price: 0, amount: 0 };
            

            this.invoiceData.items.forEach(item => {
                if (item.name === 'Employee License') {
                    this.employee = item;
                } else if (item.name === 'Manager License') {
                    this.manager = item;
                } else if (item.name === 'Admin License') {
                    this.admin = item;
                }
            });
            this.address = this.invoiceData.customerStreet + '\n' + this.invoiceData.customerCity + ' ' + this.invoiceData.customerZipcode + '\n' + this.invoiceData.customerState + '\n' + this.invoiceData.customerCountry;
        } else if (error) {
            console.error(error);
        }
    }

    @wire(getAndIncrementInvoiceNumber)
    wiredIncrementedNumber({ error, data }) {
        if (data) {
            this.invoiceNumber = data;
            console.log('number'+this.invoiceNumber);
        } else if (error) {
            console.error(error);
        }
    }

    @wire(getCompanyInfo)
    wiredCompanyInfo({ error, data }) {
        if (data) {
            this.companyInfo = data.street + '\n' + data.city + ' ' + data.state + ' ' + data.postalCode +'\n' + data.country ;
            this.companyName = data.name;
        } else if (error) {
            console.error('Error occurred while fetching company info:', error);
        }
    }
}