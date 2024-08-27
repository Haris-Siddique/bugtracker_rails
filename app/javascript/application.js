// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"



  document.addEventListener("DOMContentLoaded", function() {
    const typeSelect = document.getElementById('bug_type_select');
    const statusSelect = document.getElementById('status_select');

    function updateStatusOptions() {
      const selectedType = typeSelect.value;
      statusSelect.innerHTML = '';

      if (selectedType === 'Bug') {
        ['New', 'Started', 'Resolved'].forEach(function(status) {
          const option = document.createElement('option');
          option.value = status;
          option.textContent = status;
          statusSelect.appendChild(option);
        });
      } else if (selectedType === 'Feature') {
        ['New', 'Started', 'Complete'].forEach(function(status) {
          const option = document.createElement('option');
          option.value = status;
          option.textContent = status;
          statusSelect.appendChild(option);
        });
      }
    }

  
    updateStatusOptions();

   
    typeSelect.addEventListener('change', updateStatusOptions);
  });