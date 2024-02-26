import { LightningElement, track } from "lwc";

export default class Calendar extends LightningElement {
  @track month;
  @track year;
  @track calendarDays;
  @track selectedDate;


  connectedCallback() {
    const currentDate = new Date();
    this.month = currentDate.toLocaleString("default", { month: "long" });
    this.year = currentDate.getFullYear();
    this.selectedDate = localStorage.getItem("selectedDate");
    this.generateCalendar(currentDate.getMonth(), currentDate.getFullYear());
    this.updateSelectedDateClass();
  }

  updateSelectedDateClass() {
    const selectedDate = localStorage.getItem("selectedDate");
    this.selectedDateClass = selectedDate ? "selected" : "";
  }

  handleDateClick(event) {
    const selectedDate = event.target.dataset.date;
    this.selectedDateClass = "selected";
    localStorage.setItem("selectedDate", selectedDate);
    console.log("Selected Date:", selectedDate);
  }


  generateCalendar(month, year) {
    const currentDate = new Date(); // Get the current date
    const currentDay = currentDate.getDate(); // Get the current day
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate();
    const firstDayOfWeek = firstDay.getDay();
  
    let days = [];
    let week = { id: 0, days: [] };
    let dayCounter = 1;
  
    for (let i = 0; i < 6; i++) {
      for (let j = 0; j < 7; j++) {
        if ((i === 0 && j < firstDayOfWeek) || dayCounter > daysInMonth) {
          week.days.push({ day: "", date: "", class: "inactive" });
        } else {
          const date = new Date(year, month, dayCounter);
          const classValue = dayCounter === currentDay ? "current" : "";
          week.days.push({
            day: dayCounter,
            date: date.toDateString(),
            class: classValue
          });
          dayCounter++;
        }
  
        if (j === 6) {
          days.push(week);
          week = { id: i + 1, days: [] };
        }
      }
    }
  
    this.calendarDays = days;
  }
  

  

  handlePreviousMonth() {
    const currentMonth = this.month;
    const currentYear = this.year;

    const previousMonth = new Date(
      currentYear,
      this.getMonthIndex(currentMonth) - 1
    );
    this.month = previousMonth.toLocaleString("default", { month: "long" });
    this.year = previousMonth.getFullYear();

    this.generateCalendar(
      previousMonth.getMonth(),
      previousMonth.getFullYear()
    );
  }

  handleNextMonth() {
    const currentMonth = this.month;
    const currentYear = this.year;

    const nextMonth = new Date(
      currentYear,
      this.getMonthIndex(currentMonth) + 1
    );
    this.month = nextMonth.toLocaleString("default", { month: "long" });
    this.year = nextMonth.getFullYear();

    this.generateCalendar(nextMonth.getMonth(), nextMonth.getFullYear());
  }


  getMonthIndex(month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames.findIndex((name) => name === month);
  }
}