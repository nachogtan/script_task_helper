#!/bin/bash
# ==============================================================================
# TÍTULO: Asistente de Tareas de SysAdmin para Linux (APT-based)
# AUTOR: nachogtan
# VERSIÓN: 1.0
# DESCRIPCIÓN:
#   Este script interactivo ofrece un menú con utilidades comunes de
#   administración de sistemas (SysAdmin) para entornos basados en Debian/Ubuntu.
#   Incluye manejo de archivos, usuarios, grupos y gestión básica de paquetes.
#
# REQUISITOS:
#   - Estar ejecutándose en un sistema Linux basado en APT (Debian/Ubuntu).
#   - Tener permisos de 'sudo' para las operaciones de instalación o administración.
#
# FLAGS Y USO NO INTERACTIVO (CI/CD):
# ------------------------------------------------------------------------------
# --non-interactive, --ci:
#   Modo de Integración Continua (CI). El script imprime información básica
#   del sistema (OS, Bash version) y sale con código 0. Esto es ideal para
#   pruebas rápidas de ejecución o validación en pipelines CI.
#
# --version:
#   Muestra la versión del script.
#
# --help, -h:
#   Muestra este mensaje de ayuda.
# ------------------------------------------------------------------------------
#
# MEJORES PRÁCTICAS DE BASH:
# set -e: Sale inmediatamente si un comando falla.
# set -u: Sale si se intenta usar una variable no definida.
# set -o pipefail: El código de retorno de un pipeline es el del último
#                  comando que falló.
# ==============================================================================

set -euo pipefail

cat << "FIN_LOGO"
========================================================================================
                       Bienvenidos al asistente de tareas de linux
========================================================================================
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000             000000000000000000000000000000000000000
0000000000000000000000000000000000                  000000000000000000000000000000000000
000000000000000000000000000000000                    00000000000000000000000000000000000
00000000000000000000000000000000                      0000000000000000000000000000000000
0000000000000000000000000000000                        000000000000000000000000000000000
0000000000000000000000000000000                        900000000000000000000000000000000
0000000000000000000000000000000              00         00000000000000000000000000000000
0000000000000000000000000000000   0000     000000       00000000000000000000000000000000
0000000000000000000000000000000  0  00     0  100       00000000000000000000000000000000
0000000000000000000000000000000  0         0            00000000000000000000000000000000
00000000000000000000000000000000  0  0 00 000   0       30000000000000000000000000000000
00000000000000000000000000000000  000000000000000        0000000000000000000000000000000
00000000000000000000000000000000 0000000000000 800       0000000000000000000000000000000
00000000000000000000000000000000   40000000 6000          000000000000000000000000000000
00000000000000000000000000000000   60000000009 000         00000000000000000000000000000
0000000000000000000000000000000   00  0000  0000000         0000000000000000000000000000
000000000000000000000000000000   0000000000000000000         000000000000000000000000000
0000000000000000000000000000    800000000000000000004         00000000000000000000000000
000000000000000000000000000     000000000000000000000          1000000000000000000000000
0000000000000000000000000      0000000000000000000000            00000000000000000000000
000000000000000000000000      500000000000000000000000            0000000000000000000000
00000000000000000000000       00000000000000000000000007    0      000000000000000000000
00000000000000000000000   0  0000000000000000000000000000    2      00000000000000000000
0000000000000000000000   0  00000000000000000000000000000     0      0000000000000000000
0000000000000000000000  0  0000000000000000000000000000000     0      000000000000000000
000000000000000000000  0  00000000000000000000000000000000     0      000000000000000000
00000000000000000000   0  00000000000000000000000000000000     0      500000000000000000
0000000000000000000   0  000000000000000000000000000000000    8        00000000000000000
000000000000000000    3  000000000000000000000000000000000    0        00000000000000000
00000000000000000      0 000000000000000000000000000000000   000002    00000000000000000
000000000000000000  0    000000000000000000000000000000000 0        0 000000000000000000
00000000000000000 000000   0000000000000000000000000000 00             00000000000000000
000000000001     00000000     000000000000000000000000 0000         000 0000000000000000
0000000000 000000000000000      0000000000000000000000 00000      00000 0000000000000000
000000000 00000000000000000       00000000000000000000 000000000000000009000000000000000
00000000006000000000000000000      0000000000000000000 000000000000000000 70000000000000
0000000000 0000000000000000000     000000000000000000  000000000000000000000  0000000000
0000000000 00000000000000000000 0000000000000000000    0000000000000000000000 0000000000
000000000700000000000000000000001000000000000000       000000000000000000000 00000000000
00000000 000000000000000000000000     2223            000000000000000000 600000000000000
00000000 0000000000000000000000000                    000000000000000 000000000000000000
00000000000    0000000000000000000                    0000000000000 00000000000000000000
0000000000000000000  1000000000000  00000000000000000 00000000000 0000000000000000000000
0000000000000000000000000  0000  0000000000000000000009 000000 2000000000000000000000000
FIN_LOGO

echo ""
read -p "Presione [Enter] para comenzar"
clear

# Flags CI/CD
for arg in "$@"; do
    case "$arg" in
        --non-interactive|--ci)
            echo "CI mode: non-interactive run"
            echo "script: $(basename "$0")"
            echo "bash: $(bash --version | head -n1)"
            
            # Imprimir información básica del OS
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                echo "os: ${NAME:-Unknown} ${VERSION:-}"
            fi
            
            # Esto es lo más importante: Si estamos en modo CI, salimos con éxito.
            exit 0
            ;;
        --version)
            echo "$(basename "$0") version 1.0"
            exit 0
            ;;
        --help|-h)
            echo "Usage: $0 [--non-interactive|--ci] [--version] [--help]"
            echo "Cuando se ejecuta con --ci, el script imprime información básica y sale (ideal para pruebas de CI)."
            exit 0
            ;;
    esac
done



# Función de  verificación de programa. Comprueba si esta instalado, si no lo esta, lo instala
verificar_instalar() {
    local paquete="$1"

    # 1. Verificar si el comando existe
    if ! command -v "$paquete" &> /dev/null; then
        echo "========================================"
        echo "Preparando $paquete para su uso. Por favor, espere..."

        # 2. Intentar instalar de forma silenciosa.
        # -q/--quiet en update y -y -qq en install para minimizar la salida.
        # Redireccionamos toda la salida (stdout y stderr) a /dev/null
        if sudo apt-get update -qq > /dev/null 2>&1 && \
           sudo apt-get install -y -qq "$paquete" > /dev/null 2>&1; then
            # Solo se imprime este mensaje si la instalación es EXITOSA
            # (Puedes quitar esta línea si quieres CERO mensajes de éxito).
            echo "$paquete listo."
        else
            # Este mensaje CRÍTICO sí se muestra al usuario si la instalación Falla
            echo "ERROR: No se pudo instalar $paquete."
            echo "Asegúrate de tener permisos 'sudo' y conexión a internet."
            # Pausa para que el usuario pueda leer el error
            sleep 3 
        fi
        echo "========================================"
    fi
}


opcion=0

while [ $opcion != "30" ]; do
    clear
    echo "========================================================================================"
    echo "                                 MENÚ PRINCIPAL"
    echo "========================================================================================"
    echo "1. Muestra la versión de Linux"
    echo "2. Crear archivos con nano"
    echo "3. Crear archivos con gedit"
    echo "4. Instalar herramientas de red (samba)"
    echo "5. Instalar herramientas de grupos"
    echo "6. Visualizar carpetas y archivos"
    echo "7. Asignar permisos"
    echo "8. Visualiza calendario"
    echo "9. Visualizar vaquita simpática"
    echo "10. Manual de un comando"
    echo "11. Mostrar archivos sin posibilidad de editarlo"
    echo "12. Información de un archivo especifico"
    echo "13. Vincular archivos"
    echo "14. Reiniciar terminal"
    echo "15. Crear carpetas"
    echo "16. Crear archivos"
    echo "17. Crear usuarios"
    echo "18. Crear grupos"
    echo "19. Copiar carpetas"
    echo "20. Eliminar carpeta"
    echo "21. Eliminar archivo"
    echo "22. Agregar un usuario a un grupo"
    echo "23. Listar usuarios"
    echo "24. Listar grupos"
    echo "25. Actualizar el sistema"
    echo "26. Eliminar archivos temporales"
    echo "27. Obtener fecha"
    echo "28. Eliminar programas que no se utilizan"
    echo "29. Reiniciar el sistema"
    echo "30. Salir"
    echo ""
    read -p "Elige una opción del menú: " opcion
    echo "" 
    echo "----------------------------------------"

    case $opcion in 
        1)
            echo "Su version de linux es: "
            cat /etc/os-release
            ;;
        2)
            verificar_instalar nano

            echo "Escribe el nombre del archivo que quiere crear en nano"
            echo "[ctrl + o] para guardar el archivo. [ctrl + x] para salir"
            read -p "Nombre: " archivo_nano
            nano "$archivo_nano"
            ;;
        3)
            verificar_instalar gedit

            echo "Escribe el nombre del archivo que quieres crear en gedit"
            echo "Pulsa el boton [save] para guardar y x para cerrar la ventana"
            read -p "Nombre: " archivo_gedit
            gedit "$archivo_gedit"
            ;;
        4)
            verificar_instalar samba
            echo "Samba se has instalado correctamente!"
            ;;
        5)
            sudo apt update && sudo apt install build-essential -y
            echo "Herramientas de grupo instaladas"
            ;;
        6)
            echo "Visualiza carpeta y archivos"
            ls -l
            ;;
        7)
            read -p "¿A que archivo que archivo deseas asignarle permisos?: " archivo
            read -p "¿A quien deseas darle permisos?. Selecciona u, g, o (usuario=u, grupo=g u otros=o):" quien
            read -p "¿Que permisos deseas agregar?. Selecciona r, w, x (read=r, write=w, execute=x o combinacion como rwx):" permisos

            if [ ! -e "$archivo" ]; then
                echo "El archivo '$archivo' no existe"
                break
            fi

            if [[ "$quien" != "u" && "$quien" != "g" && "$quien" != "o" ]]; then
                echo "❌ Debes seleccionar una opción válida: u (usuario), g (grupo) o o (otros)."
                break
            fi

            sudo chmod "${quien}+${permisos}" "$archivo"
            echo "Puedes ver los cambios aplicados"
            ls -la "$archivo"
            ;;
        8)
            verificar_instalar ncal
            cal
            ;;
        9)
            verificar_instalar cowsay

            read -p "¿Que quieres que diga la vaca? " frase
            cowsay "$frase"
            ;;
        10)
            read -p "¿El manual de que comando quieres ver? " comando

            if ! command -v "$comando" >/dev/null 2>&1; then
                echo "El comando '$comando' no existe e el sistema o no está instalado"
                break
            else
                man "$comando"
            fi

            ;;
        11)
            read -p "¿Que archivo quieres leer? " archivo

            if [ ! -e "$archivo" ]; then
                echo "El archivo '$archivo' no existe!"
            elif [ ! -f "$archivo" ]; then
                echo "'$archivo' no es un archivo regular"
            else
                cat "$archivo"
            fi
            ;;
        12)
            read -p "Consulta la información de un archivo: " arch1
            if [ ! -e "$arch1" ]; then
                echo "'$arch1' no existe"
            elif [ ! -f "$arch1" ]; then
                echo "'$arch1' no es un archivo regular"
            else
                stat "$arch1"
            fi
            ;;
        13)
            read -p "¿Que archivo quieres vincular " arch_vinc
            read -p "¿A que directorio deseas vincularlo? " dir_vinc

            if [ ! -e "$arch_vinc" ]; then
                echo "El archivo '$arch_vinc' no existe."
                break
            elif [ ! -f "$arch_vinc" ]; then
                echo "'$arch_vinc' no es un archivo regular."
                break
            elif [ ! -d "$dir_vinc" ]; then
                echo "El directorio '$dir_vinc' no existe."
                break
            else
                nombre_archivo=$(basename "$arch_vinc")
                ln -s "$arch_vinc" "$dir_vinc/$nombre_archivo"
                echo "Enlace simbólico creado: '$dir_vinc/$nombre_archivo' → '$arch_vinc'"
                ls -l "$dir_vinc/$nombre_archivo"
            fi
            ;;
        14)
            echo "Limpieza de terminal"
            clear
            ;;
        15)
            echo "Crear un directorio"
            read -p "¿Que nombre quieres para tu directorio? " dirname
            mkdir "$dirname"
            ls -l
            ;;
        16)
            echo "Crea un archivo"
            read -p "¿Que nombre quieres darle a tu archivo? " nombre_archivo
            read -p "¿Que extension quieres que tenga (tipo de archivo)? " extension
            touch "$nombre_archivo.$extension"
            ls -l
            ;;
        17)
            echo "Agrega usuario"
            read -p "¿Que usuario quieres agregar? " usuario
            sudo adduser "$usuario"
            ;;
        18)
            echo "Agrega un grupo"
            read -p "¿Que grupo quieres crear? " grupo
            sudo addgroup "$grupo"
            ;;
        19)
            echo "Copia un directorio"
            read -p "¿Que directorio deseas copiar? " dir_origen
            read -p "¿Donde deseas copiarlo? " dir_destino

            if [ ! -d "$dir_origen" ]; then
                echo "El directorio de origen no existe"
            else
                cp -r "$dir_origen" "$dir_destino"
            fi
            echo "Directorio copiado exitosamente"
            ;;
        20)
            echo "Elimina directorio"
            read -p "¿Que directorio deseas aliminar? " dir_eliminar
            if [ ! -d "$dir_eliminar" ]; then
                echo "El directorio no existe"
            else
                rm -ri "$dir_eliminar"
            fi
            echo "Directorio eliminado exitosamente"
            ;;
        21)
            echo "Elimina archivo"
            read -p "¿Que archivo deseas aliminar? " arch_eliminar
            if [ ! -f "$arch_eliminar" ]; then
                echo "El archivo no existe"
            else
                rm "$arch_eliminar"
            fi
            ;;
        22)
            echo "Agrega usuario a grupo"
            read -p "¿Que usuario quieres agregar? " user_agregar
            read -p "¿A que grupo lo quieres agregar? " grupo_agregar
            sudo usermod -aG "$grupo_agregar" "$user_agregar"
            ;;
        23)
            echo "Listando usuarios"
            cat /etc/passwd
            ;;
        24)
            exho "Listando grupos"
            cat /etc/group
            ;;
        25)
            echo "Actualizando el sistema"
            sudo apt update && sudo apt upgrade -y
            ;;
        26)
            echo "Elimina archivos temporales"
            sudo rm -r /tmp/*
            ;;
        27)
            echo "La fecha actual es: "
            date
            ;;
        28)
            echo "Eliminando aplicaciones innecesarias"
            sudo apt autoremove
            ;;
        29)
            echo "Reiniciando el sistema"
            sudo reboot
            ;;
        30)
            echo "Au revoir"
            exit
            ;;
    esac

    echo ""
    read -p "Presiona [Enter] para continuar"
done