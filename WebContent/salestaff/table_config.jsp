<style>

  /* Styling for the form table */
  table.form {
    width: 100%; /* Tăng chiều ngang form */
    max-width: 800px; /* Giới hạn chiều ngang tối đa */
    margin: 10px auto;
    border-collapse: collapse;
    background: #fff;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    overflow: hidden;
    padding: 20px;
    font-family: Inter, serif;
    font-size: 18px;
  }

  /* Add padding and styling to rows */
  table.form tr {
    display: flex;
    align-items: center;
  }

  /* Align labels and inputs */
  table.form td {
    padding: 10px;
    font-size: 20px;
  }

  /* Align labels to the right */
  table.form td[align="right"] {
    text-align: right;
    flex: 1;
    font-weight: bold;
  }

  /* Align inputs to the left */
  table.form td[align="left"] {
    text-align: left;
    flex: 2;
  }

  /* Style input fields */
  table.form input[type="text"],
  table.form input[type="email"],
  table.form input[type="password"],
  table.form input[type="number"],
  table.form select {
    width: 100%;
    padding: 10px;
    font-family: Inter, serif;
    font-size: 18px;
    border: 1px solid #ccc;
    border-radius: 5px;
    transition: all 0.3s;
  }

  table.form textarea {
    width: 100%;
    padding: 10px;
    font-family: 'Inter', serif;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    transition: all 0.3s ease;
    box-sizing: border-box;
  }

  /* Thiết kế chung cho ô input */
  table.form input[type="file"] {
    width: 100%;
    max-width: 300px; /* Giới hạn kích thước tối đa */
    padding: 5px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    transition: all 0.2s ease;
  }

  /* Thêm style cho hình ảnh preview */
  .image-preview {
    display: inline-block; /* Hiển thị hình ảnh nằm ngang */
    width: auto;
    height: 100px; /* Giới hạn chiều cao hình ảnh */
    margin-top: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    object-fit: contain; /* Giữ tỉ lệ và tránh crop ảnh */
  }

  /* Căn chỉnh các td và input */
  table.form td {
    vertical-align: middle; /* Căn giữa theo chiều dọc */
  }

  /* Responsive với màn hình nhỏ */
  @media (max-width: 768px) {
    table.form input[type="file"] {
      max-width: 100%;
    }
    .image-preview {
      max-height: 100px;
    }
  }


  /* Focus state for inputs */
  table.form input:focus,
  table.form select:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 4px rgba(0, 123, 255, 0.5);
  }

  /* Styling for buttons */
  table.form .btn {
    padding: 12px 30px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
    transition: all 0.3s;
  }

  table.form .btn-primary {
    background-color: #007bff;
    border: none;
    color: white;
  }

  table.form .btn-primary:hover {
    background-color: #0056b3;
  }

  table.form .btn-secondary {
    background-color: #6c757d;
    border: none;
    color: white;
  }

  table.form .btn-secondary:hover {
    background-color: #5a6268;
  }


</style>