//Función que cambia el estilo del input a visible
    //Toma el valor del texto del párrafo con id="text-description"
    //Lo muestra en la consola
    function cambiarParrafo(){
        document.getElementById("edit-description").style.display="block";
        let texto = document.getElementById("description").innerText;
        console.log(texto);
    };

    function myFunction2(valor){
        document.getElementById("description").innerText=valor;
    };
    
    //Controla si se presionó un enter
    function logMessage(message) {
        document.getElementById("description").innerText;
      };
      
    let textarea=document.getElementById("edit-description");

    textarea.addEventListener('keyup', (e) => {
        logMessage (`key "${e.key}" released [event: keyup]`);
        if (e.key == 'Enter') {
            document.getElementById("edit-description").style.display="none"
          }
    });

    //carga el contenido de un archivo de texto y lo muestra en el parrafo
    function showFile(input) {
        let file = input.files [0];
        alert('File name: $(file.name}'); //e.g my.png
        aler('Last modified: $(file.lastModified}'); // e.g 1552830408824

        let reader = new FileReader();
        reader.readAsText(file);
        reader.onload = function() {
            console.log(reader.result);
            document.getElementById("description").innerText=reader.result;
        };
        reader.onerror = function() {
            console.log(reader.error);
        };

    }

    /**/