<!DOCTYPE html>
<html>
<head>
  <title>XML Generation</title>
</head>
<body>
  <form id="myForm">
    <label for="myField">Field:</label>
    <input type="text" id="myField" name="myField">
    <br><br>
    <button type="button" onclick="generateXML()">Generate XML</button>
  </form>

  <script>
    function generateXML() {
      // pegar valor do campo
      var fieldValue = document.getElementById("myField").value;

      // criar um xml
      var xmlContent = "<root><field>" + fieldValue + "</field></root>";

      // substituir strings xml para limpar o inicio e fim do arquivo
      xmlContent = xmlContent.replace(/<root>/g, "");
      xmlContent = xmlContent.replace(/<\/root>/g, "");
      xmlContent = xmlContent.replace(/<field>/g, "");
      xmlContent = xmlContent.replace(/<\/field>/g, "");

      // criar novo xml
      var xmlFile = new Blob([xmlContent], {type: "text/xml"});

      // criar um link para download
      var downloadLink = document.createElement("a");
      downloadLink.href = URL.createObjectURL(xmlFile);
      downloadLink.download = "data.xml";
      downloadLink.click();
    }
  </script>
</body>
</html>