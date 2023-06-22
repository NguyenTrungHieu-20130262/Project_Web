
<!DOCTYPE html>
<html lang="en">

<head>
  <style>
    .loader {
      border: 5px solid #f3f3f3;
      border-radius: 50%;
      border-top: 5px solid #3498db;
      width: 50px;
      height: 50px;
      -webkit-animation: spin 2s linear infinite;
      animation: spin 2s linear infinite;
    }

    @-webkit-keyframes spin {
      0% { -webkit-transform: rotate(0deg); }
      100% { -webkit-transform: rotate(360deg); }
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<div id="loading" style=" display: none;background-color: rgba(28,25,25,0.32); position: fixed; top: 0; left: 0; right: 0; bottom: 0; z-index: 9999">
  <div style="display: flex;  justify-content: center; align-items: center; margin-top: 200px; " >
    <div style="display: flex; flex-direction: column;justify-content: center; align-items: center; padding: 15px 50px; ">

      <div class="loader"></div>
    </div>
  </div>
</div>

