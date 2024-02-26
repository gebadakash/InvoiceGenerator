import { LightningElement, api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadScript } from 'lightning/platformResourceLoader';
import jsPDF from '@salesforce/resourceUrl/jsPDF';
import JSPDF_AUTO_TABLE from '@salesforce/resourceUrl/jspdfAutotable';
import fetchLogoImage from '@salesforce/apex/InvoiceDataController.getLogoImageBase64';
import fetchData from '@salesforce/apex/InvoiceDataController.fetchDataForCustomer';
import savePdfAsAttachment from '@salesforce/apex/InvoiceDataController.savePdfAsAttachment';
import sendEmailWithAttachment from '@salesforce/apex/InvoiceDataController.sendEmailWithAttachment';
import getInvoiceLineItems from '@salesforce/apex/InvoiceDataController.getInvoiceLineItems';

import GSTIN from '@salesforce/label/c.GSTIN';

import FETCHING_DATA_ERROR_MESSAGE_LABEL from '@salesforce/label/c.Fetching_data_error_message';
import iNVOICE_HEADING_LABEL from '@salesforce/label/c.Lwc_pdf_invoice_heading';
import iNVOICE_SUBHEADING_LABEL from '@salesforce/label/c.Lwc_pdf_invoice_sub_heading';
import BALANCE_DUE_LABEL from '@salesforce/label/c.Lwc_pdf_balance_due';
import GSTIN_LABEL from '@salesforce/label/c.Lwc_pdf_gstin';
import BILL_TO_LABEL from '@salesforce/label/c.Lwc_pdf_bill_to';
import INVOICE_DATE_LABEL from '@salesforce/label/c.Lwc_pdf_invoice_date';
import TERMS_LABEL from '@salesforce/label/c.Lwc_pdf_terms';
import DUE_DATE_LABEL from '@salesforce/label/c.Lwc_pdf_due_date';
import ITEM_DESC_LABEL from '@salesforce/label/c.Lwc_pdf_items_descriptions';
import RATE_LABEL from '@salesforce/label/c.Lwc_pdf_rate';
import QUANTITY_LABEL from '@salesforce/label/c.Lwc_pdf_quantity';
import DURATION_LABEL from '@salesforce/label/c.Lwc_pdf_duration';
import AMOUNT_LABEL from '@salesforce/label/c.Lwc_pdf_amount';
import SUBTOTAL_LABEL from '@salesforce/label/c.Lwc_pdf_subtotal';
import TAX_LABEL from '@salesforce/label/c.Lwc_pdf_tax';
import DISCOUNT_LABEL from '@salesforce/label/c.Lwc_pdf_discount';
import GRAND_TOTAL_LABEL from '@salesforce/label/c.Lwc_pdf_grand_total';
import TOTAL_IN_WORDS_LABEL from '@salesforce/label/c.Lwc_pdf_total_in_words';
import NOTES_LABEL from '@salesforce/label/c.Lwc_pdf_notes';
import NOTES_DESC_LABEL from '@salesforce/label/c.Lwc_pdf_notes_description';
import TERMS_CONDTION_LABEL from '@salesforce/label/c.Lwc_pdf_terms_condition';
import SAVE_AS_ATTACH_LABEL from '@salesforce/label/c.Lwc_pdf_saved_as_attachment';
import ERR_TOAST_MESSAGE_LABEL from '@salesforce/label/c.Lwc_pdf_error_toast_message';
import EMAIL_TOAST_MESSAGE_LABEL from '@salesforce/label/c.Lwc_pdf_email_toast_message';
import ERR_EMAIL_TOAST_MESSAGE_LABEL from '@salesforce/label/c.Lwc_pdf_email_error_toast_message';
import ERR_TITLE_LABEL from '@salesforce/label/c.Lwc_pdf_error_title';
import SUC_TITLE_LABEL from '@salesforce/label/c.Lwc_pdf_success_title';
import BUTTON_SAVE_AS_ATTACH_LABEL from '@salesforce/label/c.Lwc_pdf_button_save_as_attachment';
import BUTTON_SEND_EMAIL_LABEL from '@salesforce/label/c.Lwc_pdf_button_send_email';




export default class Invoice extends LightningElement {

    @api recordId;
    pdfUrl;
    pdfBlob;
    @track base64Image = '';
    @track isLoading = true;

    @track invoiceDate = '';
    @track terms = '';
    @track dueDate = '';
    currency;
    customerName = '';
    customerCompanyName = '';
    customerStreet = '';
    customerCity = '';
    customerState = '';
    customerCountry = '';
    customerZipcode = '';
    companyName= '';
    companyStreet= '';
    companyCity = '';
    companyState = '';
    companyCountry = '';
    companyZipcode = '';
    companyGSTNO= GSTIN.toString();

    discount;
    tax;
    subtotal;
    grandtotal;
    invoiceNumber;
    tableData;
    termsandCondition;

    currencySymbols = {
        'US Dollars': '$',
        'Euros': '€',
        'Yen': '¥',
        'Pounds': '£',
        'Rupees': 'Rs.',
        'Yuan': '¥',
    };

    Decimalcurrencies = {
        'US Dollars': 'cent',
        'Euros': 'cent',
        'Yen': 'sen',
        'Pounds': 'cent',
        'Rupees': 'paisa',
        'Yuan': 'fen',
    };

    buttonLabel = {
        saveLabel: BUTTON_SAVE_AS_ATTACH_LABEL,
        emailLabel: BUTTON_SEND_EMAIL_LABEL

    };

    jsPdfInitialized = false;


    renderedCallback() {

        if (this.jsPdfInitialized) {
            return;
        }
        this.jsPdfInitialized = true;

        loadScript(this, jsPDF)
        .then(() => {
            console.log("jsPDF Loaded");
            loadScript(this, JSPDF_AUTO_TABLE)
            .then(()=>{
                console.log("autotable Loaded");
                this.fetchLogoImageFromServer();

            })
            .catch(err => {
                console.log('error'+err);
            });
            
        })
        .catch(error => {
            console.log('error'+error);
        });

    }

    fetchLogoImageFromServer() {
        fetchLogoImage()
            .then(result => {
                this.base64Image = result; // Set the fetched logo image
                this.fetchData(); // Continue with fetching data and generating PDF
            })
            .catch(error => {
                console.error('Error fetching logo image:', error);
                this.isLoading = false; // Stop the spinner
                this.showToast(ERR_TITLE_LABEL, FETCHING_DATA_ERROR_MESSAGE_LABEL, 'error');
            });
    }


    fetchData() {

        Promise.all([
            getInvoiceLineItems({ invItemId: this.recordId }),
            fetchData({ invoiceItemId: this.recordId })
        ])
        .then(results => {
            this.tableData = results[0];
            const data = results[1];
            
            // Set other data properties
            this.invoiceDate = data.invoiceDate;
            this.terms = data.terms;
            this.dueDate = data.dueDate;
            this.currency = data.currency;
            this.companyName = data.companyName;
            this.companyStreet = data.companyStreet;
            this.companyCity = data.companyCity;
            this.companyZipcode = data.companyPostalCode;
            this.companyState = data.companyState;
            this.companyCountry = data.companyCountry;
            this.discount = data.discount;
            this.tax = data.tax;
            this.termsandCondition = data.termsandCondition;
            this.subtotal = data.subtotal;
            this.grandtotal = data.grandtotal;
            this.invoiceNumber = data.invnumber;
            this.customerCompanyName = data.customerCompanyName;
            this.customerStreet = data.customerStreet;
            this.customerCity = data.customerCity;
            this.customerZipcode = data.customerZip;
            this.customerState = data.customerState;
            this.customerCountry = data.customerCountry;
            console.log('data generated');
            
            // Call generatePdf function here
            this.generatePdf();
            })
            .catch(error => {
                console.error('Error fetching data: ',error);
                this.isLoading = false; // Stop the spinner
                this.showToast(ERR_TITLE_LABEL, FETCHING_DATA_ERROR_MESSAGE_LABEL, 'error');
            });
    }


    generatePdf() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        // Convert the image to base64 format
        doc.addImage(this.base64Image, 'PNG', 15, 15, 65, 10);
        doc.setFontSize(30);
        doc.setFont('helvetica')
        doc.text(iNVOICE_HEADING_LABEL, doc.internal.pageSize.getWidth() - 17, 23, { align: 'right' });
        doc.setFontSize(10);
        doc.setTextColor(128);
        doc.setFont('helvetica','bold');
        doc.text(iNVOICE_SUBHEADING_LABEL+" "+this.invoiceNumber, doc.internal.pageSize.getWidth() - 18, 28, { align: 'right' });
        doc.setTextColor(0);
        doc.setFontSize(9);
        doc.setFont('helvetica', 'bold');
        doc.text(BALANCE_DUE_LABEL, doc.internal.pageSize.getWidth() - 18, 45, { align: 'right' });
        doc.setFontSize(14);

        doc.text(this.currencySymbols[this.currency]+this.grandtotal.toString(), doc.internal.pageSize.getWidth() - 18, 50, { align: 'right' });

        doc.setFontSize(10);
        doc.setFont('helvetica', 'bold');
        doc.text(this.companyName, 16, 30);
        doc.setFontSize(10)
        doc.setFont('helvetica', 'normal');
        doc.setTextColor(128);
        doc.text(this.companyStreet, 16, 35); // Address line 1
        doc.text(this.companyCity +" "+ this.companyState+" "+this.companyZipcode, 16, 40); // Address line 2
        doc.text(this.companyCountry, 16, 45); // Address line 3
        doc.text(GSTIN_LABEL+' '+this.companyGSTNO, 16, 50); // Address line 4
        doc.setTextColor(0);
        doc.setFontSize(10);
        doc.setTextColor(128);
        doc.setFont('helvetica', 'normal');
        doc.text(BILL_TO_LABEL, 16, 67,)
        doc.text(INVOICE_DATE_LABEL, 162, 73, { align: 'right' })
        doc.text(TERMS_LABEL, 162, 80, { align: 'right' })
        doc.text(DUE_DATE_LABEL, 162, 87, { align: 'right' })
        doc.setTextColor(0);
        doc.setFont('helvetica', 'normal');
        doc.text(this.invoiceDate, 192, 73, { align: 'right' })
        doc.text(this.terms, 192, 80, { align: 'right' })
        doc.text(this.dueDate, 192, 87, { align: 'right' })
        doc.text(this.customerCompanyName, 16, 73,)
        doc.text(this.customerStreet, 16, 78,)
        doc.text(this.customerCity + " " + this.customerZipcode, 16, 83,)
        doc.text(this.customerState, 16, 88,)
        doc.text(this.customerCountry, 16, 93,)

        
        jsPDF.autoTableSetDefaults({

            headStyles: {
                fillColor: [54, 69, 79], // RGB color for header background (light brown)
                textColor: [255, 255, 255], // RGB color for header text (black)
                fontStyle: 'normal',
                fontSize: 10, 
                halign: 'center',
            },
            bodyStyles: {
                textcolor: [0, 0, 0],
                halign: 'center', // Align text in the table body to center
                cellPadding: { top: 3, bottom: 3, left: 0, right: 0 },
                border: {
                    horizontal: 'solid', // Set horizontal border style to 'solid' (or your desired style)
                    vertical: 'none',   // Remove vertical lines
                },
            },



        })

        // Create a new array to hold the modified data
        const modifiedTableData = [];

        // Iterate through tableData to modify Duration values
        this.tableData.forEach(item => {
            // Clone the item to avoid modifying the original array
            const newItem = [...item];

            // Check if the Duration value is an integer
            const durationValue = parseFloat(item[4]);
            if (!isNaN(durationValue) && durationValue === parseInt(durationValue)) {
                // If it's an integer, convert it to a string with one decimal place
                newItem[4] = durationValue.toFixed(1);
            }

            // Push the modified item to the new array
            modifiedTableData.push(newItem);
        });

        // Create a table using autoTable
        doc.autoTable({
            startY: 100, // Adjust the starting Y position as needed
            head: [["#", ITEM_DESC_LABEL, RATE_LABEL, QUANTITY_LABEL, DURATION_LABEL, AMOUNT_LABEL]],
            body: modifiedTableData,
            theme: 'grid',
            columnStyles: {
                0: {cellWidth: 10},
                1: {cellWidth: 'auto', halign: 'left', cellPadding: { top: 3, bottom: 3, left: 3, right: 3} },
                2: {cellWidth: 15},
                3: {cellWidth: 20},
                4: {cellWidth: 20},
                5: {cellWidth: 20},
                
            },
            
        });  

        let PageNo = 1;
        // Define maximum Y position for each page
        const maxPageY = 280; // Adjust this value based on your layout

        let currentY = doc.autoTable.previous.finalY; // Initial Y position

        // Helper function to check if content fits on the current page
        function contentFitsOnPage(height) {
            return currentY + height <= maxPageY;
        }

        // Function to create a new page and reset Y position
        function createNewPage() {
            doc.addPage();
            currentY = 15; // Reset Y position to the top of the new page
        }

        const tax = (this.subtotal * (this.tax / 100)).toFixed(2);
        const discount = (this.subtotal * (this.discount / 100)).toFixed(2);

        // Render SUBTOTAL, TAX, and GRAND TOTAL
        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal')
        if (!contentFitsOnPage(50)) {
            createNewPage();
            PageNo++;
        }
        currentY += 10;
        doc.text(SUBTOTAL_LABEL, 141, currentY);
        doc.text(this.subtotal.toString(), 187, currentY, { align: 'right' });

        
        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal')
        if (!contentFitsOnPage(10)) {
            createNewPage();
        }
        currentY += 10;
        doc.text(TAX_LABEL+" ("+this.tax+"%):", 141, currentY);
        doc.text(tax.toString(), 187, currentY, { align: 'right' });

        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal')
        if (!contentFitsOnPage(10)) {
            createNewPage();
        }
        currentY += 10;
        doc.text(DISCOUNT_LABEL+" ("+this.discount+"%):", 141, currentY);
        doc.setTextColor(255, 0, 0);
        doc.text("(-)" + discount, 187, currentY, { align: 'right' });
        doc.setTextColor(0);

        
        doc.setFontSize(10);
        doc.setFont('helvetica', 'bold')
        if (!contentFitsOnPage(10)) {
            createNewPage();
            PageNo++;
        }
        currentY += 10;
        
        if(PageNo != 1) {
            const grandTotalX = 90;
            const grandTotalY = currentY -5;
            doc.setFillColor(240, 240, 240); // Light gray color
            doc.rect(grandTotalX + 10, grandTotalY - 2, 96,12, 'F');
        }else{
            // // Highlight GRAND TOTAL row with a light background color
            const grandTotalX = 90;
            const grandTotalY = doc.autoTable.previous.finalY + 35;
            doc.setFillColor(240, 240, 240); // Light gray color
            doc.rect(grandTotalX + 10, grandTotalY - 2, 96,12, 'F');
        }
        
        doc.text(GRAND_TOTAL_LABEL, 141, currentY);
        doc.text(this.currencySymbols[this.currency]+this.grandtotal.toString(), 187, currentY, { align: 'right' });
        
        console.log(doc.getFontList());

        const grandTotalWords = this.withDecimal(this.grandtotal);
        const newgrandTotalWords = grandTotalWords.replace(/\s+/g,' ').trim();
        
        doc.setFontSize(10);
        doc.setFont('helvetica', 'normal')
        if (!contentFitsOnPage(10)) {
            createNewPage();
        }
        currentY += 10;
        doc.text(TOTAL_IN_WORDS_LABEL+" ", 105, currentY);
        doc.setFont('helvetica', 'italic');
        doc.text(newgrandTotalWords, 132, currentY,{ maxWidth: 60, align:'justify'});
        doc.setFont('helvetica', 'normal');
          
        doc.setTextColor(128);
        doc.setFontSize(12);
        doc.setFont('helvetica', 'normal')
        if (!contentFitsOnPage(30)) {
            createNewPage();
        }
        currentY += 20;
        doc.text(NOTES_LABEL, 20, currentY); //50
        doc.setFontSize(10);
        doc.setTextColor(0);
        doc.setFont('helvetica', 'normal')

            currentY += 7;
        doc.text(NOTES_DESC_LABEL, 20, currentY); //57
        
        
        if (this.termsandCondition) {
            
            // Render the terms and conditions section
            doc.setFontSize(12);
            doc.setTextColor(128);
            doc.setFont('helvetica', 'normal');
            if (!contentFitsOnPage(20)) {
                createNewPage();
            }
            currentY += 10;
            doc.text(TERMS_CONDTION_LABEL, 20, currentY); // Adjust the Y position as needed
            doc.setTextColor(0);
            doc.setFontSize(10);
            if (!contentFitsOnPage(7)) {
                createNewPage();
            }
            currentY += 7;
            doc.text(this.termsandCondition, 20, currentY, { maxWidth: 175, align: 'justify'}); // Adjust the Y position as needed
        }

        // Save the generated PDF to a Blob
        this.pdfBlob = doc.output('blob');

        // Convert the Blob to a URL
        this.pdfUrl = URL.createObjectURL(this.pdfBlob);

        console.log("pdf created");
        this.isLoading =false;

    }


    numberToWords(numValue) {
    const ones = [
        'Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten',
        'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
    ];

    const tens = [
        '', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'
    ];

    const scales = ['', 'Thousand', 'Million', 'Billion'];

    function toWords(num) {
        if (num === 0) return 'Zero';
    
        let words = '';
        for (let i = 0; num > 0; i++) {
            if (num % 1000 !== 0) {
                const part = convertThreeDigits(num % 1000);
                if (words !== '') {
                    words = part + ' ' + scales[i] + ' ' + words;
                } else {
                    words = part + ' ' + scales[i] + words;
                }
            }
            num = Math.floor(num / 1000);
        }
        return words.trim();
    }

    function convertThreeDigits(num) {
        if (num === 0) return '';
        if (num < 20) return ones[num] + ' ';
        if (num < 100) return tens[Math.floor(num / 10)] + ' ' + convertThreeDigits(num % 10);
        return ones[Math.floor(num / 100)] + ' Hundred ' + convertThreeDigits(num % 100);
    }

    return toWords(numValue);
}

withDecimal(n) {
    var nums = n.toString().split('.');
    var whole = this.numberToWords(nums[0]);

    if (nums.length == 2 && parseInt(nums[1]) !== 0) {
        var fraction = this.numberToWords(nums[1]);
        return whole + " " + this.currency + ' and ' + fraction + ' ' + this.Decimalcurrencies[this.currency] + ' Only';
    } else {
        return whole + " " + this.currency + ' Only';
    }
}



    savePdf() {
        // Check if pdfBlob is defined
        if (!this.pdfBlob) {
            console.error('PDF Blob is not defined');
            return;
        }

        // Convert the Blob to a base64-encoded string
        const reader = new FileReader();
        reader.onloadend = () => {
            const pdfContent = reader.result.split(',')[1]; // Extract base64 content
            const attachmentName = this.invoiceNumber+' invoice.pdf'; // Set the attachment name

            savePdfAsAttachment({ parentId: this.recordId, pdfContent, attachmentName })
                .then(() => {
                    console.log('PDF saved as attachment');
                    this.showToast(SUC_TITLE_LABEL, SAVE_AS_ATTACH_LABEL, 'success');
                })
                .catch(error => {
                    console.error('Error saving PDF as attachment:', error);
                    this.showToast(ERR_TITLE_LABEL, ERR_TOAST_MESSAGE_LABEL, 'error');
                });
        };
        reader.readAsDataURL(this.pdfBlob); // Convert Blob to base64
    }

    sendEmail() {
        // Convert the Blob to a base64-encoded string
        const reader = new FileReader();
        reader.onloadend = () => {
            const pdfContent = reader.result.split(',')[1]; // Extract base64 content

            sendEmailWithAttachment({ invoiceItemId: this.recordId, pdfContent })
                .then(() => {
                    this.showToast(SUC_TITLE_LABEL, EMAIL_TOAST_MESSAGE_LABEL, 'success');
                })
                .catch(error => {
                    console.error('Error sending email:', error);
                    this.showToast(ERR_TITLE_LABEL, ERR_EMAIL_TOAST_MESSAGE_LABEL, 'error');
                });
        };
        reader.readAsDataURL(this.pdfBlob); // Convert Blob to base64
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(toastEvent);
    }
    

}