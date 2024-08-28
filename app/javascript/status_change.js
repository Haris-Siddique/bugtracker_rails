


const typeSelect = document.getElementById('bug_type_select');
const statusSelect = document.getElementById('status_select');

   console.log("function working") // for test

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