var req1;
var req2;

//Función para verificar si el documento ya está registrado anteriormente
function validarUsuarioYaRegistrado(campo) {
    if (campo.value === '')
        return false;

    var url = "PeticionesAjax?idUsuario=" + escape(campo.value);
    if (window.XMLHttpRequest) {
        req1 = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        req1 = new ActiveXObject("Microsoft.XMLHTTP");
    }
    req1.open("Get", url, true);
    req1.onreadystatechange = callbackIdUsuario;
    req1.send(null);
}
//Acciones que se desatan en pos de la verificación del documento
function callbackIdUsuario() {
    if (req1.readyState === 4) {
        if (req1.status === 200) {
            if (req1.responseText.toString() === "existe") {
                document.getElementById('ruDocumento').setAttribute('data-toggle', 'tooltip');
                document.getElementById('ruDocumento').setAttribute('data-original-title', 'Usuario ya registrado anteriormente, intente iniciar sesión o recuperar su contraseña');
                $(document).ready(function () {
                    // Initialize tooltip
                    $('[data-toggle="tooltip"]').tooltip({
                        placement: 'left'
                    });
                });
                document.getElementById('inpDocumento').setAttribute('class', 'form-group has-feedback has-error');
                document.getElementById('iconFeedbackDocumento').setAttribute('class', 'glyphicon glyphicon-remove form-control-feedback');
                document.getElementById('botonRegistro').setAttribute('disabled', 'true');
            } else if (req1.responseText.toString() === "noexiste") {
                document.getElementById('ruDocumento').removeAttribute('data-toggle', 'tooltip');
                document.getElementById('ruDocumento').removeAttribute('data-original-title');
                document.getElementById('inpDocumento').setAttribute('class', 'form-group has-feedback has-success');
                document.getElementById('iconFeedbackDocumento').setAttribute('class', 'glyphicon glyphicon-ok form-control-feedback');
                document.getElementById('botonRegistro').removeAttribute('disabled');
            }
        }
    }
}



//Función para verificar si el coreo ya está registrado anteriormente
function validaCorreoYaRegistrado(campo) {
    if (campo.value === '')
        return false;

    var url = "PeticionesAjax?correo=" + escape(campo.value);
    if (window.XMLHttpRequest) {
        req2 = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        req2 = new ActiveXObject("Microsoft.XMLHTTP");
    }
    req2.open("Get", url, true);
    req2.onreadystatechange = callbackCorreo;
    req2.send(null);
}
//Acciones que se desatan en pos de la verificación del documento
function callbackCorreo() {
    if (req2.readyState === 4) {
        if (req2.status === 200) {
            if (req2.responseText.toString() === "existe") {
                document.getElementById('ruCorreo').setAttribute('data-toggle', 'tooltip');
                document.getElementById('ruCorreo').setAttribute('data-original-title', 'Correo ya registrado anteriormente, intente iniciar sesión o recuperar su contraseña');
                $(document).ready(function () {
                    // Initialize tooltip
                    $('[data-toggle="tooltip"]').tooltip({
                        placement: 'left'
                    });
                });
                document.getElementById('inpCorreo').setAttribute('class', 'form-group has-feedback has-error');
                document.getElementById('iconFeedbackCorreo').setAttribute('class', 'glyphicon glyphicon-remove form-control-feedback');
                document.getElementById('ruCorreo2').setAttribute('disabled', 'true');
                document.getElementById('botonRegistro').setAttribute('disabled', 'true');
                document.getElementById('ruCorreo2').setAttribute('data-toggle', 'tooltip');
                document.getElementById('ruCorreo2').setAttribute('data-original-title', 'Se deshabilito el campo porque el correo anterior está registrado ya');
            } else if (req2.responseText.toString() === "noexiste") {
                document.getElementById('ruCorreo').removeAttribute('data-toggle', 'tooltip');
                document.getElementById('ruCorreo').removeAttribute('data-original-title');
                
                document.getElementById('ruCorreo2').removeAttribute('data-toggle', 'tooltip');
                document.getElementById('ruCorreo2').removeAttribute('data-original-title');
                
                
                document.getElementById('iconFeedbackCorreo').setAttribute('class', 'glyphicon glyphicon-ok form-control-feedback');
                document.getElementById('inpCorreo').setAttribute('class', 'form-group has-feedback has-success');
                document.getElementById('botonRegistro').removeAttribute('disabled');
                document.getElementById('ruCorreo2').removeAttribute('disabled');
            }
        }
    }
}