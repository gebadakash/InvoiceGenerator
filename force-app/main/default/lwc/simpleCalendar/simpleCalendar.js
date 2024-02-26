import { LightningElement } from 'lwc';

export default class SimpleCalendar extends LightningElement {
    weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    currentMonth = '';
    calendarDays = [];

    connectedCallback() {
        const today = new Date();
        const year = today.getFullYear();
        const month = today.getMonth();

        this.currentMonth = new Date(year, month).toLocaleString('default', { month: 'long', year: 'numeric' });
        this.generateCalendarDays(year, month);
    }

    generateCalendarDays(year, month) {
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const firstDayIndex = firstDay.getDay();
        const lastDayIndex = lastDay.getDay();
        const prevMonthLastDay = new Date(year, month, 0).getDate();

        const days = [];

        // Add previous month's days
        for (let i = firstDayIndex; i > 0; i--) {
            days.push({
                date: prevMonthLastDay - i + 1,
                class: 'prev-month'
            });
        }

        // Add current month's days
        for (let i = 1; i <= lastDay.getDate(); i++) {
            days.push({
                date: i,
                class: 'current-month'
            });
        }

        // Add next month's days
        for (let i = 1; i < 7 - lastDayIndex; i++) {
            days.push({
                date: i,
                class: 'next-month'
            });
        }

        this.calendarDays = days;
    }
}