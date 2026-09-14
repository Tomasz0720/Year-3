# PaperBeam Cheatsheet

```html
<!DOCTYPE html>
<html>
  <head>
    <title>PaperBeam Cheatsheet Example</title>
    <script src="paperbeam.min.js"></script>
    <style>
      #app { max-width: 1000px; margin: 0 auto; }
      .region { padding: 1rem; }
    </style>
  </head>
  <body>
    <div id="app">
      <!-- Two content regions to be arranged by PaperBeam -->
      <div class="region">Section One</div>
      <div class="region">Section Two</div>
    </div>

    <script>
      // Initialization
      PaperBeam.init('#app', {
        columns: { minWidth: 250, maxWidth: 400, gap: 16 },
        theme: 'default'
      });

      // Delayed update
      setTimeout(() => {
        PaperBeam.update({ theme: 'dark', userContext: true });
      }, 2000);

      // Destroy after 5 seconds
      setTimeout(() => {
        PaperBeam.destroy();
      }, 5000);
    </script>
  </body>
</html>
```