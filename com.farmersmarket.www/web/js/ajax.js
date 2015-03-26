/* 
 * Cargar Ciudades en Pos de un Departamento
 */

var xmlHttp;
function getSubcategorias(idDepartamento) {

    if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        alert("El navegador no soporta Ajax!");
        return;
    }

    var url = "ajax/cargarCiudades.jsp?idDepartamento=" + idDepartamento;
    xmlHttp.onreadystatechange = resultadoCiudades;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);

}

function resultadoCiudades() {
    if (xmlHttp.readyState === 4) {
        document.getElementById("ruCiudad").innerHTML = xmlHttp.responseText;
    }
}
/* 
 *  Fin de cargar Ciudades en Pos de un Departamento
 */

/* 
 * Cargar Permisos en Pos de un Rol
 */

var xmlHttp;
function getPermisos(idRol) {

    if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        alert("El navegador no soporta Ajax!");
        return;
    }

    var url = "../ajax/cargarPermisos.jsp?idRol=" + idRol;
    xmlHttp.onreadystatechange = resultadoPermisos;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);

}

function resultadoPermisos() {
    if (xmlHttp.readyState === 4) {
        document.getElementById("sesionPermisos").innerHTML = xmlHttp.responseText;
    }
}
/* 
 *  Fin de cargar Permisos en Pos de un Rol
 */

/* 
 * Cargar Formulario de Ofertar Producto
 */

var xmlHttp;
function getFormOfertar(idProducoAso) {

    if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        alert("El navegador no soporta Ajax!");
        return;
    }

    var url = "../ajax/cargarPublicarOferta.jsp?idProducoAso=" + idProducoAso;
    xmlHttp.onreadystatechange = resultadoFormOfertar;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);

}

function resultadoFormOfertar() {
    if (xmlHttp.readyState === 4) {
        document.getElementById("formularioPublicarOferta").innerHTML = xmlHttp.responseText;
    }
}
/* 
 *  Fin de cargar Ciudades en Pos de un Departamento
 */