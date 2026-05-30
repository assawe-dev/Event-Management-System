(function () {
    const theme = localStorage.getItem('theme') || 'light';
    if (theme === 'dark') {
        document.body.classList.add('dark-theme');
    }
})();

document.addEventListener('DOMContentLoaded', () => {
    const themeToggle = document.getElementById('themeToggle');
    if (!themeToggle) return;

    const body = document.body;
    const icon = themeToggle.querySelector('i');

    function updateIcon() {
        if (body.classList.contains('dark-theme')) {
            if (icon.classList.contains('fa-moon')) icon.classList.replace('fa-moon', 'fa-sun');
        } else {
            if (icon.classList.contains('fa-sun')) icon.classList.replace('fa-sun', 'fa-moon');
        }
    }

    updateIcon();

    themeToggle.addEventListener('click', () => {
        body.classList.toggle('dark-theme');
        const theme = body.classList.contains('dark-theme') ? 'dark' : 'light';
        localStorage.setItem('theme', theme);
        updateIcon();
    });
});
