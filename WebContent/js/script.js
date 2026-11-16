// Student Attendance System Client Script

document.addEventListener("DOMContentLoaded", () => {
    // Set default date to today for date pickers
    const datePickers = document.querySelectorAll('input[type="date"]');
    const today = new Date().toISOString().split('T')[0];
    
    datePickers.forEach(picker => {
        if (!picker.value) {
            picker.value = today;
        }
    });
});

// Mark all present / absent quick action
function markAll(status) {
    const radios = document.querySelectorAll(`input[type="radio"][value="${status}"]`);
    radios.forEach(radio => {
        radio.checked = true;
    });
}
