document.addEventListener('DOMContentLoaded', () => {
    const selectAllButton = document.getElementById('select-all');
    const deleteSelectedButton = document.getElementById('delete-selected');
    const searchButton = document.getElementById('search-btn');
    const commentButtons = document.querySelectorAll('.comment-btn');
    const registerButton = document.getElementById('register');
    const deleteButton = document.getElementById('delete');
    const closeButton = document.getElementById('close');
  
    selectAllButton.addEventListener('click', () => {
      document.querySelectorAll('.row-select').forEach(checkbox => {
        checkbox.checked = true;
      });
    });
  
    deleteSelectedButton.addEventListener('click', () => {
      const selected = document.querySelectorAll('.row-select:checked');
      if (selected.length > 0) {
        if (confirm('선택한 항목을 삭제하시겠습니까?')) {
          selected.forEach(item => item.closest('tr').remove());
        }
      } else {
        alert('삭제할 항목을 선택하세요.');
      }
    });
  
    searchButton.addEventListener('click', () => {
      const query = document.getElementById('search-bar').value;
      alert(`검색어: ${query}`);
    });
  
    commentButtons.forEach(button => {
      button.addEventListener('click', () => {
        document.querySelector('.comment-box').style.display = 'block';
      });
    });
  
    registerButton.addEventListener('click', () => {
      alert('댓글이 등록되었습니다.');
    });
  
    deleteButton.addEventListener('click', () => {
      document.querySelector('.comment-box textarea').value = '';
    });
  
    closeButton.addEventListener('click', () => {
      document.querySelector('.comment-box').style.display = 'none';
    });
  });
  