document.addEventListener('DOMContentLoaded', initializeStatusSelect);
document.addEventListener('turbo:load', initializeStatusSelect);
document.addEventListener('turbo:frame-load', initializeStatusSelect);

function initializeStatusSelect() {
  const typeSelect = document.getElementById('bug_type_select');
  const statusSelect = document.getElementById('status_select');

   const statusOptions = {
      bug: [
        { value: 'pending', text: 'Pending' },
        { value: 'started', text: 'Started' },
        { value: 'resolved', text: 'Resolved' }
      ],
      feature: [
        { value: 'pending', text: 'Pending' },
        { value: 'started', text: 'Started' },
        { value: 'completed', text: 'Completed' }
      ]
    };

  function updateStatusOptions() {
   
    const selectedType = typeSelect.value;
    console.log('Selected Type:', selectedType); // for debug
    statusSelect.innerHTML = ''; 
    
    if (statusOptions[selectedType]) {
      statusOptions[selectedType].forEach(function(option) {
        const opt = document.createElement('option');
        opt.value = option.value;
        console.log('Selected Value:', option.value);  // for debug
        opt.textContent = option.text;
        statusSelect.appendChild(opt);
      });
    } else {
      const opt = document.createElement('option');
      opt.value = '';
      opt.textContent = 'No options available';
      statusSelect.appendChild(opt);
    }
  }

  typeSelect.addEventListener('change', updateStatusOptions);
  updateStatusOptions();
}
