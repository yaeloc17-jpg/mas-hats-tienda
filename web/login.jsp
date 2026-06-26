<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión - Gorras</title>
        <style>
            body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 50px; }
            .form-login { background: white; padding: 30px; border-radius: 8px; max-width: 400px; margin: 0 auto; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
            .campo { margin-bottom: 15px; }
            .campo label { display: block; margin-bottom: 5px; font-weight: bold; }
            .campo input { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
            .btn { background-color: #0078d4; color: white; border: none; padding: 12px; width: 100%; cursor: pointer; font-size: 16px; border-radius: 4px; }
            .btn:hover { background-color: #005a9e; }
            .registro-link { text-align: center; margin-top: 20px; font-size: 14px; }
            .registro-link a { color: #0078d4; text-decoration: none; font-weight: bold; cursor: pointer; }
            .error-msg { color: #d93025; font-size: 14px; margin-bottom: 15px; display: none; text-align: center; font-weight: bold; }
            .success-msg { color: #188038; font-size: 14px; margin-bottom: 15px; display: none; text-align: center; font-weight: bold; }
            .loading { background-color: #555 !important; cursor: not-allowed; }
        </style>
    </head>
    <body>

        <div class="form-login" id="vistaLogin">
            <h2 id="tituloForm">Ingresar a la Tienda</h2>
            
            <div class="error-msg" id="errorLogin">Correo o contraseña incorrectos.</div>
            <div class="success-msg" id="infoRegistro"></div>

            <form onsubmit="procesarLogin(event)">
                <div class="campo">
                    <label>Correo Electrónico:</label>
                    <input type="email" id="loginCorreo" required placeholder="ejemplo@correo.com">
                </div>
                <div class="campo">
                    <label>Contraseña:</label>
                    <input type="password" id="loginPassword" required placeholder="******">
                </div>
                <button type="submit" id="btnIngresar" class="btn">Ingresar</button>
            </form>
            
            <div class="registro-link">
                ¿Eres nuevo? <a onclick="mostrarRegistro(true)">Crear cuenta nueva</a>
            </div>
        </div>

        <div class="form-login" id="vistaRegistro" style="display: none;">
            <h2>Crear Cuenta Nueva</h2>
            <div class="error-msg" id="errorRegistro">Este correo ya está registrado.</div>
            
            <form onsubmit="procesarRegistro(event)">
                <div class="campo">
                    <label>Nombre Completo:</label>
                    <input type="text" id="regNombre" required placeholder="Tu Nombre">
                </div>
                <div class="campo">
                    <label>Correo Electrónico:</label>
                    <input type="email" id="regCorreo" required placeholder="correo@ejemplo.com">
                </div>
                <div class="campo">
                    <label>Contraseña:</label>
                    <input type="password" id="regPassword" required placeholder="Mínimo 6 caracteres">
                </div>
                <button type="submit" class="btn" style="background-color: #188038;">Registrarse</button>
            </form>
            
            <div class="registro-link">
                ¿Ya tienes cuenta? <a onclick="mostrarRegistro(false)">Regresar al Login</a>
            </div>
        </div>

        <script>
            // Creamos un usuario Administrador por defecto si la simulación está vacía
            if (!localStorage.getItem("admin@gorras.com")) {
                localStorage.setItem("admin@gorras.com", JSON.stringify({ password: "123", nombre: "Admin" }));
            }

            // Alternar entre pantallas
            function mostrarRegistro(irARegistro) {
                document.getElementById("errorLogin").style.display = "none";
                document.getElementById("errorRegistro").style.display = "none";
                document.getElementById("infoRegistro").style.display = "none";
                
                if(irARegistro) {
                    document.getElementById("vistaLogin").style.display = "none";
                    document.getElementById("vistaRegistro").style.display = "block";
                } else {
                    document.getElementById("vistaLogin").style.display = "block";
                    document.getElementById("vistaRegistro").style.display = "none";
                }
            }

            // REGISTRO: Guarda los datos de forma "real" en el navegador
            function procesarRegistro(event) {
                event.preventDefault();
                const correo = document.getElementById("regCorreo").value.trim().toLowerCase();
                const password = document.getElementById("regPassword").value;
                const nombre = document.getElementById("regNombre").value;

                // Validar si ya existe
                if (localStorage.getItem(correo)) {
                    document.getElementById("errorRegistro").style.display = "block";
                    return;
                }

                // Guardar en la "Base de Datos" del navegador
                const datosUsuario = { password: password, nombre: nombre };
                localStorage.setItem(correo, JSON.stringify(datosUsuario));

                // Limpiar campos y volver al login con éxito
                document.getElementById("regCorreo").value = "";
                document.getElementById("regPassword").value = "";
                document.getElementById("regNombre").value = "";
                
                mostrarRegistro(false);
                
                const msg = document.getElementById("infoRegistro");
                msg.innerText = "¡Cuenta registrada con éxito! Ya puedes iniciar sesión.";
                msg.style.display = "block";
                document.getElementById("loginCorreo").value = correo;
            }

            // LOGIN: Valida contra la "Base de Datos" simulada
            function procesarLogin(event) {
                event.preventDefault();
                document.getElementById("errorLogin").style.display = "none";
                document.getElementById("infoRegistro").style.display = "none";

                const correo = document.getElementById("loginCorreo").value.trim().toLowerCase();
                const password = document.getElementById("loginPassword").value;

                // Buscar usuario en la base de datos simulada
                const usuarioGuardado = localStorage.getItem(correo);

                if (usuarioGuardado) {
                    const datos = JSON.parse(usuarioGuardado);
                    
                    // Validar contraseña exacta
                    if (datos.password === password) {
                        const boton = document.getElementById("btnIngresar");
                        boton.innerText = "Conectando con el servidor...";
                        boton.classList.add("loading");
                        boton.disabled = true;

                        // Retraso de 1.2 segundos para simular respuesta del servidor
                        setTimeout(() => {
                            window.location.href = "catalogo.jsp";
                        }, 1200);
                        return;
                    }
                }

                // Si no existe o la contraseña está mal
                document.getElementById("errorLogin").style.display = "block";
            }
        </script>
    </body>
</html>